require 'rails_helper'

RSpec.describe Commands::GroqCompletions do
  describe '#execute' do
    let(:prompt) { "Generate a step-by-step recipe for a dish using the following ingredients: chicken, garlic, onions, tomatoes, spices." }
    let(:model) { 'llama-3.3-70b-versatile' }
    let(:client) { GroqClient.new }

    subject { described_class.new(prompt, model: model, client: client) }

    let!(:result) { subject.execute }

    it 'returns a valid JSON response with the correct schema' do
      expect(result).to include('choices')
      expect(result['choices']).to be_an(Array)
      expect(result['choices'].first).to include('message')
      expect(result['choices'].first['message']).to include('content')
    end

    it 'verifies if the response content is a step-by-step recipe' do
      content = result['choices'].first['message']['content']

      verification_prompt = "Is the following text a valid step-by-step recipe? Reply only with 'yes' or 'no'. Text: #{content}"

      verification_command = described_class.new(verification_prompt, model: model, client: client)
      verification_result = verification_command.execute

      verification_content = verification_result['choices'].first['message']['content']
      expect(verification_content.downcase).to include('yes')
    end
  end
end
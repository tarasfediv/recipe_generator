require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) { { recipe: { ingredients: ['chicken', 'garlic', 'onions'] } } }
    let(:empty_params) { { recipe: { ingredients: '' } } }

    context 'with valid parameters' do
      it 'verifies if the response content is a step-by-step recipe' do
        post :create, params: valid_params

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)
        expect(body).to include('recipe')
        expect(body['recipe']).to be_a(String)
        expect(body['recipe']).to_not be_empty

        verification_prompt = "Is the following text a valid step-by-step recipe? Reply only with 'yes' or 'no'. Text: #{body['recipe']}"
        verification_response = Commands::GroqCompletions.new(verification_prompt).execute
        verification_content = verification_response['choices'].first['message']['content']

        expect(verification_content.downcase.strip).to include('yes')
      end
    end

    context 'with empty parameters' do
      it 'returns an error when ingredients are empty' do
        post :create, params: empty_params

        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body).to include('errors')
        expect(body['errors']).to include('Ingredients cannot be empty.')
      end
    end

    context 'with invalid parameters' do
      it 'raises a ParameterMissing error' do
        expect {
          post :create, params: {}
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
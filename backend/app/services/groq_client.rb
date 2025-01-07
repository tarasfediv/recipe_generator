# require 'httparty'

class GroqClient
  include HTTParty
  base_uri ENV.fetch('GROQ_API_URL', 'https://api.groq.com/openai/v1')

  MODELS = {
    versatile: 'llama-3.3-70b-versatile',
    instant: 'llama-3.1-8b-instant',
  }.freeze

  def initialize(api_key = ENV.fetch('GROQ_API_KEY'))
    @headers = {
      'Authorization' => "Bearer #{api_key}",
      'Content-Type' => 'application/json'
    }
  end

  def post(endpoint, body = {})
    response = self.class.post(endpoint, headers: @headers, body: body.to_json)
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      raise StandardError, "Groq API Error: #{response.code} - #{response.body}"
    end
  end
end
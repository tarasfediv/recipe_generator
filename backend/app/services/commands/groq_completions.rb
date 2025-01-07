module Commands
  class GroqCompletions < BaseCommand
    def initialize(prompt, model: GroqClient::MODELS[:versatile], client: GroqClient.new)
      super(client)
      @prompt = prompt
      @model = model
    end

    def execute
      @client.post('/chat/completions', body)
    end

    private 

    def body
      {
        model: @model,
        messages:[
          {
            role: 'user',
            content: @prompt
          }
        ]
      }
    end
  end
end

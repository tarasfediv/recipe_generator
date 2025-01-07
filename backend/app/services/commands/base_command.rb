module Commands
  class BaseCommand
    def initialize(client = GroqClient.new)
      @client = client
    end

    def execute
      raise NotImplementedError, 'Subclasses must implement the execute method'
    end
  end
end
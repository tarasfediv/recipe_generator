module Prompts
  class PromptFactory
    def self.create_prompt(type, options = {})
      case type
      when :recipe
        RecipePromptBuilder.new(**options).build
      else
        raise ArgumentError, "Unknown prompt type: #{type}"
      end
    end
  end
end
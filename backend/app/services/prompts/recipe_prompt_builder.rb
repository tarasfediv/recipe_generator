module Prompts
  class RecipePromptBuilder
    def initialize(ingredients: [])
      @ingredients = ingredients
      @prompt = ''
    end

    def add_intro
      @prompt += 'Generate a step-by-step recipe for a dish '
      self
    end

    def add_ingredients
      if @ingredients.any?
        @prompt += "using the following ingredients: #{@ingredients.join(', ')}."
      else
        @prompt += "using ingredients of your choice."
      end
      self
    end

    def build
      add_intro
      add_ingredients
      @prompt
    end
  end
end
module Api
  module V1
    class RecipesController < ApplicationController
      def create
        form = RecipeForm.new(recipe_params)

        if form.valid?
          prompt = Prompts::PromptFactory.create_prompt(:recipe, ingredients: form.ingredients)
          response = Commands::GroqCompletions.new(prompt).execute

          render json: { recipe: extract_recipe_steps(response) }, status: :ok
        else
          render json: { errors: form.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def extract_recipe_steps(response)
        response.dig('choices', 0, 'message', 'content') || 'No recipe generated.'
      end

      def recipe_params
        params.require(:recipe).permit(ingredients: [])
      end
    end
  end
end
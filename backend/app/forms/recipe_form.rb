class RecipeForm
  include ActiveModel::Model

  attr_accessor :ingredients

  validates :ingredients, presence: true
  validate :ingredients_must_not_be_empty

  private

  def ingredients_must_not_be_empty
    if ingredients.blank? || !ingredients.is_a?(Array) || ingredients.empty?
      errors.add(:ingredients, 'cannot be empty.')
    end
  end
end
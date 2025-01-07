import React, { useState } from "react";
import axios from "axios";
import "./App.css";

function App() {
  const [ingredients, setIngredients] = useState([""]); // Start with one empty ingredient
  const [recipe, setRecipe] = useState(null);
  const [error, setError] = useState(null);

  const handleIngredientChange = (index, value) => {
    const newIngredients = [...ingredients];
    newIngredients[index] = value;
    setIngredients(newIngredients);
  };

  const addIngredient = () => {
    setIngredients([...ingredients, ""]);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    setRecipe(null);

    try {
      const response = await axios.post("http://localhost:3000/api/v1/recipes", {
        recipe: { ingredients },
      });
      setRecipe(response.data.recipe);
    } catch (err) {
      setError(err.response?.data?.errors || "An error occurred while generating the recipe.");
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <div className="container">
          <div className="form-container">
            <h1>Recipe Generator</h1>
            <form onSubmit={handleSubmit}>
              {ingredients.map((ingredient, index) => (
                <div key={index}>
                  <input
                    type="text"
                    value={ingredient}
                    onChange={(e) => handleIngredientChange(index, e.target.value)}
                    placeholder={`Ingredient ${index + 1}`}
                  />
                </div>
              ))}
              <button type="button" onClick={addIngredient}>
                Add Ingredient
              </button>
              <button type="submit">Generate Recipe</button>
            </form>
            {error && <p style={{ color: "red" }}>{error}</p>}
          </div>
          <div className="result-container">
            {recipe ? (
              <div>
                <h2>Generated Recipe</h2>
                <pre>{recipe}</pre>
              </div>
            ) : (
              <p>No recipe generated yet</p>
            )}
          </div>
        </div>
      </header>
    </div>
  );
}

export default App;
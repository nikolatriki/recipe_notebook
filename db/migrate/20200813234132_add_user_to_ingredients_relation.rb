class AddUserToIngredientsRelation < ActiveRecord::Migration[6.0]
  def change
    add_reference :ingredients, :user, foreign_key: true
  end
end

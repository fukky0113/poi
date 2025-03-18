class AddPointsToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :point, :text
  end
end

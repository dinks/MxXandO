class CreateGameCells < ActiveRecord::Migration
  def change
    create_table :game_cells do |t|
      t.belongs_to              :game
      t.belongs_to              :user

      t.timestamps
    end
  end
end

class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer         :player_x
      t.integer         :player_o

      t.string          :state
      t.integer         :won_by

      t.timestamps
    end
  end
end

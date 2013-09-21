class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string            :uuid
      t.string            :name
      t.string            :state
      t.boolean           :online

      t.timestamps
    end
  end
end

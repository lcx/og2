class CreateFactories < ActiveRecord::Migration[7.0]
  def change
    create_table :factories do |t|
      t.integer :player_id
      t.integer :kind
      t.integer :level, default: 1
      t.integer :resources, default: 0
      t.timestamps
    end
  end
end

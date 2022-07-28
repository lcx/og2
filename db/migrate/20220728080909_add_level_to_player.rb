class AddLevelToPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :level, :integer, default: 1
  end
end

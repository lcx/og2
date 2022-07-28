class AddUpgradeStartedAtToFactory < ActiveRecord::Migration[7.0]
  def change
    add_column :factories, :upgrade_until, :timestamp
  end
end

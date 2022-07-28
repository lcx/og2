class CreateFactoryRates < ActiveRecord::Migration[7.0]
  def change
    create_table :factory_rates do |t|
      t.integer :level
      t.integer :kind
      t.integer :production
      t.integer :upgrade_duration
      t.json :upgrade_cost

      t.timestamps
    end
  end
end

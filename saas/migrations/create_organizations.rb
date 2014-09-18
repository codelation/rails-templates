class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.money  :account_balance
      t.string :name
      t.string :time_zone

      t.timestamps
    end
  end
end

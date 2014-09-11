class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.string  :name
      t.boolean :active, default: false
      t.money   :price
      t.integer :interval, default: 0
      t.integer :interval_count
      t.integer :trial_period_days
      t.string  :reference_code

      t.timestamps
    end
  end
end

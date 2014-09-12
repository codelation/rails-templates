class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.string :reference_code

      t.money :price
      t.money :price_per_user
      t.money :setup_price

      t.boolean :active,            default: false
      t.integer :account_type,      default: 0
      t.integer :interval,          default: 0
      t.integer :interval_count,    default: 1
      t.integer :trial_period_days, default: 0

      t.timestamps
    end
  end
end

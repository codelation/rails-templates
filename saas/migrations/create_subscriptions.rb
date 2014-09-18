class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer  :subscription_plan_id, index: true

      t.integer  :subscriber_id, index: true
      t.string   :subscriber_type

      t.integer  :status, default: 0
      t.boolean  :cancel_at_period_end, default: true
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.datetime :canceled_at
      t.datetime :ended_at
      t.datetime :trial_ends_at

      t.timestamps
    end
  end
end

class CreateStripeCards < ActiveRecord::Migration
  def change
    create_table :stripe_cards do |t|
      t.string  :stripe_id
      t.string  :stripe_customer_id
      t.string  :stripe_token
      t.string  :last4
      t.string  :brand
      t.integer :exp_month
      t.integer :exp_year

      t.integer :subscriber_id, index: true
      t.string  :subscriber_type

      t.timestamps
    end
  end
end

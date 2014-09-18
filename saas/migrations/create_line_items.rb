class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :invoice, index: true
      t.integer :quantity
      t.string :description
      t.money :amount

      t.timestamps
    end
  end
end

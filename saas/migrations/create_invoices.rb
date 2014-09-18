class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :due_at
      t.belongs_to :subscriber, index: true, polymorphic: true
      t.money :total
      t.datetime :period_start
      t.datetime :period_end

      t.timestamps
    end
  end
end

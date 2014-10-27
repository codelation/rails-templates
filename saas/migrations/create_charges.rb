class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer    :status
      t.belongs_to :invoice,        index: true
      t.belongs_to :payment_method, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end

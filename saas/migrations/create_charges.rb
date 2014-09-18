class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :status
      t.belongs_to :invoice, index: true

      t.timestamps
    end
  end
end

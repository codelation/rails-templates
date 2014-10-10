class CreateOmniAuthProviders < ActiveRecord::Migration
  def change
    create_table :omni_auth_providers do |t|
      t.string  :name
      t.string  :uid
      t.integer :subscriber_id, index: true
      t.string  :subscriber_type

      t.timestamps
    end
  end
end

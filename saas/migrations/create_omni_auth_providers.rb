class CreateOmniAuthProviders < ActiveRecord::Migration
  def change
    create_table :omni_auth_providers do |t|
      t.jsonb   :auth_data
      t.string  :name
      t.integer :subscriber_id, index: true
      t.string  :subscriber_type
      t.string  :uid

      t.timestamps
    end
  end
end

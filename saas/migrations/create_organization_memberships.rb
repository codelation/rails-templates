class CreateOrganizationMemberships < ActiveRecord::Migration
  def change
    create_table :organization_memberships do |t|
      t.integer :organization_id, index: true
      t.integer :user_id, index: true
      t.integer :organization_role_id, index: true

      t.timestamps
    end
  end
end

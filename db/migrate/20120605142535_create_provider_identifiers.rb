class CreateProviderIdentifiers < ActiveRecord::Migration
  def change
    create_table :provider_identifiers do |t|
      t.string  :provider_id
      t.string  :license_number, limit: 20
      t.string  :additional_info
      t.string  :identifier
      t.string  :state, limit: 2
      t.string  :type_code, limit: 2
      t.timestamps
    end
  end
end

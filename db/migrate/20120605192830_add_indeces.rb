class AddIndeces < ActiveRecord::Migration
  def change
    add_index :providers, :npi
    add_index :providers, [:provider_last_name, :provider_first_name]
    add_index :provider_identifiers, :provider_id
    add_index :provider_identifiers, :identifier
    add_index :provider_taxonomies, :provider_id
    add_index :provider_taxonomies, :code
  end
end

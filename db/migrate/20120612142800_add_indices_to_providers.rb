class AddIndicesToProviders < ActiveRecord::Migration
  def change
    add_index :providers, :provider_organization_name
    add_index :providers, [:provider_mailing_address_state_name, :provider_business_mailing_address_city_name, :provider_business_mailing_address_postal_code], :name => "index_providers_on_state_city_zip"
    add_index :providers, [:provider_business_practice_location_address_state_name, :provider_business_practice_location_address_city_name, :provider_business_practice_location_address_postal_code], :name => "index_providers_on_organization_state_city_zip"
    add_index :providers, :provider_business_mailing_address_telephone_number, :name => "index_providers_on_telephone"
    add_index :providers, :provider_business_practice_location_address_telephone_number, :name => "index_providers_on_practice_telephone"
    add_index :providers, :authorized_official_telephone_number, :name => "index_providers_on_official_telephone"
  end
end
class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer  :npi
      t.string   :entity_type_code
      t.string   :replacement_npi
      t.string   :employer_identification_number,                                limit: 9
      t.string   :provider_organization_name,                                    limit: 70
      t.string   :provider_last_name,                                            limit: 35
      t.string   :provider_first_name,                                           limit: 20
      t.string   :provider_middle_name,                                          limit: 20
      t.string   :provider_name_prefix_text,                                     limit: 5
      t.string   :provider_name_suffix_text,                                     limit: 5
      t.string   :provider_credential_text,                                      limit: 20
      t.string   :provider_other_organization_name,                              limit: 70
      t.string   :provider_other_organization_name_type_code,                    limit: 1
      t.string   :provider_other_last_name,                                      limit: 35
      t.string   :provider_other_first_name,                                     limit: 20
      t.string   :provider_other_middle_name,                                    limit: 20
      t.string   :provider_other_name_prefix_text,                               limit: 5
      t.string   :provider_other_name_suffix_text,                               limit: 5
      t.string   :provider_other_credential_text,                                limit: 20
      t.string  :provider_other_last_name_type_code,                            limit: 1
      t.string   :provider_first_line_business_address,                          limit: 55
      t.string   :provider_first_line_business_address,                          limit: 55
      t.string   :provider_business_mailing_address_city_name,                   limit: 40
      t.string   :provider_mailing_address_state_name,                           limit: 40
      t.string   :provider_business_mailing_address_postal_code,                 limit: 20
      t.string   :provider_business_mailing_address_country_code,                 limit: 2
      t.string   :provider_business_mailing_address_telephone_number,            limit: 20
      t.string   :provider_business_mailing_address_fax_number,                  limit: 20
      t.string   :provider_first_line_business_practice_location_address,        limit: 55
      t.string   :provider_second_line_business_practice_location_address,       limit: 55
      t.string   :provider_business_practice_location_address_city_name,         limit: 40
      t.string   :provider_business_practice_location_address_state_name,        limit: 40
      t.string   :provider_business_practice_location_address_postal_code,       limit: 20
      t.string   :provider_business_practice_location_address_country_code,      limit: 2
      t.string   :provider_business_practice_location_address_telephone_number,  limit: 20
      t.string   :provider_business_practice_location_address_fax_number,        limit: 20
      t.string   :provider_enumeration_date
      t.string   :last_update_date
      t.string   :npi_deactivation_reason_code,                                  limit: 2
      t.string   :npi_deactivation_date
      t.string   :npi_reactivation_date
      t.string   :provider_gender_code,                                          limit: 1
      t.string   :authorized_official_last_name,                                 limit: 35
      t.string   :authorized_official_first_name,                                limit: 20
      t.string   :authorized_official_middle_name,                               limit: 20
      t.string   :authorized_official_title_or_position,                         limit: 35
      t.string   :authorized_official_telephone_number,                          limit: 20
      t.string   :is_sole_proprietor,                                            limit: 1
      t.string   :is_organization_subpart,                                       limit: 1
      t.string   :parent_organization_lbn,                                       limit: 70
      t.string   :parent_organization_tin,                                       limit: 9
      t.string   :authorized_official_name_prefix_text,                          limit: 5
      t.string   :authorized_official_name_suffix_text,                          limit: 5
      t.string   :authorized_official_credential_text,                           limit: 20

      t.timestamps
    end
  end
end

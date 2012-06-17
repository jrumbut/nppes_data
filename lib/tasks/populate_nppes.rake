require 'csv'

desc "Populate NPPES from file."
task :populate_nppes, [:file] => :environment do |t,args|
  begin
    parse_file(args.file)
  rescue => ex
    $stderr.puts [ex.message, *ex.backtrace]
  end
end

def parse_file(file)
  i, start = 0, Time.now

  CSV.foreach(file, :headers => true, :header_converters => :symbol) do |row|
    process_row(row); i += 1
    puts "Completed #{i} in #{Time.now - start}" if i % 1000 == 0
  end
  puts "Completed #{i} in #{Time.now - start}"
end

def process_row(row)
  provider = Provider.where(:npi => row[:npi]).first_or_initialize

  provider.npi                                                            = row[:npi]
  provider.entity_type_code                                               = row[:entity_type_code]
  provider.replacement_npi                                                = row[:replacement_npi]
  provider.employer_identification_number                                 = row[:employer_identification_number_ein]
  provider.provider_organization_name                                     = row[:provider_organization_name_legal_business_name]
  provider.provider_last_name                                             = row[:provider_last_name_legal_name]
  provider.provider_first_name                                            = row[:provider_first_name]
  provider.provider_middle_name                                           = row[:provider_middle_name]
  provider.provider_name_prefix_text                                      = row[:provider_name_prefix_text]
  provider.provider_name_suffix_text                                      = row[:provider_name_suffix_text]
  provider.provider_credential_text                                       = row[:provider_credential_text]
  provider.provider_other_organization_name                               = row[:provider_other_organization_name]
  provider.provider_other_organization_name_type_code                     = row[:provider_other_organization_name_type_code]
  provider.provider_other_last_name                                       = row[:provider_other_last_name]
  provider.provider_other_first_name                                      = row[:provider_other_first_name]
  provider.provider_other_middle_name                                     = row[:provider_other_middle_name]
  provider.provider_other_name_prefix_text                                = row[:provider_other_name_prefix_text]
  provider.provider_other_name_suffix_text                                = row[:provider_other_name_suffix_text]
  provider.provider_other_credential_text                                 = row[:provider_other_credential_text]
  provider.provider_other_last_name_type_code                             = row[:provider_other_last_name_type_code]
  provider.provider_first_line_business_address                           = row[:provider_first_line_business_mailing_address]
  provider.provider_business_mailing_address_city_name                    = row[:provider_business_mailing_address_city_name]
  provider.provider_mailing_address_state_name                            = row[:provider_business_mailing_address_state_name]
  provider.provider_business_mailing_address_postal_code                  = row[:provider_business_mailing_address_postal_code]
  provider.provider_business_mailing_address_country_code                 = row[:provider_business_mailing_address_country_code_if_outside_us]
  provider.provider_business_mailing_address_telephone_number             = row[:provider_business_mailing_address_telephone_number]
  provider.provider_business_mailing_address_fax_number                   = row[:provider_business_mailing_address_fax_number]
  provider.provider_first_line_business_practice_location_address         = row[:provider_first_line_business_practice_location_address]
  provider.provider_second_line_business_practice_location_address        = row[:provider_second_line_business_practice_location_address]
  provider.provider_business_practice_location_address_city_name          = row[:provider_business_practice_location_address_city_name]
  provider.provider_business_practice_location_address_state_name         = row[:provider_business_practice_location_address_state_name]
  provider.provider_business_practice_location_address_postal_code        = row[:provider_business_practice_location_address_postal_code]
  provider.provider_business_practice_location_address_country_code       = row[:provider_business_practice_location_address_country_code_if_outside_us]
  provider.provider_business_practice_location_address_telephone_number   = row[:provider_business_practice_location_address_telephone_number]
  provider.provider_business_practice_location_address_fax_number         = row[:provider_business_practice_location_address_fax_number]
  provider.provider_enumeration_date                                      = row[:provider_enumeration_date]
  provider.last_update_date                                               = row[:last_update_date]
  provider.npi_deactivation_reason_code                                   = row[:npi_deactivation_reason_code]
  provider.npi_deactivation_date                                          = row[:npi_deactivation_date]
  provider.npi_reactivation_date                                          = row[:npi_reactivation_date]
  provider.provider_gender_code                                           = row[:provider_gender_code]
  provider.authorized_official_last_name                                  = row[:authorized_official_last_name]
  provider.authorized_official_first_name                                 = row[:authorized_official_first_name]
  provider.authorized_official_middle_name                                = row[:authorized_official_middle_name]
  provider.authorized_official_title_or_position                          = row[:authorized_official_title_or_position]
  provider.authorized_official_telephone_number                           = row[:authorized_official_telephone_number]
  provider.is_sole_proprietor                                             = row[:is_sole_proprietor]
  provider.is_organization_subpart                                        = row[:is_organization_subpart]
  provider.parent_organization_lbn                                        = row[:parent_organization_lbn]
  provider.parent_organization_tin                                        = row[:parent_organization_tin]
  provider.authorized_official_name_prefix_text                           = row[:authorized_official_name_prefix_text]
  provider.authorized_official_name_suffix_text                           = row[:authorized_official_name_suffix_text]
  provider.authorized_official_credential_text                            = row[:authorized_official_credential_text]

  provider.save

  1.upto(15).each do |num|
    next unless row[:"provider_license_number_#{num}"].length > 0

    provider.provider_identifiers.where(
      identifier: row[:"provider_license_number_#{num}"],
      type_code:  'LC',
      state:      row[:"provider_license_number_state_code_#{num}"]).first_or_create
  end

  1.upto(15).each do |num|
    next unless row[:"healthcare_provider_taxonomy_code_#{num}"].length > 0

    primary  = row[:"healthcare_provider_primary_taxonomy_switch_#{num}"] == 'Y' ? true : false

    provider.provider_taxonomies.where(
      taxonomy: row[:"healthcare_provider_taxonomy_code_#{num}"],
      primary:  primary).first_or_create
  end

  1.upto(50).each do |num|
    next unless row[:"other_provider_identifier_#{num}"].length > 0

    provider.provider_identifiers.where(
      identifier:       row[:"other_provider_identifier_#{num}"],
      type_code:        row[:"other_provider_identifier_type_code_#{num}"],
      state:            row[:"other_provider_identifier_state_#{num}"],
      additional_info:  row[:"other_provider_identifier_issuer_#{num}"]).first_or_create
  end
end

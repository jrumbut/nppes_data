# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120605192830) do

  create_table "provider_identifiers", :force => true do |t|
    t.string   "provider_id"
    t.string   "license_number",  :limit => 20
    t.string   "additional_info"
    t.string   "identifier"
    t.string   "state",           :limit => 2
    t.string   "type_code",       :limit => 2
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "provider_identifiers", ["identifier"], :name => "index_provider_identifiers_on_identifier"
  add_index "provider_identifiers", ["provider_id"], :name => "index_provider_identifiers_on_provider_id"

  create_table "provider_taxonomies", :force => true do |t|
    t.integer  "provider_id"
    t.string   "code",        :limit => 10
    t.string   "taxonomy"
    t.boolean  "primary"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "provider_taxonomies", ["code"], :name => "index_provider_taxonomies_on_code"
  add_index "provider_taxonomies", ["provider_id"], :name => "index_provider_taxonomies_on_provider_id"

  create_table "providers", :force => true do |t|
    t.integer  "npi"
    t.integer  "entity_type_code"
    t.integer  "replacement_npi"
    t.string   "employer_identification_number",                               :limit => 9
    t.string   "provider_organization_name",                                   :limit => 70
    t.string   "provider_last_name",                                           :limit => 35
    t.string   "provider_first_name",                                          :limit => 20
    t.string   "provider_middle_name",                                         :limit => 20
    t.string   "provider_name_prefix_text",                                    :limit => 5
    t.string   "provider_name_suffix_text",                                    :limit => 5
    t.string   "provider_credential_text",                                     :limit => 20
    t.string   "provider_other_organization_name",                             :limit => 70
    t.string   "provider_other_organization_name_type_code",                   :limit => 1
    t.string   "provider_other_last_name",                                     :limit => 35
    t.string   "provider_other_first_name",                                    :limit => 20
    t.string   "provider_other_middle_name",                                   :limit => 20
    t.string   "provider_other_name_prefix_text",                              :limit => 5
    t.string   "provider_other_name_suffix_text",                              :limit => 5
    t.string   "provider_other_credential_text",                               :limit => 20
    t.integer  "provider_other_last_name_type_code",                           :limit => 1
    t.string   "provider_first_line_business_address",                         :limit => 55
    t.string   "provider_business_mailing_address_city_name",                  :limit => 40
    t.string   "provider_mailing_address_state_name",                          :limit => 40
    t.string   "provider_business_mailing_address_postal_code",                :limit => 20
    t.string   "provider_business_mailing_address_country_code",               :limit => 2
    t.string   "provider_business_mailing_address_telephone_number",           :limit => 20
    t.string   "provider_business_mailing_address_fax_number",                 :limit => 20
    t.string   "provider_first_line_business_practice_location_address",       :limit => 55
    t.string   "provider_second_line_business_practice_location_address",      :limit => 55
    t.string   "provider_business_practice_location_address_city_name",        :limit => 40
    t.string   "provider_business_practice_location_address_state_name",       :limit => 40
    t.string   "provider_business_practice_location_address_postal_code",      :limit => 20
    t.string   "provider_business_practice_location_address_country_code",     :limit => 2
    t.string   "provider_business_practice_location_address_telephone_number", :limit => 20
    t.string   "provider_business_practice_location_address_fax_number",       :limit => 20
    t.datetime "provider_enumeration_date"
    t.datetime "last_update_date"
    t.string   "npi_deactivation_reason_code",                                 :limit => 2
    t.datetime "npi_deactivation_date"
    t.datetime "npi_reactivation_date"
    t.string   "provider_gender_code",                                         :limit => 1
    t.string   "authorized_official_last_name",                                :limit => 35
    t.string   "authorized_official_first_name",                               :limit => 20
    t.string   "authorized_official_middle_name",                              :limit => 20
    t.string   "authorized_official_title_or_position",                        :limit => 35
    t.string   "authorized_official_telephone_number",                         :limit => 20
    t.string   "is_sole_proprietor",                                           :limit => 1
    t.string   "is_organization_subpart",                                      :limit => 1
    t.string   "parent_organization_lbn",                                      :limit => 70
    t.string   "parent_organization_tin",                                      :limit => 9
    t.string   "authorized_official_name_prefix_text",                         :limit => 5
    t.string   "authorized_official_name_suffix_text",                         :limit => 5
    t.string   "authorized_official_credential_text",                          :limit => 20
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
  end

  add_index "providers", ["npi"], :name => "index_providers_on_npi"
  add_index "providers", ["provider_last_name", "provider_first_name"], :name => "index_providers_on_provider_last_name_and_provider_first_name"

end

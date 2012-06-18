class Provider < ActiveRecord::Base
  has_many :provider_identifiers
  has_many :provider_taxonomies

  scope :with_npi,              lambda {|param| param.blank? ? scoped : where("npi = ?", param) }

  scope :city,                  lambda {|param| param.blank? ? scoped : where("(provider_business_mailing_address_city_name = ? OR provider_business_practice_location_address_city_name = ?)", param, param) }
  scope :state,                 lambda {|param| param.blank? ? scoped : where("(provider_mailing_address_state_name = ? OR provider_business_practice_location_address_state_name = ?)", param, param) }
  scope :postal_code,           lambda {|param| param.blank? ? scoped : where("(provider_business_mailing_address_postal_code = ? OR provider_business_practice_location_address_postal_code = ?)", param, param) }

  scope :mailing_city,          lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_city_name = ?", param) }
  scope :mailing_state,         lambda {|param| param.blank? ? scoped : where("provider_mailing_address_state_name = ?", param) }
  scope :mailing_postal_code,   lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_postal_code = ?", param) }

  scope :practice_city,         lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_city_name = ?", param) }
  scope :practice_state,        lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_state_name = ?", param) }
  scope :practice_postal_code,  lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_postal_code = ?", param) }

  scope :provider_telephone,    lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_telephone_number = ?", param) }
  scope :practice_telephone,    lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_telephone_number = ?", param) }
  scope :official_telephone,    lambda {|param| param.blank? ? scoped : where("authorized_official_telephone_number = ?", param) }

  scope :phone,                 lambda {|param| param.blank? ? scoped : where("(provider_business_mailing_address_telephone_number = ? OR provider_business_practice_location_address_telephone_number = ? OR authorized_official_telephone_number = ?)", param, param, param) }

  def self.wildcard_search(field, value)
    if value.blank?
      scoped
    elsif value =~ /\*/
      where("#{field} LIKE ?", value.gsub("*", "%"))
    else
      where("#{field} = ?", value)
    end
  end

  def self.first_name(param)
    wildcard_search('provider_first_name', param)
  end

  def self.last_name(param)
    wildcard_search('provider_last_name', param)
  end

  def self.organization(param)
    wildcard_search('provider_organization_name', param)
  end

  def name
    if entity_type_code == '1'
      [provider_first_name, provider_middle_name, provider_last_name, provider_name_suffix_text, provider_credential_text].join(' ')
    else
      self.provider_organization_name
    end
  end

  def other_name
    ret = if entity_type_code == '1'
            [name_type_code_xref(provider_other_last_name_type_code), provider_other_first_name, provider_other_middle_name, provider_other_last_name, provider_other_name_suffix_text, provider_other_credential_text].join(' ')
          else
            name_type_code_xref(provider_other_organization_name_type_code) + ' ' + self.provider_other_organization_name
          end

    ret.to_s.strip.blank? ? nil : ret
  end

  def name_type_code_xref(code)
    case code
    when '1' then 'Former:'
    when '2' then 'Professional:'
    when '3' then 'D/B/A:'
    when '4' then 'Former:'
    when '5' then 'Other:'
    end
  end
end

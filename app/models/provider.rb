class Provider < ActiveRecord::Base
  has_many :provider_identifiers
  has_many :provider_taxonomies

  scope :with_npi,           lambda {|param| param.blank? ? scoped : where("npi = ?", param) }

  scope :city,               lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_city_name = ?", param) }
  scope :state,              lambda {|param| param.blank? ? scoped : where("provider_mailing_address_state_name = ?", param) }
  scope :postal_code,        lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_postal_code = ?", param) }

  scope :org_state,          lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_state_name = ?", param) }
  scope :org_city,           lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_city_name = ?", param) }
  scope :org_postal_code,    lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_postal_code = ?", param) }

  scope :provider_telephone, lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_telephone_number = ?", param) }
  scope :practice_telephone, lambda {|param| param.blank? ? scoped : where("provider_business_practice_location_address_telephone_number = ?", param) }
  scope :official_telephone, lambda {|param| param.blank? ? scoped : where("authorized_official_telephone_number = ?", param) }


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
    if self.provider_last_name.present? && self.provider_first_name.present?
      (self.provider_last_name.to_s + ", " + self.provider_first_name.to_s).titleize
    elsif self.provider_organization_name.present?
      self.provider_organization_name
    else
      "Not Provided"
    end
  end
end

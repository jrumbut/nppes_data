class Provider < ActiveRecord::Base
  has_many :provider_identifiers
  has_many :provider_taxonomies

  scope :npi,        lambda {|param| param.blank? ? scoped : where("npi = ?", param) }
  scope :city,       lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_city_name = ?", param) }
  scope :state,      lambda {|param| param.blank? ? scoped : where("provider_mailing_address_state_name = ?", param) }
  scope :zip,        lambda {|param| param.blank? ? scoped : where("provider_business_mailing_address_postal_code = ?", param) }

  def self.first_name(param)
    if param.blank?
      scoped
    elsif param =~ /\*/
      where("provider_first_name LIKE ?", param.gsub("*", "%"))
    else
      where("provider_first_name = ?", param)
    end
  end

  def self.last_name(param)
    if param.blank?
      scoped
    elsif param =~ /\*/
      where("provider_last_name LIKE ?", param.gsub("*", "%"))
    else
      where("provider_last_name = ?", param)
    end
  end


  def name
    if self.provider_last_name.present? && self.provider_first_name.present?
      (self.provider_last_name.to_s + ", " + self.provider_first_name.to_s).titleize
    else
      "Not Provided"
    end
  end
end

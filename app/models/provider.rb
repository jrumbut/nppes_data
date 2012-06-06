class Provider < ActiveRecord::Base
  has_many :provider_identifiers
  has_many :provider_taxonomies
end

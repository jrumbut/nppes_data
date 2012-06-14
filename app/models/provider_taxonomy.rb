class ProviderTaxonomy < ActiveRecord::Base
  belongs_to :provider

  def description
    Hippo::CodeLists::TaxonomyCodes[self.taxonomy]
  end
end

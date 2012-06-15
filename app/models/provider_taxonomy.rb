class ProviderTaxonomy < ActiveRecord::Base
  belongs_to :provider

  def taxonomy_details
    @taxonomy_details ||= Hippo::CodeLists::TaxonomyCodes[self.taxonomy]
  end

  def description
    taxonomy_details[:classification] + (taxonomy_details[:specialization].present? ? "/#{taxonomy_details[:specialization]}" : '')
  end

  def definition
    taxonomy_details[:definition]
  end
end

class ProviderIdentifier < ActiveRecord::Base
  belongs_to :provider

  def type
    case type_code
    when 'LC' then 'License'
    when '01' then 'Other'
    when '02' then 'Medicare Upin'
    when '04' then 'Medicare ID - Other'
    when '05' then 'Medicaid'
    when '06' then 'Medicare Oscar/Cert'
    when '07' then 'Medicare NSC'
    when '08' then 'Medicare PIN'
    end
  end
end

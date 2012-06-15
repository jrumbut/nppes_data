class ProvidersController < ApplicationController
  def search;end

  def results
    redirect_to providers_path(params: params)
  end

  def show
    @provider = Provider.find(params[:id])
  end

  def index
    if valid_search?
      @providers = Provider.first_name(params[:first_name]).
                            last_name(params[:last_name]).
                            organization(params[:organization]).
                            with_npi(params[:npi]).
                            city(params[:city]).
                            state(params[:state]).
                            postal_code(params[:postal_code]).
                            org_city(params[:org_city]).
                            org_state(params[:org_state]).
                            org_postal_code(params[:org_postal_code]).
                            phone(sanitize_phone(params[:phone])).
                            limit(200)
    else
      flash[:alert] = 'You must search using at least one of the following indexed fields (NPI, Org Name, Phone, Last Name).'
    end
  end

  def sanitize_phone(p)
    p.nil? ? nil : p.gsub(/(\D+)/,'')
  end

  def valid_search?
    params.any? { |key, value| [:npi, :organization, :org_state, :state, :phone, :last_name].include?(key.to_sym) }
  end
end
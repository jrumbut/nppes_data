class ProvidersController < ApplicationController
  def search;end

  def results
    redirect_to providers_path(params: params)
  end

  def show
    @provider = Provider.find(params[:id])
  end

  def index
    if valid_search_fields
      @providers = Provider.first_name(params[:first_name]).
                            last_name(params[:last_name]).
                            npi(params[:npi]).
                            page(params[:page])
    else
      flash[:warning] = 'You must search using at least one of the following indexed fields (NPI, Org Name, Phone, Last Name).'
    end
  end

  def valid_search_fields
    params.any? { |key, value| [:npi, :organization, :phone, :last_name].includes?(key.to_sym) }
  end
end
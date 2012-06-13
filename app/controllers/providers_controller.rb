class ProvidersController < ApplicationController

  def search;end

  def results
    redirect_to providers_path(params: params)
  end

  def show
    @provider = Provider.find(params[:id])
  end

  def index
    @providers = Provider.first_name(params[:first_name]).
                          last_name(params[:last_name]).
                          npi(params[:npi]).
                          page(params[:page])
  end
end
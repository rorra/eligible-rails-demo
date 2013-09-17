class ProvidersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @providers = current_user.providers.page(params[:page])
  end

  def show
    @provider = current_user.providers.find(params[:id])
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    @provider.user_id = current_user.id
    if @provider.save
      redirect_to provider_path(@provider), notice: "Provider Saved"
    else
      render :new
    end
  end

  def edit
    @provider = current_user.providers.find(params[:id])
  end

  def update
    @provider = current_user.providers.find(params[:id])
    if @provider.update_attributes(provider_params)
      redirect_to provider_path(@provider), notice: "Provider Updated"
    else
      render :edit
    end
  end

  def destroy
    @provider = current_user.providers.find(params[:id])
    if @provider.destroy
      redirect_to providers_path, notice: "Provider Deleted"
    else
      redirect_to :back, alert: "There was an error trying to delete the Provider"
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:npi, :first_name, :last_name)
  end
end

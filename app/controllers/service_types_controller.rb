class ServiceTypesController < ApplicationController
  def index
    @service_types = ServiceType
    unless params[:q].blank?
      @service_types = @service_types.where("service_type_id ilike ? or description ilike ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @service_types = @service_types.all

    respond_to do |format|
      format.json { render json: @service_types.as_json(only: [:service_type_id, :description]) }
    end
  end
end

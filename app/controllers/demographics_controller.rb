class DemographicsController < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key

  def new
    @demographic = Eligible::Demographic.new
  end

  def create
    @demographic = Eligible::Demographic.new(demographic_params)
    @demographic.api_key = current_user.api_key

    if @demographic.valid?
      begin
        @raw_json = RestClient.get(ELIGIBLE_DEMOGRAPHIC_URL, params: @demographic.to_hash(false))
      rescue Exception => ex
        flash[:warning] = ex.message
      end
      render :new
    else
      render :new
    end
  end

  private

  def demographic_params
    params.require(:eligible_coverage).permit(:payer_id, :provider_npi, :provider_first_name, :provider_last_name,
                                              :member_id, :member_first_name, :member_last_name, :member_dob,
                                              :service_type)
  end
end

class CoverageController < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key

  def new
    @coverage = Eligible::Coverage.new
    @coverage.service_type = '30'
  end

  def create
    @coverage = Eligible::Coverage.new
    @coverage.api_key = current_user.api_key

    if @coverage.valid?
      # Do the demographic submit here
    else
      render :new
    end
  end

  private

  def demographic_params
    params.require(:eligible_coverage).permit(:payer_id, :provider_npi, :provider_first_name, :provider_last_name,
                                              :member_id, :member_first_name, :member_last_name,
                                              :member_dob, :service_type)
  end
end

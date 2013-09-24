class X12Controller < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key

  def new
    @x12 = Eligible::X12.new
  end

  def create
    @x12 = Eligible::X12.new(x12_params)
    @x12.api_key = current_user.api_key

    if @x12.valid?
      begin
        @result = RestClient.get(ELIGIBLE_X12_URL, params: @x12.to_hash(false))
      rescue Exception => ex
        flash[:warning] = ex.message
      end
    end

    render :new
  end

  private

  def x12_params
    params.require(:eligible_x12).permit(:x12)
  end
end

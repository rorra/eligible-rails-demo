class X12Controller < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key

  def new
    @x12 = Eligible::X12.new
  end

  def create
    @x12 = Eligible::X12.new
    @x12.api_key = current_user.api_key

    if @x12.valid?
      # Do the demographic submit here
    else
      render :new
    end
  end

  private

  def x12_params
    params.require(:eligible_x12).permit(:x12)
  end
end

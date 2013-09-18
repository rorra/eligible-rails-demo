class DemographicsController < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key

  def new
    @demographic = Eligible::Demographic.new
  end

  def create
    @demographic = Eligible::Demographic.new
    @demographic.api_key = current_user.api_key

    if @demographic.valid?
      # Do the demographic submit here
    else
      render :new
    end
  end
end

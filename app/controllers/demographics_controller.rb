class DemographicsController < ApplicationController
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

class DemographicsController < ApplicationController
  def new
    @demographic = Demographic.new
  end

  def create
    @demographic = Demographic.new

    if @demographic.valid?
      # Do the demographic submit here
    else
      render :new
    end
  end
end

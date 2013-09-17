class CoverageController < ApplicationController
  def new
    @coverage = Eligible::Coverage.new
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
end

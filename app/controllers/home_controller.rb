class HomeController < ApplicationController
  before_filter :ask_for_api_key, if: :user_signed_in?
end

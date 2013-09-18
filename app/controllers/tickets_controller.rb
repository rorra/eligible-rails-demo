class TicketsController < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key
end

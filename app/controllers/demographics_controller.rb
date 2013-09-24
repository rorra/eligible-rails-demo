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
        @json = JSON(@raw_json)
        if @json['error']
          flash[:warning] = @json['error']['reject_reason_description'].presence
        else
          @full_name = parse_full_name(@json)
          @dob = parse_dob(@json)
          @address = parse_address(@json)
        end
      rescue Exception => ex
        flash[:warning] = ex.message
      end
    end

    render :new
  end

  private

  def demographic_params
    params.require(:eligible_demographic).permit(:payer_id, :provider_npi, :provider_first_name, :provider_last_name,
                                                 :member_id, :member_first_name, :member_last_name, :member_dob)
  end

  def parse_full_name(json)
    first_name = json['subscriber']['first_name'].presence.humanize
    last_name = json['subscriber']['last_name'].presence.humanize
    "#{first_name} #{last_name}"
  end

  def parse_dob(json)
    json['subscriber']['dob']
  end

  def parse_address(json)
    address = {}
    address[:street] = [json['subscriber']['address']['street_line_1']]
    address[:street] << json['subscriber']['address']['street_line_2'] if json['subscriber']['address']['street_line_2']
    address[:city] = json['subscriber']['address']['city']
    address[:state] = json['subscriber']['address']['state']
    address[:zip] = json['subscriber']['address']['zip']
    address
  end

end

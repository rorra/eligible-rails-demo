class CoverageController < ApplicationController
  before_filter :authenticate_user!, :ask_for_api_key

  def new
    @coverage = Eligible::Coverage.new
    @coverage.service_type = '30'
  end

  def create
    @coverage = Eligible::Coverage.new(coverage_params)
    @coverage.api_key = current_user.api_key

    if @coverage.valid?
      begin
        @raw_json = RestClient.get(ELIGIBLE_COVERAGE_URL, params: @coverage.to_hash(false))
        @json = JSON(@raw_json)
        if @json['error']
          flash[:warning] = @json['error']['reject_reason_description'].presence
        else
          @full_name = parse_full_name(@json)
          @dob = parse_dob(@json)
          @address = parse_address(@json)
          @plan_coverage = parse_plan_coverage(@json)
          @plan = parse_plan(@json)
          @payer_type = nil
          @plan_remaining = parse_plan_remaining(@json)
          @service = parse_service(@json, @coverage.service_type)
          @service_remaining = parse_service_remaining(@json, @coverage.service_type)
        end
      rescue Exception => ex
        flash[:warning] = ex.message
      end
      render :new
    else
      render :new
    end
  end

  private

  def parse_full_name(json)
    first_name = json['demographics']['subscriber']['first_name'].presence.humanize
    last_name = json['demographics']['subscriber']['last_name'].presence.humanize
    "#{first_name} #{last_name}"
  end

  def parse_dob(json)
    json['demographics']['subscriber']['dob']
  end

  def parse_address(json)
    address = {}
    address[:street] = [json['demographics']['subscriber']['address']['street_line_1']]
    address[:street] << json['demographics']['subscriber']['address']['street_line_2'] if json['demographics']['subscriber']['address']['street_line_2']
    address[:city] = json['demographics']['subscriber']['address']['city']
    address[:state] = json['demographics']['subscriber']['address']['state']
    address[:zip] = json['demographics']['subscriber']['address']['zip']
    address
  end

  def parse_plan_coverage(json)
    {
      active: %w(1 2 3 4 5).include?(json['plan']['coverage_status']),
      description: json['plan']['coverage_status_label']
    }
  end

  def parse_plan(json)
    {
      name: json['plan']['plan_name'],
      number: json['plan']['plan_number'],
      group_name: json['plan']['group_name']
    }
  end

  def parse_plan_remaining(json)
    financials = json['plan']['financials']
    {
      deductible: {
        in_network: (financials['deductible']['remainings']['in_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue []),
        out_network: (financials['deductible']['remainings']['out_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue [])
      },
      stop_loss: {
        in_network: (financials['stop_loss']['remainings']['in_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue []),
        in_network: (financials['stop_loss']['remainings']['in_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue [])
      }
    }
  end

  def parse_service(json, service_code)
    service = json['services'].detect { |s| s['type'].to_s == service_code.to_s }
    if service
      { type: service['type'],
        label: service['type_label'],
        active: %w(1 2 3 4 5).include?(service['coverage_status']),
        description: service['coverage_status_label']
      }
    else
      nil
    end
  end


  def parse_service_remaining(json, service_code)
    service = json['services'].detect { |s| s['type'].to_s == service_code.to_s }
    if service
      financials = service['financials']
      {
        deductible: {
          in_network: (financials['deductible']['remainings']['in_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue []),
          out_network: (financials['deductible']['remainings']['out_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue [])
        },
        stop_loss: {
          in_network: (financials['stop_loss']['remainings']['in_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue []),
          in_network: (financials['stop_loss']['remainings']['in_network'].collect { |item| { amount: item['amount'], level: item['level'] } } rescue [])
        }
      }
    else
      nil
    end
  end


  def coverage_params
    params.require(:eligible_coverage).permit(:payer_id, :provider_npi, :provider_first_name, :provider_last_name,
                                              :member_id, :member_first_name, :member_last_name,
                                              :member_dob, :service_type)
  end
end

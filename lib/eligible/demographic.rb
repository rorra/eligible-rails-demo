module Eligible
  class Demographic
    include ActiveModel::Model

    attr_accessor :api_key, :payer_id, :provider_npi, :provider_first_name, :provider_last_name,
                  :member_id, :member_first_name, :member_last_name, :member_dob, :member_ssn, :member_gender

    validates :api_key, presence: true
    validates :payer_id, presence: true
    validates :provider_npi, presence: true
    validates :provider_first_name, presence: true
    validates :provider_last_name, presence: true
    validates :member_id, presence: true
    validates :member_first_name, presence: true
    validates :member_last_name, presence: true
    validates :member_dob, presence: true

    def to_hash(include_blank = true)
      response = {}
      [:api_key, :payer_id, :provider_npi, :provider_first_name, :provider_last_name,
       :member_id, :member_first_name, :member_last_name, :member_dob, :member_ssn, :member_gender].each do |k|
        response[k] = self.send(k) if include_blank || !self.send(k).blank?
      end
      response
    end


    def to_query_string
      keys = [:api_key, :payer_id, :provider_npi, :provider_first_name, :provider_last_name,
              :member_id, :member_first_name, :member_last_name, :member_dob, :member_ssn, :member_gender]
      values = []
      keys.each do |k|
        values << URI.encode("#{k.to_s}=#{self.send(k)}") unless self.send(k).blank?
      end
      values.join("&")
    end
  end
end
class Demographic
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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
end
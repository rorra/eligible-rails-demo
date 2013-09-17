class ServiceType < ActiveRecord::Base
  validates :service_type_id, presence: true, uniqueness: true
end

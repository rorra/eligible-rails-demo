class Provider < ActiveRecord::Base
  belongs_to :user

  validates :npi, presence: true, uniqueness: { scope: :user_id }
  validates :first_name, presence: true
  validates :last_name, presence: true
end

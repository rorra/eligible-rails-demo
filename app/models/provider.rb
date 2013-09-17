class Provider < ActiveRecord::Base
  belongs_to :user

  validates :npi, presence: true, uniquenes: { scope: :user_id }
  validates :first_name, presence: true
  validates :last_name, presence: true
end

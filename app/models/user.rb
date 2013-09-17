class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :api_key, uniqueness: true
  validates :api_key, presence: true, on: :update

  def ready_for_api_calls?
    !api_key.blank?
  end

  def to_s
    "#{first_name}"
  end
end

class Payer < ActiveRecord::Base
  has_many :payer_names
  validates :payer_id, presence: true, uniqueness: true

  accepts_nested_attributes_for :payer_names
end

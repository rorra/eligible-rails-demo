class Payer < ActiveRecord::Base
  has_many :payer_names, dependent: :destroy
  validates :payer_id, presence: true, uniqueness: true

  accepts_nested_attributes_for :payer_names, reject_if: :all_blank, allow_destroy: true
end

module Eligible
  class X12
    include ActiveModel::Model

    attr_accessor :api_key, :x12

    validates :x12, presence: true
  end
end
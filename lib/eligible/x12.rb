module Eligible
  class X12
    include ActiveModel::Model

    attr_accessor :api_key, :x12

    validates :x12, presence: true

    def to_query_string
      keys = [:api_key, :x12]
      values = []
      keys.each do |k|
        values << URI.encode("#{k.to_s}=#{self.send(k)}") unless self.send(k).blank?
      end
      values.join("&")
    end
  end
end
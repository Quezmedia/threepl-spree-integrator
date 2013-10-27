module Nutracoapi
  class OrderIntegration < ActiveRecord::Base
    validates_presence_of :order_number
    validates_presence_of :status

    scope :non_shipped_orders, -> { where.not(status: "shipped") }

    def mark_as_shipped!
      self.update_columns(status: "shipped", shipped_at: Time.now)
    end

    def was_shipped?
      self.status == "shipped"
    end
  end
end

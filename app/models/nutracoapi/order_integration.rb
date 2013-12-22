module Nutracoapi
  class OrderIntegration < ActiveRecord::Base
    validates_presence_of :order_number
    validates_presence_of :status
    validates_presence_of :shipment_number

    scope :non_shipped_orders, -> { where(status: "integrated") }
    scope :canceled_orders, -> { where(status: "canceled") }

    def self.already_saved?(on)
      where(:order_number => on).any?
    end

    def self.already_canceled?(on)
      found_order = where(:order_number => on).first
      return false unless found_order
      found_order.canceled?
    end

    def mark_as_shipped!(tracking_nbr)
      self.update_columns(status: "shipped", shipped_at: Time.now, tracking_number: tracking_nbr)
    end

    def mark_as_canceled!
      self.update_columns(status: "canceled", canceled_at: Time.now)
    end

    def canceled?
      self.status == "canceled"
    end

    def was_shipped?
      self.status == "shipped"
    end
  end
end

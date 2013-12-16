class Nutracoapi::BrokerThreeToSpree

  def check_and_mark_orders_as_sent
    non_shipped_orders = Nutracoapi::OrderIntegration.non_shipped_orders

    non_shipped_orders.each do |order|
      three_order = three_find_order_provider.call_find_order(order.order_number)
      if three_order.try(:any?)
        tracking_number = three_order.first.tracking_number
        unless tracking_number.blank?
          spree_ship_provider.ship_order(order.order_number, order.shipment_number, tracking_number)
          order.mark_as_shipped!(tracking_number)
        end
      end
    end
  end

  private
  def spree_ship_provider
    @spree_ship_provider ||= Nutracoapi::Spree::ShipOrder.new
  end

  def three_find_order_provider
    @three_find_order_provider ||= Nutracoapi::ThreePl::FindOrder.new
  end


end

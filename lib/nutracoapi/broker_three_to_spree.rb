class Nutracoapi::BrokerThreeToSpree

  def mark_orders_as_sent
    non_shipped_orders = Nutracoapi::OrderIntegration.non_shipped_orders
  end

  private
  def spree_ship_provider
    @spree_ship_provider ||= Nutracoapi::Spree::ShipOrder.new
  end


end

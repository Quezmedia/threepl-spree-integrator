class Nutracoapi::Broker
  def send_missing_orders_to_three_pl
    paid_orders = list_paid_orders
  end

  private
  def spree_provider
    @spree_provider ||= Nutracoapi::Spree::ListOrders.new
  end

  def list_paid_orders
    spree_provider.list_paid_orders
  end
end

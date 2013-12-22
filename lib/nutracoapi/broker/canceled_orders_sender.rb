class Nutracoapi::Broker::CanceledOrdersSender
  def send_canceled_orders_to_three_pl
    canceled_orders = spree_list_provider.list_canceled_orders
    canceled_orders.each do |po|
      cancel_on_3pl po rescue nil
    end
  end

  private
  def spree_list_provider
    @spree_list_provider ||= Nutracoapi::Spree::ListOrders.new
  end

  def three_find_provider
    @three_find_provider ||= Nutracoapi::ThreePl::FindOrder.new
  end

  def three_cancel_provider
    @three_cancel_profider ||= Nutracoapi::ThreePl::CancelOrder.new
  end

  def order_already_saved?(on)
    Nutracoapi::OrderIntegration.already_saved? on
  end

  def save_order(complete_order)
    Nutracoapi::OrderIntegration.create!(
      :order_number => complete_order.number,
      :shipment_number => complete_order.shipments.last.number
    )
  end

  def cancel_on_3pl(order)
    unless order_already_saved? order.number
      complete_order = spree_find_provider.find_order order.number
      result = three_create_provider.call_create_order(attributes)

      if result == "1"
        save_order complete_order
      end
    end
  end
end

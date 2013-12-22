class Nutracoapi::Broker::CanceledOrdersSender
  def send_canceled_orders_to_three_pl
    canceled_orders = spree_list_provider.list_canceled_orders
    canceled_orders.each do |co|
      cancel_on_3pl co rescue Nutracoapi.logger.error "Error on sending canceled order #{co.number}"
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

  def order_already_canceled?(on)
    Nutracoapi::OrderIntegration.already_canceled? on
  end

  def mark_as_canceled(order_number)
    found_order = Nutracoapi::OrderIntegration.where(:order_number => order_number).first
    found_order.mark_as_canceled! if found_order
  end

  def cancel_on_3pl(order)
    if order_already_saved?(order.number) and not order_already_canceled?(order.number)
      three_order = three_find_provider.call_find_order(order.number).first
      return unless three_order

      result = three_cancel_provider.call_cancel_order(three_order.warehouse_transaction_id)

      if result == "1"
        mark_as_canceled order.number
      end
    end
  end
end

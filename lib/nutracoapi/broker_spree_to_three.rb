class Nutracoapi::BrokerSpreeToThree
  def send_missing_orders_to_three_pl
    paid_orders = spree_list_provider.list_paid_orders
    paid_orders.each do |po|
      save_if_it_is_not_saved po
    end
  end

  private
  def spree_list_provider
    @spree_list_provider ||= Nutracoapi::Spree::ListOrders.new
  end

  def spree_find_provider
    @spree_find_provider ||= Nutracoapi::Spree::FindOrder.new
  end

  def three_create_provider
    @three_create_profider ||= Nutracoapi::ThreePl::CreateOrder.new
  end

  def prepare_spree_order_attributes(spree_order)
    attributes = Hash.new
    attributes[:reference_num] = spree_order.number
    attributes[:company_name]  = "#{ spree_order.ship_address.firstname } #{ spree_order.ship_address.lastname }"
    attributes[:address1]      = spree_order.ship_address.address1
    attributes[:city]          = spree_order.ship_address.city
    attributes[:state]         = spree_order.ship_address.state.abbr
    attributes[:zip]           = spree_order.ship_address.zipcode
    attributes[:country]       = spree_order.ship_address.country.iso
    attributes[:carrier]       = "UPS"
    attributes[:mode]          = "Ground"
    attributes[:billing_code]  = "Prepaid"
    # This are gonna generate a hash like {:Sku1=>1, :Sku2=>1}
    # Which means Sku => Quantity
    attributes[:products]      =
      Hash[*spree_order.line_items.map{|line_item| [line_item.variant.sku.to_sym, line_item.quantity]}.flatten]
    attributes
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

  def save_if_it_is_not_saved(order)
    unless order_already_saved? order.number
      complete_order = spree_find_provider.find_order order.number
      attributes = prepare_spree_order_attributes(complete_order)
      result = three_create_provider.call_create_order(attributes)

      if result == "1"
        save_order complete_order
      end
    end
  end
end

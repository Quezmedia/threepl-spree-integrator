class Nutracoapi::CreateOrder < Nutracoapi::Base
  def call_create_order(options = {})
    body = {:extLoginData => Nutracoapi.login_parameters}
    body = body.merge({:orders =>
                       {:Order =>
                        [prepare_order_body(options)]
                       }
    })
    pp body
    puts prepare_operation("CreateOrders", {}, body)
    call("CreateOrders", {}, body)
  end

  private
  def prepare_order_body(options = {})
    reference_num = options.fetch(:reference_num)
    {
      :TransInfo => {:ReferenceNum => reference_num},
      :ShipTo => {
        :CompanyName => "Test Company Name",
        :Address => {
          :Address1 => "Blablabla",
          :City => "Los Angeles",
          :State => "CA",
          :Zip => "90010",
          :Country => "US"
        },
      },
      :ShippingInstructions => {
        :Carrier => "UPS",
        :Mode => "Ground",
        :BillingCode => "FreightCollect",
        :Account => "12345675"
      },
      :Notes => "This is a note",
      :OrderLineItems => {
        :OrderLineItem => [{
          :Sku => "TestItem",
          :Qty => "1"
        }]
      }
    }
  end
end

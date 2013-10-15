class Nutracoapi::CreateOrder < Nutracoapi::Base
  def call_create_order(options = {})
    body = {:extLoginData => Nutracoapi.login_parameters}
    body = body.merge({:orders =>
                       {:Order =>
                        [prepare_order_body(options)]
                       }
    })
    call("CreateOrders", {}, body)
  end

  private
  def prepare_order_body(options = {})
    reference_num = options.fetch(:reference_num)
    company_name  = options.fetch(:company_name)
    address1      = options.fetch(:address1)
    city          = options.fetch(:city)
    state         = options.fetch(:state)
    zip           = options.fetch(:zip)
    country       = options.fetch(:country)
    carrier       = options.fetch(:carrier)
    mode          = options.fetch(:mode)
    billing_code  = options.fetch(:billing_code)
    account       = options.fetch(:account)
    notes         = options.fetch(:notes)
    products      = options.fetch(:products)
    {
      :TransInfo => {:ReferenceNum => reference_num},
      :ShipTo => {
        :CompanyName => company_name,
        :Address => {
          :Address1 => address1,
          :City => city,
          :State => state,
          :Zip => zip,
          :Country => country
        },
      },
      :ShippingInstructions => {
        :Carrier => carrier,
        :Mode => mode,
        :BillingCode => billing_code,
        :Account => account
      },
      :Notes => notes,
      :OrderLineItems => {
        :OrderLineItem => [*prepare_products_body(products)]
      }
    }
  end

  def prepare_products_body(products)
    products.map do |product|
      {
        :SKU => product[0].to_s,
        :Qty => product[1].to_s
      }
    end
  end
end

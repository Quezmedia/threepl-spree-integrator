require 'nutracoapi/three_pl/base'
class Nutracoapi::ThreePl::CreateOrder < Nutracoapi::ThreePl::Base
  def call_create_order(options = {})
    body = {:extLoginData => Nutracoapi.login_parameters}
    body = body.merge({:orders =>
                       {:Order =>
                        [prepare_order_body(options)]
                       }
    })
    parse_response call("CreateOrders", {}, body).body
  end

  private
  def parse_response(response_json)
    unless response_json[:fault].blank?
      raise Exception.new("#{response_json[:fault][:faultcode]} - #{response_json[:fault][:faultstring]} \n #{response_json[:fault][:detail]}")
    end
    response_json[:int32]
  end

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
    notes         = options.fetch(:notes, " - ")
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
        :BillingCode => billing_code
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

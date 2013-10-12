class Nutracoapi::CreateOrder < Nutracoapi::Base
  def call_create_order
    message = {:ReferenceNum => "TestOrder123"}
    call(:create_orders, message)
  end
end

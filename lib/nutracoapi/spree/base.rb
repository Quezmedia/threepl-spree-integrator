class Nutracoapi::Spree::Base
  attr_reader :request
  attr_reader :last_response

  protected
  def prepare_operation(action, body, method, params = {})
    @request = Typhoeus::Request.new(
      "#{Nutracoapi.spree_endpoint}/#{action.to_s}",
      method: method,
      body: body,
      params: params,
      headers: { "X-Spree-Token" => Nutracoapi.spree_token}
    )
  end

  def call(action, body: '', method: :get, params: {})
    prepare_operation(action, body, method, params)
    @last_response = @request.run
  end
end

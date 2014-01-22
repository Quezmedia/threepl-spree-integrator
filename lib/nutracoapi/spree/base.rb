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
    Nutracoapi.logger.info "Spree::Base::call - Starting"
    Nutracoapi.logger.info "Operation - #{action}"
    Nutracoapi.logger.info "Params - #{params}"

    prepare_operation(action, body, method, params)
    @last_response = @request.run

    Nutracoapi.logger.info "Result:"
    Nutracoapi.logger.info @last_response.body

    @last_response
  end

  def parse_array(array_obj)
    array_result = Array.new
    array_obj.each do |obj|
      array_result << parse_hash(obj)
    end
    array_result
  end

  def parse_hash(json)
    obj = OpenStruct.new
    json.each do |k,v|
      if v.is_a? Array
        value = parse_array(v)
      elsif v.is_a? Hash
        value = parse_hash(v)
      else
        value = v
      end
      obj.send("#{k.underscore}=", value )
    end
    obj
  end

  def parse_response(response)
    json_response = JSON.parse(response.body)
    raise Exception.new(json_response["error"]) unless json_response["error"].nil?
    raise Exception.new(json_response["exception"]) unless json_response["exception"].nil?
    parse_hash json_response
  end

end

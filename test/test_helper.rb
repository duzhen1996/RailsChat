ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def send_ajax_request(method_str, input_params, url_str)

    puts input_params

    if method_str.downcase.eql?("get")
      # puts "到这里"
      get url_str, input_params,
          headers: {"HTTP_REFERER" => "http://0.0.0.0:3000"}

      return_obj = JSON.parse(@response.body)
    end

    if method_str.downcase.eql?("post")
      post url_str, input_params,
           headers: {"HTTP_REFERER" => "http://0.0.0.0:3000"}

      return_obj = JSON.parse(@response.body)
    end

    return return_obj
  end

  # Add more helper methods to be used by all tests here...
end

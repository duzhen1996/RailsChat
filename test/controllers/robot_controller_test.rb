require 'test_helper'

# class RobotControllerTest < ActionController::TestCase
#   def setup
#     @controller = RobotController.new
#     @request    = ActionController::TestRequest.new
#     @response   = ActionController::TestResponse.new
#   end
#
#   test "chat with robot" do
#     return_str = @controller.chat_with_robot_without_route('hello')
#
#     if return_str.nil?
#       assert false
#     end
#
#     assert true
#   end
#
#
# end
#
class RobotControllerTest < ActionDispatch::IntegrationTest

  # 这里设计一个函数来发送请求
  def setup
    @controller = RobotController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "chat with robot" do
    get '/robot/chat_with_robot', xhr: true, params: {input_string: 'hello'},
        headers: {"HTTP_REFERER" => "http://0.0.0.0:3000"}

    return_obj = JSON.parse(@response.body)

    if return_obj["output_string"].nil?
      assert false
    else
      assert true
    end
  end


end
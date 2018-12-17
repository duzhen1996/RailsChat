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


  def setup
    @controller = RobotController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  # 这里设计一个函数来发送请求，返回一个map，是服务器返回的json
  # 参数一共三个，一个是请求类型，一个是参数（hash），一个是访问的地址
  # 返回回复map
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

  test "chat with robot" do
    input_params = {}

    input_params[:input_string] = 'hello'

    puts input_params.class

    # get '/robot/chat_with_robot', input_params
        # headers: {"HTTP_REFERER" => "http://0.0.0.0:3000"}

    # return_obj = JSON.parse(@response.body)

    return_obj = send_ajax_request('GET', input_params,
                                   '/robot/chat_with_robot')

    if return_obj["output_string"].nil?
      assert false
    else
      assert true
    end
  end

  test "get evaluation" do
    input_params = {user_id: 1}

    # 这里发送请求
    return_obj = send_ajax_request('GET', input_params,
                                   '/robot/get_evaluation')

    puts return_obj

    assert true
  end

  test "store evaluation" do
    # 这里存一个信息进去
    input_params = {}

    input_params[:user_id] = 2
    input_params[:user_score] = 3
    input_params[:chat_time] = 4
    input_params[:correspond_time] = 5


    # 这里发送请求
    return_obj = send_ajax_request('POST', input_params,
                                   '/robot/store_evaluation')

    puts return_obj

    if return_obj["return_code"] == 1
      # 讲道理这里还需要取一下对应的值，看看有没有问题
      input_params = {user_id: 1}

      # 这里发送请求
      return_obj = send_ajax_request('GET', input_params,
                                     '/robot/get_evaluation')

      puts return_obj

      assert true
    else
      assert false
    end
  end

end
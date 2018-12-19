require 'test_helper'

class ExtendUsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @controller = ExtendUsersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  # 测试添加新用户的函数
  test 'add_new_user' do
    # 我们传入三个值，用户名，用户email，用户密码
    input_params = {}

    input_params[:user_name] = 'zhendu'
    input_params[:user_email] = 'zhendu@test.com'
    input_params[:user_password] = '123456'

    # 发送请求
    return_obj = send_ajax_request('POST', input_params, '/extend_users/add_new_user')

    puts return_obj

    if return_obj['return_code'] == 1
      assert true
    else
      assert false
    end
  end
end
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

  # 测试读取一个用户
  # 每一个测试一开始数据库都会被清空，所有先写一个用户进去
  test 'get user information' do
    # 写一个用户进去
    input_params = {}

    input_params[:user_name] = 'zhendu'
    input_params[:user_email] = 'zhendu@test.com'
    input_params[:user_password] = '123456'

    # 发送请求
    send_ajax_request('POST', input_params, '/extend_users/add_new_user')

    # 给一个用户名
    input_params = {}

    input_params[:user_name] = 'zhendu'

    # 使用get来获取用户
    return_obj = send_ajax_request('GET', input_params, '/extend_users/get_user_information')

    if return_obj['name']=='zhendu' && return_obj['email']=='zhendu@test.com'
      assert true
    else
      assert false
    end
  end

  # 修改用户数据
  # test 'modify user information' do
  #   # 先存一个数据
  #
  # end
end
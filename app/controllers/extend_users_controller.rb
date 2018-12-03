class ExtendUsersController < ApplicationController
  def get_user_information
    user_name = params[:user_name]
    # 通过用户名来获取用户的基本信息
    # 假设到达这里的已经是唯一的username
    user_list = User.where(name: user_name)
    user_information = user_list[0]

    puts user_information.created_at.class

    render json: {
        name: user_information.name,
        email: user_information.email,
        sex: user_information.sex,
        phonenumber: user_information.phonenumber,
        createtime: user_information.created_at.to_s(:rfc822)
    }
  end

  # 添加一个新的函数创建新用户的函数
  # 从前端获取用户的姓名、email、
  def add_new_user
    user_name = params[:user_name]
    user_email = params[:user_email]
    user_password = params[:user_password]

    puts user_name, user_email, user_password

    #======下面的代码做用户名和邮箱的唯一性校验========
    # 主要是用户名和用户邮箱都要有唯一性
    # 将是不是唯一的变量存在下面的变脸中，是唯一的就赋1，反之给0
    unique = 1
    if (User.where("user_name =  '" + user_name +"'").count||User.where( " user_email = '"+user_email+"'").count)
        unique = 0
    end
    #如果校验失败就返回0，就执行下面两句代码
    if (unique == 0)
      render json: {return_code: 0}
      return
    end

    #======上面的代码做用户名和邮箱的唯一性校验========

    # 参考seed脚本的代码
    User.create(
        name: user_name,
        email: user_email,
        password: user_password,

        # 下面都是随机
        role: Faker::Number.between(1, 4),
        sex: ['male', 'female'].sample,
        phonenumber: Faker::PhoneNumber.phone_number,
        status: Faker::Company.profession
    )

    render json: {return_code: 1}
  end
end
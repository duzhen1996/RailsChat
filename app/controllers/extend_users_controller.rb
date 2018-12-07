class ExtendUsersController < ApplicationController
  def get_user_information
    user_name = params[:user_name]
    # 通过用户名来获取用户的基本信息
    # 假设到达这里的已经是唯一的username
    user_list = User.where(name: user_name)
    user_information = user_list[0]


    render json: {
        name: user_information.name,
        email: user_information.email,
        sex: user_information.sex,
        phonenumber: user_information.phonenumber,
        createtime: user_information.created_at.to_s(:rfc822)
    }
  end

  # 修改用户资料
  # 主要的根据是user_id
  # 可以修改的是user_name，user_email，user_sex
  # 并不是所有的字段都要被修改
  # 对于不需要修改的值，传入的是和之前一样的值
  def modify_user_information
    user_name = params[:user_name]
    user_email = params[:user_email]
    user_sex = params[:user_sex]
    user_id = params[:user_id].to_i

    return_code = 1

    #============修改数据库==============
    # 主要流程如下：
    # 1、首先进行查重，将三个字段和user_id与当前用户不一样的人进行比较
    # 2、如果user_name和user_email同时通过通过了除了自己之外的查重
    # 3、将user_name，user_email，user_sex，更新到user_id对应行中
    # 4、如果出现问题，将返回值改成0，主要是查重不通过导致的

    # 查重
    if (User.where(
        "(name = '" + user_name + "'" +
            " OR email = " + "'" + user_email + "'" +
            ") AND id != " + user_id.to_s).count != 0)

      # 这里说明查重不过
      return_code = 0
    else
      # 这里说明查重过了，更新数据
      user_new = User.find_by(id: user_id)
      user_new.name = user_name
      user_new.email = user_email
      user_new.sex = user_sex
      user_new.save
    end

    #============修改数据库==============
    render json: {return_code: return_code}

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
    if (User.where("user_name =  '" + user_name + "'").count || User.where(" user_email = '" + user_email + "'").count)
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
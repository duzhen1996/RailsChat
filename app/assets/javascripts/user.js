//这里添加一个新的用户，传入三个参数，一个是用户名
//一个是用户的邮箱，一个是密码
//返回值为1代表成功添加，返回值为0代表用户名或者邮箱重复
function add_new_user(user_name, user_email, user_password) {
    //这里提交代码
    var url = "/extend_users/add_new_user";

    //返回值
    var return_code = 0;

    $.ajax({
        url: url,
        method: "POST",
        async: false,
        data: {
            user_name: user_name,
            user_email: user_email,
            user_password: user_password
        },
        success: function (response) {
            return_code = response.return_code;
        }
    });

    //返回
    return return_code;
}

//这里获取一个用户的基本信息
//返回的信息中会带有return_code字段来判断是不是搞对了
//每个字段的来源
// name: user_information.name,
// email: user_information.email,
// sex: user_information.sex,
// phonenumber: user_information.phonenumber,
// createtime: user_information.created_at.to_s(:rfc822)
function get_user_information(user_name) {
    var url = '/extend_users/get_user_information'


    var information = null;
    $.ajax({
        url: url,
        method: 'GET',
        async: false,
        data: {
            user_name: user_name,
        },
        success: function (response) {
            information = response;
        }
    });

    return information;
}

//这里修改用户用户名、邮箱、性别
//可以修改其中的一个或者多个，对于不修改的，就传和原来一样的值就好了
function modify_user_information(user_id, user_name, user_email, user_sex) {
    var url = '/extend_users/modify_user_information';

    var return_code = 1;

    $.ajax({
        url: url,
        method: 'POST',
        async: false,
        data: {
            user_id: user_id,
            user_name: user_name,
            user_email: user_email,
            user_sex: user_sex,
        },
        success: function (response) {
            return_code = response.return_code;
        }
    });

    return return_code;
}
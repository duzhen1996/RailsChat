require 'net/http'
require 'uri'
require 'json'

class RobotController < ApplicationController

  #接受一句话，接受和返回的都是一个字符串
  def chat_with_robot
    input_str = params[:input_string]

    # 这里提交post请求
    url = URI('http://openapi.tuling123.com/openapi/api/v2')

    # 这里设计请求内容，一开始是写成map，然后调用to_json转化为json字符串
    data = {
        "reqType": 0,
        "perception": {
            "inputText": {
                "text": input_str,
            },
        },
        "userInfo": {
            "apiKey": "7992efa1d9d34cb69a201e7ab181f5b9",
            "userId": "345468"
        }
    }.to_json

    req = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
    req.body = data

    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req)}

    puts JSON.parse(res.body)
    result = JSON.parse(res.body)["results"][0]["values"]["text"]

    render json: {output_string: result}
  end

  # 这里写一个函数来传入一个评价信息
  def store_evaluation
    user_id = params[:user_id].to_i
    user_score = params[:user_score].to_i
    chat_time = params[:chat_time].to_i
    correspond_time = params[:correspond_time].to_i

    puts user_score, chat_time, correspond_time
    sum = 0
    Robot.new(:user_id => user_id, :user_score => user_score, :chat_time => chat_time, :correspond_time => correspond_time).save
    list = Robot.where(user_id = 1)
    for i in 0..list.size - 1
      user_score = list[i].user_score + user_score
    end
    user_score = user_score / list.size
    for i in 0..list.size - 1
      list[i].average_score = user_score
      list[i].chat_time = chat_time
      list[i].correspond_time = correspond_time
      if list[i].save
        sum = sum + 1
      end
    end
    #========上面的内容将存储用户的评价信息============
    # 根据上面取的结果来给浏览器返回值，1代表成功，0代表失败。
    # 没有成功返回
    if sum == list.size
      render json: {return_code: 1}
    else
      render json: {return_code: 0}
    end

  end

  # 这里写一个函数来获取各方面的来获取用户平均分数、平均交流时间、平均响应时间
  def get_evaluation

    # 这里获取用户的id
    user_id = params[:user_id]

    #==============下面读数据库来获取三个字段，并且填充到上面的几个变量中===============
    @robot = Robot.find_by_user_id(user_id)
    user_score = @robot.average_score
    chat_time = @robot.chat_time
    correspond_time = @robot.correspond_time


    #=============上面读数据库来获取三个字段，并且填充到上面的几个变量中===============

    render json: {user_score: user_score, chat_time: chat_time, correspond_time: correspond_time}
  end

end


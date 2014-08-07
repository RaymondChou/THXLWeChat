class WechatsController < ApplicationController
  wechat_responder

  on :event, :with => 'subscribe' do |request, content|
    request.reply.news(title: "欢迎关注江苏天泓雪莱", description:"点击进入微官网", pic_url: "http://mmbiz.qpic.cn/mmbiz/9BP0w04QGTCdyrBmxib4mx9elLl4icp5cAOQOPAFs3anB4kHTCL1eH5LAKKfoB3S1ggO9W5x7MsTERibviaVSXRe5Q/640", url:"http://thxl.memeing.cn")
  end

  # 默认的文字信息responder
  on :text do |request, content|
    request.reply.news(title: "欢迎关注江苏天泓雪莱", description:"点击进入微官网", pic_url: "http://mmbiz.qpic.cn/mmbiz/9BP0w04QGTCdyrBmxib4mx9elLl4icp5cAOQOPAFs3anB4kHTCL1eH5LAKKfoB3S1ggO9W5x7MsTERibviaVSXRe5Q/640", url:"http://thxl.memeing.cn")
  end

  # 当请求的文字信息内容为'help'时, 使用这个responder处理
  on :text, with:"help" do |request, help|
    # request.reply.text "help content" #回复帮助信息
  end

  # 处理图片信息
  on :image do |request|
    # request.reply.image(request[:MediaId]) #直接将图片返回给用户
  end

  # 处理语音信息
  on :voice do |request|
    # request.reply.voice(request[:MediaId]) #直接语音音返回给用户
  end

  # 处理视频信息
  on :video do |request|
    # nickname = wechat.user(request[:FromUserName])["nickname"] #调用 api 获得发送者的nickname
    # request.reply.video(request[:MediaId], title: "回声", description: "#{nickname}发来的视频请求") #直接视频返回给用户
  end

  # 处理地理位置信息
  on :location do |request|
    # request.reply.text("#{request[:Location_X]}, #{request[:Location_Y]}") #回复地理位置
  end

  # 当无任何responder处理用户信息时,使用这个responder处理
  on :fallback do |request|
    request.reply.news(title: "欢迎关注江苏天泓雪莱", description:"点击进入微官网", pic_url: "http://mmbiz.qpic.cn/mmbiz/9BP0w04QGTCdyrBmxib4mx9elLl4icp5cAOQOPAFs3anB4kHTCL1eH5LAKKfoB3S1ggO9W5x7MsTERibviaVSXRe5Q/640", url:"http://thxl.memeing.cn")
  end
end
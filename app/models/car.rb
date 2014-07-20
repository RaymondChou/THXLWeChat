class Car < ActiveRecord::Base
  attr_protected

  def self.fetch_detail(car_en)
    url  = "http://m.chevrolet.com.cn/data/feature_#{car_en.downcase}_1.txt"
    response = open(url)
    json = JSON.parse(response.read.force_encoding('UTF-8').gsub("\xEF\xBB\xBF".force_encoding("UTF-8"), ''))

    name = json['name']
    p name

    models = json['allModels']
    # p "models: #{models}"
    p "=================="

    models.each do |model|
      url  = "http://m.chevrolet.com.cn/data/feature_#{car_en.downcase}_#{model['id']}.txt"
      response = open(url)
      json = JSON.parse(response.read.force_encoding('UTF-8').gsub("\xEF\xBB\xBF".force_encoding("UTF-8"), ''))

      model = json['model'].gsub('%title3%', '')
      p model + " >>>>"
      pic = json['pic']
      datas = json['datas']
      details = Array.new
      price = ''
      datas.each do |data|
        if data['name'] == '__TITLE__' or data['name'].blank?
          next
        elsif data['name'].include?('价格') or data['name'].include?('指导价')
          price = data['value'][0].gsub('元', '').gsub(' ', '').gsub("￥", '')
        else
          details << "#{data['name']};;#{data['value'][0].gsub("\n",'')}"
        end
      end
      details_text = details.join("\n")

      CarDetail.create(
          :en => car_en,
          :name => name,
          :model => model,
          :price => price,
          :image => pic,
          :detail => details_text
      )
    end

  end

end

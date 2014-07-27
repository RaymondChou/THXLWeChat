require 'nokogiri'

class ToolController < ApplicationController

  def bx_cal

  end

  def dk_cal

  end

  def qk_cal

  end

  def weizhang

  end

  def weizhang_result
    # 苏a6wk70
    # 120056
    licence = params[:licence].upcase
    engine_code = params[:engine_code]

    cookies[:licence] = licence
    cookies[:engine_code] = engine_code

    weizhang = WeiZhang.find_by_licence(licence)
    if weizhang.present?
      if weizhang.job_status != 1
        result = get_job weizhang.job_id
        if result['data'].present?
          weizhang.result = result['data']
          weizhang.job_status = 1
          weizhang.save

          items = Array.new
          doc = Nokogiri.HTML(result['data'])
          doc.search('table').search('tbody').search('tr').each do |tr|
            tds = tr.search('td')
            items << {:id => tds[0].text, :time => tds[1].text, :addr => tds[2].text, :event => tds[3].text.gsub('的',''), :fen => tds[4].text, :qian => tds[5].text, :handle => tds[6].text}
          end

          render :json => {:content => items, :job_status => result['job_status']}
        else
          render :json => {:job_id => result['job_id'], :job_status => result['job_status']}
        end
      else
        job = post_job(licence, engine_code)

        weizhang.job_id = job['job_id']
        weizhang.job_status = job['job_status']
        weizhang.result = job['data']
        weizhang.save

        if job['data'].present?
          items = Array.new
          doc = Nokogiri.HTML(job['data'])
          doc.search('table').search('tbody').search('tr').each do |tr|
            tds = tr.search('td')
            items << {:id => tds[0].text, :time => tds[1].text, :addr => tds[2].text, :event => tds[3].text.gsub('的',''), :fen => tds[4].text, :qian => tds[5].text, :handle => tds[6].text}
          end
          render :json => {:content => items, :job_status => job['job_status']}
        else
          render :json => {:job_id => job['job_id'], :job_status => job['job_status']}
        end
      end
    else
      weizhang = WeiZhang.new
      weizhang.licence = licence
      weizhang.engine_code = engine_code

      job = post_job(licence, engine_code)

      weizhang.job_id = job['job_id']
      weizhang.job_status = job['job_status']
      weizhang.result = job['data']
      weizhang.save

      if job['data'].present?
        items = Array.new
        doc = Nokogiri.HTML(job['data'])
        doc.search('table').search('tbody').search('tr').each do |tr|
          tds = tr.search('td')
          items << {:id => tds[0].text, :time => tds[1].text, :addr => tds[2].text, :event => tds[3].text.gsub('的',''), :fen => tds[4].text, :qian => tds[5].text, :handle => tds[6].text}
        end
        render :json => {:content => items, :job_status => job['job_status']}
      else
        render :json => {:job_id => job['job_id'], :job_status => job['job_status']}
      end
    end
  end

  def post_job licence, engine_code
    data = Hash.new
    data['province'] = '江苏'
    data['city_pinyin'] = 'nanjing'
    data['car_province'] = '苏'
    data['license_plate_num'] = licence.gsub('苏', '')
    data['engine_num'] = engine_code
    data['save'] = '1'

    conn = Faraday.new(:url => 'http://chaxun.wcar.net.cn')
    response = conn.post do |req|
      req.url '/'
      req.headers['User-Agent'] = 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36'
      req.body = data
    end

    JSON.parse response.body
  end

  def get_job job_id
    data = Hash.new
    data['job_id'] = job_id

    conn = Faraday.new(:url => 'http://chaxun.wcar.net.cn')
    response = conn.post do |req|
      req.url '/'
      req.headers['User-Agent'] = 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36'
      req.body = data
    end

    JSON.parse response.body
  end

  def care
    if cookies[:user_car_id].blank?
      redirect_to '/tool/care_edit'
    else
      @user_car = UserCars.find(cookies[:user_car_id])
      @baoyang_day = 0
      if @user_car.last_baoyang_time.present?
        @baoyang_day = 180 - ((Time.now - Date.parse(@user_car.last_baoyang_time).to_time).to_i/3600/24)%180
      end

      @baoxian_day = 0
      if @user_car.last_baoxian_time.present?
        @baoxian_day = 365 - ((Time.now - Date.parse(@user_car.last_baoxian_time).to_time).to_i/3600/24)%365
      end

      @nianjian_day = 0
      if @user_car.licence_time.present?
        if Time.now - Date.parse(@user_car.licence_time).to_time > 6.years
          # 一年一次
          @nianjian_day = 365 - ((Time.now - Date.parse(@user_car.licence_time).to_time).to_i/3600/24)%365
        else
          # 两年一次
          @nianjian_day = 830 - ((Time.now - Date.parse(@user_car.licence_time).to_time).to_i/3600/24)%830
        end
      end
    end
  end

  def care_edit
    if cookies[:user_car_id].present?
      @user_car = UserCars.find(cookies[:user_car_id])
    else
      @user_car = UserCars.new
    end
  end

  def care_sub
    params.delete(:controller)
    params.delete(:action)

    if cookies[:user_car_id].blank?
      @user_car = UserCars.new(params)
      @user_car.save
    else
      @user_car = UserCars.find(cookies[:user_car_id])
      @user_car.update_attributes(params)
    end
    cookies.permanent[:user_car_id] = @user_car.id

    redirect_to '/tool/care'
  end

end

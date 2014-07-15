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
    licence = params[:licence].upcase
    engine_code = params[:engine_code]

    weizhang = WeiZhang.find_by_licence(licence)
    if weizhang.present?
      if weizhang.job_status != 1
        result = get_job weizhang.job_id
        if result['data'].present?
          weizhang.result = result['data']
          weizhang.job_status = 1
          weizhang.save
          render :json => {:content => result['data'], :job_status => result['job_status']}
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
          render :json => {:content => job['data'], :job_status => job['job_status']}
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
        render :json => {:content => job['data'], :job_status => job['job_status']}
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

end

class Admin::AdsController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    @ads = Ad.order('sort asc').paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @ad = Ad.new
  end

  def create
    image = params[:ad][:image]
    if image.present?
      filename = "#{Time.now.to_i}.png"
      File.open("#{Rails.root}/public/statics/#{filename}", "wb+") do |f|
        f.write(image.read)
      end
      params[:ad][:image] = "/statics/#{filename}"
    end
    @ad = Ad.new(params[:ad])
    @ad.save
    redirect_to admin_ads_path, :notice => '创建成功'
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])

    image = params[:ad][:image]
    if image.present?
      filename = "#{Time.now.to_i}.png"
      File.open("#{Rails.root}/public/statics/#{filename}", "wb+") do |f|
        f.write(image.read)
      end
      params[:ad][:image] = "/statics/#{filename}"
    else
      params[:ad][:image] = @ad.image
    end
    @ad.update_attributes(params[:ad])
    @ad.save
    redirect_to admin_ads_path, :notice => '修改成功'
  end

  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy
    redirect_to admin_ads_path, :notice => '删除成功'
  end

end

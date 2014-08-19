class Admin::PagesController < Admin::BaseController
  layout 'admin/layouts/application'

  def update
    page = Page.find(params[:id])
    page.url = params[:page][:url]
    page.save
    redirect_to :back, :notice => '保存成功！'
  end

  def create
    page = Page.new(params[:page])
    page.save
    redirect_to :back, :notice => '保存成功！'
  end

end

class Admin::ContactsController < Admin::BaseController
  layout 'admin/layouts/application'

  def index
    @contacts = Contact.order('sort asc').paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @contact = Contact.new
  end

  def create
    avatar = params[:contact][:avatar]
    if avatar.present?
      filename = "#{Time.now.to_i}.png"
      File.open("#{Rails.root}/public/statics/#{filename}", "wb+") do |f|
        f.write(avatar.read)
      end
      params[:contact][:avatar] = "/statics/#{filename}"
    end
    @contact = Contact.new(params[:contact])
    @contact.save
    redirect_to admin_contacts_path, :notice => '创建成功'
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])

    avatar = params[:contact][:avatar]
    if avatar.present?
      filename = "#{Time.now.to_i}.png"
      File.open("#{Rails.root}/public/statics/#{filename}", "wb+") do |f|
        f.write(avatar.read)
      end
      params[:contact][:avatar] = "/statics/#{filename}"
    else
      params[:contact][:avatar] = @contact.avatar
    end
    @contact.update_attributes(params[:contact])
    @contact.save
    redirect_to admin_contacts_path, :notice => '修改成功'
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to admin_contacts_path, :notice => '删除成功'
  end

end

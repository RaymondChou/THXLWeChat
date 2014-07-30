class Admin::SessionsController < Devise::SessionsController
  layout false

  private

  def after_sign_out_path_for(resource_or_scope)
    '/admin/sign_in'
  end

end
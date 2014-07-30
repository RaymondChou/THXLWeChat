class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!

  protected

  def render_not_found!
    render 'admin/errors/404', :layout => false, :status => 404
  end
end

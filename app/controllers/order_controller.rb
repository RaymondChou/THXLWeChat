class OrderController < ApplicationController

  def drive

  end

  def drive_sub
    if params[:confirm] == '1'
      params.delete(:confirm)
      params.delete(:controller)
      params.delete(:action)
      OrderDrive.new(params).save
    end
  end

  def care

  end

  def care_sub

  end

end

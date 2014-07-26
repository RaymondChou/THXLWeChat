class ContactController < ApplicationController

  def show
    @contacts = Contact.order("sort asc").all
  end

end

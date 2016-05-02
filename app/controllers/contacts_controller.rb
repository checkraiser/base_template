class ContactsController < ApplicationController
  def manage
    authorize :contact
    respond_to do |format|
      format.html {}
    end
  end
end
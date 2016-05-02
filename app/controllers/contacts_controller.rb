class ContactsController < ApplicationController
  def manage
    authorize :contact
  end
end
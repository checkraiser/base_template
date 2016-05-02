class ClientsController < ApplicationController
  def manage
    authorize :client
    respond_to do |format|
      format.html {}
    end
  end
end
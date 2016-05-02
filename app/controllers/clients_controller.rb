class ClientsController < ApplicationController
  def manage
    authorize :client
  end
end
class ClientsController < ApplicationController
  def manage
    authorize :client
    get_all_clients
    respond_to do |format|
      format.html {}
    end
  end

  def index
    authorize :client
    clients = Client.all
    render json: {clients: clients}
  end
  def create
    @client = Client.new(client_params)
    authorize @client
    save_resource @client
  end

  def update
    @client = Client.find(params[:id])
    authorize @client
    update_resource @client, client_params
  end

  protected
  def client_params
    params.require(:client).permit(:name, :url)
  end
  def get_all_clients
    gon.clients = Client.all
  end
end
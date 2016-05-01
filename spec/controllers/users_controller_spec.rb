require 'rails_helper'

describe UsersController do
  include_context :gon
  describe "GET #index" do
    let!(:admin) { FactoryGirl.create(:user, :admin) }
    it "render index template" do
      sign_in(admin)
      get :index
      expect(response).to render_template(:index)
    end

  end
end
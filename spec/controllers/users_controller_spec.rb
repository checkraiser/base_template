require 'rails_helper'

describe UsersController do
  include_context :gon
  describe "GET #index" do
    let!(:admin) { FactoryGirl.create(:user, :admin) }
    before do
      sign_in admin
    end
    it "render index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "returns gon.users" do
      (1..10).each { |t| FactoryGirl.create(:user) }
      get :index
      expect(gon['users'].count).to eq 11
    end
  end
end
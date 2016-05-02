require 'rails_helper'

describe UsersController do
  include_context :gon
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  before do
    sign_in admin
  end
  describe "GET #manage" do
    it "render manage template" do
      get :manage
      expect(response).to render_template(:manage)
    end
    it "returns gon.users" do
      (1..10).each { |t| FactoryGirl.create(:user) }
      get :manage
      expect(gon['users'].count).to eq 11
    end
  end
  describe "GET #index" do
    let!(:user) { FactoryGirl.create(:user) }
    it "return users with index" do
      get :index
      expect(json_body['users'].count).to eq 2
    end
  end
end
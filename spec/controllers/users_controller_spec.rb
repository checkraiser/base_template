require 'rails_helper'

describe UsersController do
  include_context :gon
  describe "GET #manage" do
    let!(:admin) { FactoryGirl.create(:user, :admin) }
    before do
      sign_in admin
    end
    it "render index template" do
      get :manage
      expect(response).to render_template(:manage)
    end
    it "returns gon.users" do
      (1..10).each { |t| FactoryGirl.create(:user) }
      get :manage
      expect(gon['users'].count).to eq 11
    end
  end
end
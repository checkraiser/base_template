require 'rails_helper'

describe UsersController do
  include_context :gon
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:user)  { FactoryGirl.create(:user) }
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
      expect(gon['users'].count).to eq 12
    end
  end
  describe "GET #index" do
    let!(:user) { FactoryGirl.create(:user) }
    it "return users with index" do
      get :index
      expect(json_body['users'].count).to eq 2
    end
  end
  describe "POST #create" do
    let(:user_params) {
      {first_name: 'test user', last_name: 'test last name', email: 'testemail@example.com', password: '12345678', password_confirmation: '12345678',
        role: 'admin'}
    }
    it "it creates new user" do
      expect {
        post :create, user: user_params
      }.to change(User, :count).by 1
      expect(User.last.email).to eq user_params[:email]
    end
    it "it doesn't allow empty email and role" do
      post :create, user: {}
      expect(response.status).to eq 400
      expect {
        post :create, user: {}
      }.to change(User, :count).by 0
      post :create, user: {email: "", role: ""}
      expect(response.status).to eq 400
    end
  end
  describe "PUT #update" do
    let(:user_params) {
      {first_name: 'test user', last_name: 'test last name', email: 'testemail@example.com', password: '12345678', password_confirmation: '12345678',
       role: 'admin'}
    }
    it "it updates user" do
      put :update, id: user.id, user: user_params
      expect(user.reload.email).to eq user_params[:email]
      expect(user.reload.role).to eq user_params[:role]
    end
    it "it doesn't allow empty email and role" do
      put :update, id: user.id, user: {}
      expect(response.status).to eq 400
      put :update, id: user.id, area: {email: "", role: ""}
      expect(response.status).to eq 400
    end
  end
end
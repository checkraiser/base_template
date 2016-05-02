require 'rails_helper'

describe ContactsController do
  include_context :gon
  describe "GET #manage" do
    let!(:admin) { FactoryGirl.create(:user, :admin) }
    before do
      sign_in admin
    end
    it "render manage template" do
      get :manage
      expect(response).to render_template(:manage)
    end
  end
end
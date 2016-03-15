require 'rails_helper'

feature "Home page", js: true  do
	scenario "Hello World" do 
		visit '/'
		expect(page).to have_content("Hello World")
	end	
end
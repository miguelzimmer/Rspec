require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe "GET /users" do
        it "returns success status" do
            get users_path
            expect(response).to have_http_status(200)
        end
        it "The user's tittle is present" do
            users = create_list(:user, 3)
            get users_path
            users.each do |user|
                expect(response.body).to include(user.title)  
            end
        end    
    end
    describe "POST /users" do
        context "when it has valid parameters" do
            it "create the user with correct atributes" do
                user_atributes = FactoryBot.attributes_for(:user)
                post users_path, params: { user: user_atributes }
                expect(User.last).to have_attributes(user_atributes)  
            end          
        end
        context "when it has no valid parameters" do
            it "does note create user" do
                expect {
                post users_path, params: { user: {kind: '', name: '', level: ''}}
                }.to_not change(User, :count)
            end
        end
    end  
end
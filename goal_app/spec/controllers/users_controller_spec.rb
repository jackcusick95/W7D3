require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    subject(:user) do
        FactoryBot.build(:user, username: 'user123', password: 'password123')
    end

    describe "GET #new" do 
        it "renders the new template" do 
            get :new 
            expect(response).to render_template("new")
        end 
    end 

    describe "POST #create" do 
       context "with invalid params" do
            it "validates the presence of users email and password" do 
                post :create, params: {user: {username: "jack123", password: nil }}
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end  

            it "validates that the password is longer than 6 characters" do 
                post :create, params: {user: {username: "jack123", password: "abc" }}
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end  
       end 

       context "with valid params" do 
            it "renders the new users show page" do 
               post :create, params: {user: {username: "jack123", password: "password123" }} 
               expect(response).to redirect_to(user_url(User.last))
            end 
       end 

    end 

    describe "GET #show" do 
        before(:each) { user.save }
        it "renders the show template" do 
            get :show, params: {id: User.last.id }
            expect(response).to render_template("show")
        end 
    end

end 

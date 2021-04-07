class SessionsController < ApplicationController

    def new 
        render :new 
    end

    def create
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if user.nil?
            flash.now[:errors] = ['Invalid errors']
            render :new
        else
            login_user!(user)
            redirect_to users_url
        end
    end

end
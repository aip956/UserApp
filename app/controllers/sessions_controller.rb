class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        user = User.find_by(email: params[:email])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user.as_json(except: :password_digest), status: :created
        else
            render json: {error: 'Invalid email or password' }, status: :unprocessable_entity
        end
    end 
end

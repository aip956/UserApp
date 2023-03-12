class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @users = User.select(:id, :firstname, :lastname, :age, :email).all
        render json: @users
    end
    
    def show
        user = User.find_by(id:params[:id])
        render json: user.to_json
    end 
    
    def new 
        user = User.new
        render json: user.to_json
    end
    
    def create 
        # Will save and redirect
        @user = User.new(allowed_params)
        if @user.save
            render json: @user.as_json
            redirect_to @user.as_json(except: [:password]), status: :created
        else
            # Go back to "new" action
            render json: @user.errors, status: :unprocessable_entity
        end

    end
    
    def edit 
        @user = User.find(params[:id])
    end
    
    def update 
        @user = User.find(params[:id])
        if @user.update(allowed_params)
            redirect_to users_path
        else
            # Go back to "new" action
            render 'new'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            flash[:success] = "User successfully deleted"
            redirect_to users_path 
        else
            flash[:error] = "Error deleting user"
            redirect_to users_path
        end

    end
    
    private
        def allowed_params
            params.require(:user).permit(:firstname, :lastname, :age, :password, :email)
        end


end

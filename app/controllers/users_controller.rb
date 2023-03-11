class UsersController < ApplicationController
    def index
        @users = User.all
    end
    
    def show
    end 
    
    def new 
        @user = User.new
    end
    
    def create 
        # Will save and redirect
        @user = User.new(allowed_params)

        if @user.save
            redirect_to users_path
        else
            # Go back to "new" action
            render 'new'
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
        @user.destroy
        redirect_to users_path, notice: "User successfully deleted"
    end
    
    private
        def allowed_params
            params.require(:user).permit(:firstname, :lastname, :age, :password, :email)
        end


end

class UsersController < ApplicationController 

    def index 
        @users = User.all
        render :index
    end

    def show
        # debugger 
        @user = User.find(params[:id])
        render :show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages 
            render :new
        end
    end

    def destroy 
        @user = User.find(params[:id])
        @user.destroy
        render :new
    end


    def user_params 
        params.require(:user).permit(:username, :password)
    end

    
#create
#destroy 
#update

end

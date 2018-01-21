class UsersController < ApplicationController

def new
end
#if we do not have anything here, it will try to render a page automatically. the page that it tries to load is in the views folder that matches the def name 

#writing fail in our method is a good way to check that our routing is working 

def create
    #do not need this @
    @user = User.new(user_params)
    if @user.save
        session[:user_id]=@user.id
        redirect_to ideas_path
        #or '/ideas'
    else
        flash[:errors] = @user.errors.full_messages
        redirect_to :back
    end
end
#session[] is a special hash that is saves information and can be retrieved
#flash[] is another special hash --> remember we can view our errors with user.errors.full_messages in our rails console 

def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) 
        session[:user_id]=user.id
        redirect_to ideas_path
    else
        flash[:errors] = ["Invalid Email/Password combination"]
        redirect_to :back
end
end

def show
    @c_user = User.find(params[:id])
    @total_ideas = Idea.joins(:user).select("COUNT(user_id) AS tot", :user_id).where(user_id: params[:id])
end



def destroy
    session.delete(:user_id)
    redirect_to root_path
end
  

private
    def user_params
        params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
    end

end

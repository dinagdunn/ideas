class IdeasController < ApplicationController
    before_action  :current_user, :require_login

def index
    @c_user = current_user
    @ideas = User.joins(:ideas).select("*")
    @likes = Like.select("SUM (idea_id) AS total").where(idea_id = params[:id])
    
    #or we can find the user with @user = User.find(session[:user_id])

end

def create
    #we do not need this @ since we are not showing this in the views? will flash still work then since it's in the ap
    @idea = Idea.new(idea_params)
    if @idea.save
        #idea.user = User.find(session[:user_id]) ==> we can do this instead of of the hidden input.. since the person in session will always be the one creating the idea. this will just automatically 
        redirect_to ideas_path

    else
        flash[:errors] = @idea.errors.full_messages
        redirect_to :back
    end


#we can refactor the code with  
#unless idea.save
#flash[:errors]

#redirect to back 

end

def show
    @c_idea = Idea.find(params[:id])
    @poster = User.joins(:ideas).where(idea_id: @c_idea)
    @total_ideas = Idea.joins(:user).select("COUNT(user_id) AS tot", :user_id).where(user_id: params[:id]) #if we do something like this, we need to iterate as an array with .each do ==> even though we see one object, it is actually multiple objects so we must interate through this 
        #or! if we add a .first, it will return that one object and then we can access it as @total_ideas.tot
  end

def destroy
    Idea.find(params[:id]).destroy
    redirect_to ideas_path
end

private
def idea_params
    params.require(:idea).permit(:desc, :user_id)
    #params.require(:idea, :user_id).permit(:desc, :user_id) if we are going to use the hidden input? test this out if you need user_id in the .require part 
end

end

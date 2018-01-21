class LikesController < ApplicationController

def create
@like = Like.new(like_params)
if @like.save
    redirect_to ideas_path

end
end

private
def like_params
    params.require(:like).permit(:user_id, :idea_id)
end
end

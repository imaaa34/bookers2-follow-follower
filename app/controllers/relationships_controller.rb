class RelationshipsController < ApplicationController
 
  def create
    @user = User.find(params[:relationship][:follower_id])
    following = current_user.follower(@user)
    if following.save
      redirect_to @user
    else
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:relationship][:follower_id])
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to @user
    else
      redirect_to @user
    end
  end
  
end

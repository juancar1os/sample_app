class RelationshipsController < ApplicationController
  before_filter :authenticate
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    #Responder a AJAX
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    #AJAX
    respond_to do |format|
      format.html {redirect_to @user }
      format.js
    end
  end
end
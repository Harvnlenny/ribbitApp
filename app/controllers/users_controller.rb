class UsersController < ApplicationController
  

  def new
    if current_user
      redirect_to buddies_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
 
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up for Ribbit!"
    else
      render 'new'
    end
  end

  def buddies
    if current_user
        @ribbit = Ribbit.new
        buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
        @ribbits = Ribbit.find_all_by_user_id buddies_ids
    else
        redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
    @ribbit = Ribbit.new
    @relationship = Relationship.where(
      follower_id: current_user.id,
      followed_id: @user.id
    ).first_or_initialize if current_user
  end

  def index
    @users = User.all
  end

  def create_avatar_url
    self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :username, :name, :password, :avatar_url, :password_confirmation)
  end
end

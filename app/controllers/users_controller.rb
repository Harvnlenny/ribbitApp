class UsersController < ApplicationController
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
 
    if @user.save
      redirect_to @user, notice: "Thank you for signing up for Ribbit!"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create_avatar_url
    self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :username, :name, :password, :avatar_url, :password_confirmation)
  end
end

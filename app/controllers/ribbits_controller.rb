class RibbitsController < ApplicationController

  def create
    @ribbit = Ribbit.new(ribbit_params)
    @ribbit.userid = current_user.id
 
    if @ribbit.save
      redirect_to current_user 
    else
      flash[:error] = "Problem!"
      redirect_to current_user
    end
  end

  def index
    @ribbits = Ribbit.all include: :user
    @ribbit = Ribbit.new
  end

  private
    def ribbit_params
      params.require(:ribbit).permit(:content, :userid)
    end
end

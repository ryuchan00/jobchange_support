class LinksController < ApplicationController
  before_action :current_user_tw, only: [:github_new, :github]

  def create
    # @link = Link.new(link_params)
    @link = current_user_tw.links.build(link_params)

    if @link.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :github_new
    end
  end

  def destroy
  end

  def github_new
    @link = Link.new
    @link.provider = 'github'
  end

  def github
    @current_user.link(@current_user, 'github')
    if @current_user
      redirect_to :action => "github_new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def link_params
    params.require(:link).permit(:link, :provider)
  end
end

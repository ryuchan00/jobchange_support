class LinksController < ApplicationController
  before_action :current_user_tw, only: [:github_new, :github, :cloud9_new, :cloud9, :show, :update]

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

  # def github_new
  #   @link = Link.new
  #   @link.provider = 'github'
  # end

  def github
    @current_user.link(@current_user, 'github')
    if @current_user
      redirect_to :action => "github_new"
    end
  end

  # def cloud9_new
  #   @link = Link.new
  #   @link.provider = 'cloud9'
  # end

  def cloud9
    @current_user.link(@current_user, 'cloud9')
    if @current_user
      redirect_to :action => "cloud9_new"
    end
  end

  def show
    @github = @current_user.link(@current_user, 'github')
    @cloud9 = @current_user.link(@current_user, 'cloud9')
  end

  def update
    @github = @current_user.link(@current_user, 'github')
    @cloud9 = @current_user.link(@current_user, 'cloud9')
    if @github.update(github_params) && @cloud9.update(cloud9_params)
      flash[:success] = '正常に更新されました'
    else
      flash[:danger] = '更新されませんでした'
    end
    redirect_to :action => "show"
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def link_params
    params.require(:link).permit(:link, :provider)
  end

  def github_params
    params.require(:github).permit(:link)
  end

  def cloud9_params
    params.require(:cloud9).permit(:link)
  end
end

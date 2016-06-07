class LinksController < ApplicationController

  def index
    @link = Link.new
    @links = Link.where(user_id: current_user.id)
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
    if @link.save
      redirect_to links_path
    else
      flash.now[:error] = "Please put in a valid URL! Tip: Url must start with http://(...)"
      render :edit
    end
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to links_path
    else
      flash.now[:error] = "Please put in a valid URL! Tip: Url must start with http://(...)"
      @links = Link.where(user_id: current_user.id)
      render :index
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end

end

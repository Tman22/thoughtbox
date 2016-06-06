class Api::V1::LinksController < Api::ApiController
  respond_to :json

  def update
    link = Link.find(params[:id])
    respond_with link.update(link_params)
  end

  private

  def link_params
    params.require(:data).permit(:title, :url, :status)
  end

end

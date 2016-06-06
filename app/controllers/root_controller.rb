class RootController < ApplicationController
  def index
    if current_user
      redirect_to links_path
    end
  end

end

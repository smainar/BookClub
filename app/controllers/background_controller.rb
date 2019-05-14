class BackgroundController < ApplicationController
  def image
    redirect_to "/assets/background_#{rand(5)}.jpg"
  end
end

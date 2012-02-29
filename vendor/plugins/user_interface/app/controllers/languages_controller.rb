class LanguagesController < ApplicationController

  def show
    change_language
  end
  
  def update
    change_language
  end
  
  private

  def change_language
    user_session.language = params[:id]
    logger.debug "Change session language to #{user_session.language}"
    redirect_to :back
  end

end

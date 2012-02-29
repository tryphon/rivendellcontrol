# -*- coding: utf-8 -*-
class LogsController < ApplicationController
  unloadable

  def show
    @log = Log.new

    @log.filter = params[:search]

    respond_to do |format|
      format.html 
      format.gz { send_data @log.compressed, :filename => 'log.gz' }
    end
  end

end

# -*- coding: utf-8 -*-
class SavePointsController < ApplicationController
  unloadable

  def new
    @save_point = SavePoint.new
  end

  def create
    @save_point = SavePoint.new params[:save_point]
    if @save_point.save
      flash[:success] = "La configuration est maintenant sauvée"
      redirect_to new_save_point_path
    else
      flash[:failure] = "La configuration n'a pu être sauvée"
      render :action => "new"
    end
  end

end

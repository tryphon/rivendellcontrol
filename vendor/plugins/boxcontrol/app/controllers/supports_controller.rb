# -*- coding: utf-8 -*-
class SupportsController < ApplicationController
  unloadable

  def show
    @support = Support.load
  end

  def edit
    @support = Support.load
  end

  def update
    @support = Support.new(params[:support])
    if @support.save
      flash[:success] = "La configuration a été modifiée avec succès"
      redirect_to support_path
    else
      flash[:failure] = "La configuration n'a pu être modifiée"
      render :action => "edit"
    end
  end

#  def request
#  end

#  def start 
#  end

end

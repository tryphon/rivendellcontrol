# -*- coding: utf-8 -*-
class NetworksController < ApplicationController
  unloadable

  def show
    @network = Network.load
  end

  def edit
    @network = Network.load
  end

  def update
    @network = Network.new(params[:network])
    if @network.save
      flash[:success] = "La configuration a été modifiée avec succès"
      redirect_to network_path
    else
      flash[:failure] = "La configuration n'a pu être modifiée"
      render :action => "edit"
    end
  end

end

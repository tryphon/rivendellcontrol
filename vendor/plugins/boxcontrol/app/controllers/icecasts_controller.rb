# -*- coding: utf-8 -*-
class IcecastsController < InheritedResources::Base
  unloadable

  actions :show, :edit, :update
  respond_to :html, :xml, :json

  protected

  def resource
    @icecast ||= Icecast.load
  end

end

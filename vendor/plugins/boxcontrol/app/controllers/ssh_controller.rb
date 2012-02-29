# -*- coding: utf-8 -*-
class SshController < InheritedResources::Base
  unloadable

  actions :show, :edit, :update
  respond_to :html, :xml, :json

  protected

  def resource
    @ssh ||= Ssh.load
  end
end

# -*- coding: utf-8 -*-
class InputsController < InheritedResources::Base
  unloadable

  actions :show, :edit, :update
  respond_to :html, :xml, :json

  protected

  def resource
    @input ||= Input.current
  end

  # FIXME : workaround for #8
  # see http://projects.tryphon.eu/boxcontrol/ticket/8
  def alsa_input_url(input)
    input_url
  end

end

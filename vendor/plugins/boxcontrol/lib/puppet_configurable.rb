module PuppetConfigurable

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      alias_method_chain :update_attributes, :save
    end
  end

  module ClassMethods

    def load
      self.new.tap(&:load)
    end

  end

  def puppet_configuration_prefix
    self.class.name.underscore
  end

  def load
    update_attributes_without_save PuppetConfiguration.load.attributes(puppet_configuration_prefix)
  end

  def update_attributes_with_save(attributes)
    update_attributes_without_save attributes
    save
  end

  def save
    return false if respond_to?(:valid?) and not valid?
    logger.debug "Save #{puppet_configuration_prefix} attributes: #{attributes.inspect}" if respond_to?(:logger)
    PuppetConfiguration.load.update_attributes(self.attributes, puppet_configuration_prefix).save
  end

end

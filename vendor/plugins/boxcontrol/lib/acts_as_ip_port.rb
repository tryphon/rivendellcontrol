module ActsAsIpPort

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def acts_as_ip_port(*names)
      options = names.extract_options!
      
      options = { :allow_blank => false }.update(options)

      minimum_value, message = 
        if options[:user_port]
          [ 1024, :not_a_user_port ]
        else
          [ 0, :not_a_valid_port ]
        end

      names.each do |name|
        attr_reader name

        define_method("#{name}=") do |value|
          value = value.blank? ? nil : value.to_i
          instance_variable_set "@#{name}", value
        end

        validates_numericality_of name, :only_integer => true, :greater_than => minimum_value, :less_than => 65536, :message => message, :allow_blank => options[:allow_blank]
      end
    end

  end

end

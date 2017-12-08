module CsvFileManager
  module InstanceProperties
    attr_accessor :props

    def my_properties(*args)
      @props ||= []
      @props.concat([:id], args, %i(created_at updated_at))

      instance_eval { attr_accessor(:id, *args, :created_at, :updated_at) }
    end

    def self.included(base)
      base.extend self
    end

    def initialize(**params)
      self.class.props.each do |key|
        value = params.key?(key) ? params[key] : nil

        instance_variable_set("@#{key}", value)
      end
    end
  end
end

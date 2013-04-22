require 'active_support/core_ext'
require 'yaml'

require 'miniconfig/version'

module Miniconfig
  def self.load(*filenames)
    data = {}
    filenames.each do |filename|
      data.deep_merge! YAML.load(File.read(filename))
    end
    Config.new(data)
  end

  class Config
    def initialize(data = {})
      build self, data
    end

    private

    def build(object, hash)
      if hash.is_a? Hash
        hash.each do |k, v|
          value = v.is_a?(Hash) ? Config.new(v) : v

          define_singleton_method(k.to_sym) { value }
          instance_variable_set :"@#{k}", value
        end
      else
        hash
      end
    end
  end
end

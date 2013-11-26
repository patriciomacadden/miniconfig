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
      @data = data
      build
    end

    def each
      if block_given?
        @data.each {|k, v| yield k, v}
      else
        @data.to_enum
      end
    end

    private

    def build
      @data.each do |k, v|
        @data[k] = Config.new(v) if v.is_a?(Hash)

        define_singleton_method(k.to_sym) { @data[k] }
      end
    end
  end
end

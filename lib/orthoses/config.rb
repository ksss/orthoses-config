# frozen_string_literal: true

require "orthoses"
require_relative "config/version"

module Orthoses
  class Config
    def initialize(loader)
      @loader = loader
    end

    def call
      @loader.call.tap do |store|
        const_name = ::Config.const_name
        store["Object"] << "#{const_name}: (::Config::Options & ::Config::_Options_Root)"
        settings = ::Object.const_get(const_name)
        create_interface(store, settings, "Root")
      end
    end

    private

    def create_interface(store, settings, name)
      ret_name = "Config::_Options_#{name}"
      options = store[ret_name]
      settings.each do |key, value|
        options << "def #{key}: () -> #{type(store, name, key, value)}"
      end
      "(::Config::Options & ::#{ret_name})"
    end

    def type(store, option_name, key, value)
      case value
      when String
        "String"
      when Integer
        "Integer"
      when Float
        "Float"
      when true, false
        "bool"
      when Array
        "Array[untyped]"
      when ::Config::Options
        create_interface(store, value, "#{option_name}_#{key}")
      when nil
        "nil"
      else
        "untyped"
      end
    end
  end
end

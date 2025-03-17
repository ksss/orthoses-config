# frozen_string_literal: true

require "test_helper"

module ConfigTest
  def test_config(t)
    store = Orthoses::Config.new(
      Orthoses::Store.new(lambda {
        path = File.expand_path("../../test/settings.yml", __dir__)
        ::Config.load_and_set_settings(path)
      }),
      except_keys: ["ignore"]
    ).call

    actual = store["Object"].to_rbs
    expect = <<~RBS
      class Object < ::BasicObject
        Settings: ::Config::Options & ::Config::_Options_Root
      end
    RBS
    unless expect == actual
      t.error("expect=\n```rbs\n#{expect}```\n, but got \n```rbs\n#{actual}```\n")
    end

    actual = store["Config::_Options_Root"].to_rbs
    expect = <<~RBS
      interface Config::_Options_Root
        def str: () -> String

        def int: () -> Integer

        def float: () -> Float

        def nulls: () -> nil

        def bool: () -> bool

        def hash: () -> (::Config::Options & ::Config::_Options_Root_hash)

        def array: () -> Array[untyped]
      end
    RBS
    unless expect == actual
      t.error("expect=\n```rbs\n#{expect}```\n, but got \n```rbs\n#{actual}```\n")
    end

    actual = store["Config::_Options_Root_hash"].to_rbs
    expect = <<~RBS
      interface Config::_Options_Root_hash
        def foo: () -> String

        def bar: () -> (::Config::Options & ::Config::_Options_Root_hash_bar)
      end
    RBS
    unless expect == actual
      t.error("expect=\n```rbs\n#{expect}```\n, but got \n```rbs\n#{actual}```\n")
    end

    actual = store["Config::_Options_Root_hash_bar"].to_rbs
    expect = <<~RBS
      interface Config::_Options_Root_hash_bar
        def baz: () -> String
      end
    RBS
    unless expect == actual
      t.error("expect=\n```rbs\n#{expect}```\n, but got \n```rbs\n#{actual}```\n")
    end
  end
end

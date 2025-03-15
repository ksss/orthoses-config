# frozen_string_literal: true

require "rgot/cli"
require "config"
require "orthoses/config"

unless $PROGRAM_NAME.end_with?("/rgot")
  at_exit do
    exit Rgot::Cli.new(["-v", "lib"]).run
  end
end

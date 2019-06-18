require_relative '../config/environment'
require_relative '../lib/cli_runner.rb'


def main
    runner = Runner.new
    runner.run()
end

# main
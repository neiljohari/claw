require 'claw/version'

module Claw
  class Error < StandardError; end

  class CLI
    def test
      puts 'hello'
    end
  end
end

require_relative './test_helper'

require 'play'
require_relative 'file_parser_test'

class TestPlay < Minitest::Test

  def test_run_returns_processed_commads_output
    assert_equal "1 3 N\n5 1 E", MarsRovers::Play.run(FIXTURE_EXAMPLE_PATH)
  end

end

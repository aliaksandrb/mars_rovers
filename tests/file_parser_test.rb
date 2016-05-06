require_relative './test_helper'

require 'mars_rovers/file_parser'

FIXTURE_EXAMPLE_PATH = 'tests/fixtures/input.txt'

class TestFileParser < Minitest::Test

  def test_unxistent_input_file_raises_error
    assert_raises(MarsRovers::Error) do
      MarsRovers::FileParser.parse!('abc.txt')
    end
  end

  def test_load_config_into_data
    data = MarsRovers::FileParser.parse!(FIXTURE_EXAMPLE_PATH)

    assert_equal 5, data[:planet].x
    assert_equal 5, data[:planet].y
    assert_equal 1, data[:rovers].first[:obj].x
    assert_equal 2, data[:rovers].first[:obj].y
    assert_equal 'N', data[:rovers].first[:obj].orientation
    assert_equal 'LMLMLMLMM', data[:rovers].first[:commands]

    assert_equal 3, data[:rovers].last[:obj].x
    assert_equal 3, data[:rovers].last[:obj].y
    assert_equal 'E', data[:rovers].last[:obj].orientation
    assert_equal 'MMRMMRMRRM', data[:rovers].last[:commands]
  end

end

require_relative './test_helper'

require 'mars_rovers/mars_plateu'

class TestMarsPlateu < Minitest::Test
  def test_should_be_initialized_with_coordinates
    assert_raises(MarsRovers::Error) { MarsRovers::MarsPlateu.new }
  end

  def test_initialized_with_coordinates
    mars = MarsRovers::MarsPlateu.new(1, 5)
    assert_equal 1, mars.x
    assert_equal 5, mars.y
  end

  def test_shoul_be_initialized_with_postitive_numbers
    assert_raises(MarsRovers::Error) { MarsRovers::MarsPlateu.new('xfdsf', 5) }
  end

end

require_relative './test_helper'

require 'mars_rovers/mars_plateu'
require 'mars_rovers/rover'

class TestRover < Minitest::Test
  def setup
    @rover = MarsRovers::Rover.new(5, 5, 'N')
  end

  def test_should_be_initialized_with_position_and_orientation
    assert_raises(MarsRovers::Error) { MarsRovers::Rover.new }
  end

  def test_initialized_with_position_and_orientation
    rover = MarsRovers::Rover.new(1, 5, 'S')
    assert_equal 1, rover.x
    assert_equal 5, rover.y
    assert_equal 'S', rover.orientation
  end

  def test_should_be_initialized_with_postitive_numbers
    assert_raises(MarsRovers::Error) { MarsRovers::Rover.new('xfdsf', 5, 'N') }
  end

  def test_rover_orientation_restricted_by_defined_list
    assert_raises(MarsRovers::Error) { MarsRovers::Rover.new(1, 5, 'X') }
  end

  def test_could_change_position_and_orientation
    rover = MarsRovers::Rover.new(1, 5, 'S')
    rover.x = 2
    rover.y = 1
    rover.orientation = 'N'

    assert_equal 2, rover.x
    assert_equal 1, rover.y
    assert_equal 'N', rover.orientation
  end

  def test_rover_can_move_left
    @rover.move('L')
    assert_equal 'W', @rover.orientation

    @rover.move('L')
    assert_equal 'S', @rover.orientation

    @rover.move('L')
    assert_equal 'E', @rover.orientation

    @rover.move('L')
    assert_equal 'N', @rover.orientation
  end

  def test_rover_can_move_right
    @rover.move('R')
    assert_equal 'E', @rover.orientation

    @rover.move('R')
    assert_equal 'S', @rover.orientation

    @rover.move('R')
    assert_equal 'W', @rover.orientation

    @rover.move('R')
    assert_equal 'N', @rover.orientation
  end

  def test_rover_can_dance_on_mars
    @rover.move('R')
    @rover.move('L')
    @rover.move('R')
    @rover.move('R')
    assert_equal 'S', @rover.orientation
  end

  def test_rover_can_move_straight_alone
    @rover.move('M')
    assert_equal 5, @rover.x
    assert_equal 6, @rover.y

    @rover.move('R')
    @rover.move('M')
    assert_equal 6, @rover.x
    assert_equal 6, @rover.y

    @rover.move('R')
    @rover.move('M')
    assert_equal 6, @rover.x
    assert_equal 5, @rover.y

    @rover.move('R')
    @rover.move('M')
    assert_equal 5, @rover.x
    assert_equal 5, @rover.y

    @rover.move('R')
    @rover.move('M')
    assert_equal 5, @rover.x
    assert_equal 6, @rover.y
  end

  def test_unknown_commands_skipped
    assert_nil @rover.move('X')
    assert_equal 5, @rover.x
    assert_equal 5, @rover.y
    assert_equal 'N', @rover.orientation
  end

  def test_rover_could_be_sent_to_mars
    assert_nil @rover.planet

    @rover.send_to_planet(_mars)
    assert_equal _mars, @rover.planet
  end

  def test_rover_could_not_be_sent_back_or_another_planet
    home = MarsRovers::MarsPlateu.new(9, 9)
    @rover.send_to_planet(_mars)

    assert_raises(MarsRovers::Error) { @rover.send_to_planet(home) }
  end

  def test_could_not_land_on_small_planet
    assert_raises(MarsRovers::Error) do
      @rover.send_to_planet(MarsRovers::MarsPlateu.new(1, 1))
    end

    assert_raises(MarsRovers::Error) do
      @rover.send_to_planet(MarsRovers::MarsPlateu.new(10, 4))
    end

    assert_raises(MarsRovers::Error) do
      @rover.send_to_planet(MarsRovers::MarsPlateu.new(4, 10))
    end

    same_size_planet = MarsRovers::MarsPlateu.new(5, 5)
    assert_equal same_size_planet, @rover.send_to_planet(same_size_planet)
  end

  def test_rover_moves_on_planet_limited_by_its_shape
    @rover.send_to_planet(_mars)

    @rover.move('M')
    assert_equal 5, @rover.x
    assert_equal 6, @rover.y

    @rover.move('M')
    assert_equal 5, @rover.x
    assert_equal 6, @rover.y

    @rover.move('M')
    assert_equal 5, @rover.x
    assert_equal 6, @rover.y

    @rover.move('R')
    @rover.move('M')
    assert_equal 6, @rover.x
    assert_equal 6, @rover.y

    @rover.move('M')
    assert_equal 6, @rover.x
    assert_equal 6, @rover.y

    @rover.move('R')
    5.times { @rover.move('M') }
    assert_equal 6, @rover.x
    assert_equal 1, @rover.y

    @rover.move('M')
    assert_equal 6, @rover.x
    assert_equal 0, @rover.y

    @rover.move('M')
    assert_equal 6, @rover.x
    assert_equal 0, @rover.y

    @rover.move('R')
    5.times { @rover.move('M') }
    assert_equal 1, @rover.x
    assert_equal 0, @rover.y

    @rover.move('M')
    assert_equal 0, @rover.x
    assert_equal 0, @rover.y

    @rover.move('M')
    assert_equal 0, @rover.x
    assert_equal 0, @rover.y
  end

  private

  def _mars
    @mars ||= MarsRovers::MarsPlateu.new(6, 6)
  end
end

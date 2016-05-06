require 'mars_rovers/error'
require 'mars_rovers/utils'

module MarsRovers

  class Rover
    include Utils

    COMPASS = %w(N E S W)
    MOVES = {
      N: :_step_up,
      E: :_step_right,
      S: :_step_down,
      W: :_step_left,
    }

    attr_accessor :x, :y, :orientation
    attr_reader :planet

    def initialize(x = nil, y = nil, orientation = nil)
      unless x && y && orientation
        raise Error.new(
          'Should be initialized with x and y position coordinates '\
          'and orientation!'
        )
      end

      @x, @y = _validate_coordinates!(x, y)
      @orientation = _validate_orientation!(orientation)
    end

    def move(command)
      case command
      when 'L'
        _turn(side: -1)
      when 'R'
        _turn(side: 1)
      when 'M'
        _move_in_direction
      else
        puts 'Mars rover does not expect such command. Skipped!'
      end
    end

    def send_to_planet(area)
      if !planet && _is_possible_to_land?(area)
        @planet = area
      else
        raise Error.new('Unfortunately NASA can not bring back the rover..')
      end
    end

    private

    def _validate_orientation!(orientation)
      raise Error.new(
        "Rover orientation should be one from the list: #{COMPASS}"
      ) unless COMPASS.include?(orientation)

      orientation
    end

    def _is_possible_to_land?(area)
      self.x <= area.x && self.y <= area.y
    end

    def _turn(side:)
      current_index = COMPASS.index(orientation)

      self.orientation = if current_index == COMPASS.size - 1 && side > 0
        COMPASS[side % COMPASS.size - 1]
      else
        COMPASS[current_index + side]
      end

      orientation
    end

    def _move_in_direction
      self.send(MOVES[orientation.to_sym])
    end

    def _could_move_on_planet?(coordinate:, step:)
      if planet
        rover_coordinate = self.send(coordinate) + step

        return rover_coordinate >= 0 &&
               planet.send(coordinate) - rover_coordinate >= 0
      end

      true
    end

    def _step_up
      self.y += 1 if _could_move_on_planet?(coordinate: :y, step: 1)
    end

    def _step_right
      self.x += 1 if _could_move_on_planet?(coordinate: :x, step: 1)
    end

    def _step_down
      self.y -= 1 if _could_move_on_planet?(coordinate: :y, step: -1)
    end

    def _step_left
      self.x -= 1 if _could_move_on_planet?(coordinate: :x, step: -1)
    end

  end

end

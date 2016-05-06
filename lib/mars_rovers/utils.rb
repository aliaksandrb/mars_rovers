require 'mars_rovers/error'

module MarsRovers
  module Utils
    private

    def _validate_coordinates!(x, y)
      [Integer(x), Integer(y)]
    rescue ArgumentError
      raise Error.new('Coordinates expected to be a valid integers!')
    end
  end
end

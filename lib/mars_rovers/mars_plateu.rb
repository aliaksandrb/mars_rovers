require 'mars_rovers/error'
require 'mars_rovers/utils'

module MarsRovers

  class MarsPlateu
    include Utils

    attr_reader :x, :y

    def initialize(x = nil, y = nil)
      unless x && y
        raise Error.new('Should be initialized with x and y coordinates!')
      end

      @x, @y = _validate_coordinates!(x, y)
    end

  end

end


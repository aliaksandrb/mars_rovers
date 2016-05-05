require 'error'
require 'mars_plateu'
require 'rover'

module Mars

  module FileParser

    class << self

      def parse!(path)
        if File.exists?(path)
          result = {
            rovers: [],
          }

          begin
            File.open(path) do |f|
              result[:planet] = MarsPlateu.new(*f.readline.strip.split)

              f.each_slice(2) do |rover_config|
                rover = _rover_by_config(rover_config)
                result[:rovers] << rover if rover
              end
            end

            result
          rescue Errno::EACCES => e
            puts 'Input file could not be readed!'
            raise e
          end
        else
          raise Error.new('Input file could not be found!')
        end
      end

      private def _rover_by_config(rover_config)
        if rover_config.size == 2 && !rover_config.include?("\n")
          {
            obj: Rover.new(*rover_config.first.strip.split),
            commands: rover_config.last.strip
          }
        end
      end

    end

  end

end

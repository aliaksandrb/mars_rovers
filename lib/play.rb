require 'file_parser'

module Mars
  VERSION = '0.0.1'

  module Play
    def self.run(file_path)
      parsed_data = Mars::FileParser.parse!(file_path)
      rovers = parsed_data[:rovers]
      planet = parsed_data[:planet]
      result = ''

      rovers.each do |rover_hash|
        rover = rover_hash[:obj]
        rover.send_to_planet(planet)

        rover_hash[:commands].split('').each do |command|
          rover.move(command)
        end

        result << "#{rover.x} #{rover.y} #{rover.orientation}\n"
      end

      puts result
      result.strip
    end

  end
end

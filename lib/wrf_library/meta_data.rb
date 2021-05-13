require "time"
require "ruby_utils/meta_data"
require "wrf_library/entity"

module WrfLibrary

  # Childclass that represents the meta data of a wrf station output
  class MetaData < RubyUtils::MetaData

    # @return [GridPoint] the corresponding grid point
    attr_reader :grid_data
    
    # @return [Station] the information abount the station
    attr_reader :station

    # @return [Time] the start date and time of the data series
    attr_reader :start_date

    # initialization
    # @param [Array] header_line the head line of a data set holding the 
    # relevant meta information
    # @param [Time] start_date the start date and time of the data set
    def initialize(header_line, start_date)
      @start_date = start_date
      super(header_line)
    end

    private

    # method which parses the required meta information from the 
    # head line    
    # @param [Array] header_line the head line of a data set holding the 
    # relevant meta information
    def parse_header(header_line)
      entries = delete_special_chars(header_line)
      # switch entries for geo coordinates since latitude comes before longitude
      geo_coordinate = Entity::Coordinate.new(entries[6].to_f, entries[5].to_f)
      @grid_data = Entity::GridPoint.new(entries[8].to_f, entries[9].to_f,
                                 entries[12].to_f, entries[11].to_f)
      # special case for multi word locations
      station_name = entries[0].sub("_", " ")
      @station = Entity::Station.new(station_name, entries[3], entries[13].to_f,
                                     geo_coordinate)
      nil
    end

    # helper method to clear entries of certain special character
    # @param [Array] entries the array with the header information
    # @return [Array] the adjusted entry
    def delete_special_chars(entries)
      entries.each { |entry|
        entry.delete("(),")
      }
      return entries
    end

  end

end

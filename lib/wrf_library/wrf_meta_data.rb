# @Author: Benjamin Held
# @Date:   2017-11-05 20:10:11
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-25 21:19:53

require 'time'
require 'ruby_utils/meta_data'
require 'wrf_library/entity'

module WrfLibrary

# Childclass that represents the meta data of a wrf station output
class WrfMetaData < RubyUtils::MetaData

  # @return [GridPoint] the corresponding grid point
  attr_reader :grid_data
  
  # @return [Station] the information abount the station
  attr_reader :station
  # @return [Time] the start date and time of the data series
  attr_reader :start_date

  # initialization
  # @param [String] header_line the head line of a data set holding the 
  # relevant meta information
  # @param [Time] start_date the start date and time of the data set
  def initialize(header_line, start_date)
    @start_date = start_date
    super(header_line)
  end

  private

  # method which parses the required meta information from the 
  # head line    
  # @param [String] header_line the head line of a data set holding the 
  # relevant meta information
  def parse_header(header_line)
    entries = delete_special_chars(header_line)
    geo_coordinate = Entity::Coordinate.new(entries[5].to_f, entries[6].to_f)
    @grid_data = Entity::GridPoint.new(entries[8].to_f, entries[9].to_f,
                               entries[11].to_f, entries[12].to_f)
    @station = Entity::Station.new(entries[0], entries[3], entries[13].to_f,
                           geo_coordinate)
    nil
  end

  # helper method to clear entries of certain special character
  # @param [String] the given entry
  # @return [String] the adjusted entry
  def delete_special_chars(entries)
    entries.each { |entry|
      entry.delete("(),")
    }
    return entries
  end

end

end

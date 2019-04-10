# @Author: Benjamin Held
# @Date:   2018-01-27 16:45:47
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-04-10 20:41:20

# This module holds the classes that describe the meta information for the
# different data sets.
module MetaData

  # Abstract base class that holds the common information that all types of
  # data sets share.
  class BaseMetaData

    require_relative '../entity/entity'
    require_relative '../../ruby_utils/string/string'

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
      parse_header(header_line)
    end

    private

    # abstract method which parses the required meta information from the 
    # head line    
    # @abstract subclasses need to implement this method
    # @param [String] header_line the head line of a data set holding the 
    # relevant meta information
    def parse_header(header_line)
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
           "to implement the method: print_meta_information " \
           "from its base class".red
    end

  end

end  

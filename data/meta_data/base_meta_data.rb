# @Author: Benjamin Held
# @Date:   2018-01-27 16:45:47
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-04-12 22:15:39

# This module holds the classes that describe the meta information for the
# different data sets.
module MetaData

  # Abstract base class that holds the common information that all types of
  # data sets share.
  class BaseMetaData < MetaData

    require_relative '../entity/entity'
    
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

  end
  
end  

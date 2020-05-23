# @Author: Benjamin Held
# @Date:   2019-07-06 16:37:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-23 21:14:01

require "ruby_utils/string"
require "ruby_utils/parameter_converter"

module WrfLibrary

  # This class provides logic and methods to identify and manage results for 
  # different timestamps
  class TimeConverter

    # method to determine the offset between the actual hour and the next midnight
    # @param [String] start_hour the starting hour in string representation
    # @return [Integer] the offset to the next midnight
    # @raise [ArgumentError] if the hour is not valid
    def self.get_offset_modelrun(start_hour)
      hour = RubyUtils::ParameterConverter.convert_int_parameter(start_hour)
      if (hour == 0)
        return 0 
      elsif (hour < 0 || hour > 24)
        raise ArgumentError, "Error: #{hour} in not valid"
      end  
      24 - hour  
    end

  end

end

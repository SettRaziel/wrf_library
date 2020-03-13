# @Author: Benjamin Held
# @Date:   2019-07-06 16:37:12
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-13 14:47:53

require 'ruby_utils/string'

module WrfLibrary

  # This class provides logic and methods to identify and manage results for 
  # different timestamps
  class TimeConverter

    def self.get_date_to_timestamp(timestamp)
      date = check_timestamp(timestamp, 0, 6)
      date = check_timestamp(timestamp, 6, 12) if (date == nil)
      date = check_timestamp(timestamp, 12, 18) if (date == nil)
      date = check_timestamp(timestamp, 18, 0) if (date == nil)
      return date
    end

    def self.get_date_to_input(input)
      initialize_key_words if (@key_word == nil)
      date = @key_word[input]
      return date if (date != nil)
      raise ArgumentError, "Given input could not be matched.".red
    end

    private

    attr :key_word

    def self.initialize_key_words
      @key_word = Hash.new()
      determine_keyword_date('--00',0)
      determine_keyword_date('--06',6)
      determine_keyword_date('--12',12)
      determine_keyword_date('--18',18)
    end

    def self.determine_keyword_date(key, hour)
      current = Time.now()
      timestamp = Time.new(current.year, current.month, current.day, hour)
      if (current.hour >= hour)
        @key_word[key] = timestamp
      else
        @key_word[key] = timestamp - 86400
      end
      nil
    end

    def self.check_timestamp(timestamp, lower_stamp, upper_stamp)
      if (timestamp >= data_timestamp)
        return data_timestamp
      end
      nil
    end

  end

end

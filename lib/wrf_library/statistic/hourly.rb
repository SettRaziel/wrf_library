module WrfLibrary

  module Statistic

    module Hourly

      def self.generate_hourly_means(measurand, handler)
        timestamps = handler.retrieve_data_set(:forecast_time)
        data = handler.retrieve_data_set(measurand)
        results = Array.new()
        value_count = 0
        mean = 0.0

        previous_timestamp = timestamps[0].hour
        data.zip(timestamps).each { |value, timestamp|
          # detect new hour, when the leading number increases by one
          if (timestamp.hour != previous_timestamp)
            results << mean / value_count
            mean = 0.0
            value_count = 0
          end

          previous_timestamp = timestamp.hour
          mean += value
          value_count += 1
        }
        results
      end  

    end

  end

end

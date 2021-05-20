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
        results << mean / value_count
        results
      end

      # method to sum up the rain data into hourly rain sums
      # for that calculate the difference from the rain value at the start and end
      # of the currently checked hour
      def self.calculate_hourly_rainsum(handler)
        timestamps = handler.retrieve_data_set(:forecast_time)
        rain_data = add_rain_data(handler)
        results = Array.new()


        # when using an offset, start with the current value as delta
        previous_hour = rain_data[0]
        previous_timestamp = timestamps[0].hour
        rain_data.zip(timestamps).each { |rain, timestamp|
          # detect new hour, when the leading number increases by one
          if (timestamp.hour != previous_timestamp)
            results << rain - previous_hour
            previous_hour = rain
          end
          previous_timestamp = timestamp.hour
        }

        # workaround to satisfy the current requirement for daily values
        results << rain_data[rain_data.size-1] - previous_hour
      end

      # method to add the rain data from the two different sources
      # @param [WrfHandler] handler the wrf handler with the data
      private_class_method def self.add_rain_data(handler)
        cumulus_rain = handler.retrieve_data_set(:cumulus_rainfall)
        explicit_rain = handler.retrieve_data_set(:explicit_rainfall)
        rain_data = Array.new()
        cumulus_rain.zip(explicit_rain).each { |c, e| 
          rain_data << c + e
        }
        rain_data
      end
   
    end

  end

end

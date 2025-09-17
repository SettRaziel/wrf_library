require "wrf_library/statistic/hourly"
require "wrf_library/measurand"
require "wrf_library/data"

module WrfLibrary

  module Statistic

    # method to generate timespan mean values for the given measurand
    # @param [Symbol] measurand the given measurand
    # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
    # @param [Symbol] timespan the time attribute for which the sum should be calculated
    # @return [Array] the array with the timespan means rounded to 3 significant digits
    def self.calculate_timespan_means(measurand, handler, timespan)
      timestamps = handler.retrieve_data_set(:forecast_time)
      data = handler.retrieve_data_set(measurand)
      calculate_means_for_timespan(timestamps, timespan, data)
    end

    # method to calculate the windspeed means for the given timespan
    # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
    # @param [Symbol] timespan the time attribute for which the sum should be calculated
    # @return [Array] the array with the timespan means rounded to 3 significant digits
    def self.calculate_timespan_windspeed_means(handler, timespan)
      timestamps = handler.retrieve_data_set(:forecast_time)
      u_component = handler.retrieve_data_set(:u_wind)
      v_component = handler.retrieve_data_set(:v_wind)
      wind_speed = Measurand::Wind.calculate_windspeed(u_component, v_component)

      calculate_means_for_timespan(timestamps, timespan, wind_speed)
    end

    # method to calculate the wind direction means for the given timespan
    # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
    # @param [Symbol] timespan the time attribute for which the sum should be calculated
    # @return [Array] the array with the timespan means rounded to 3 significant digits
    def self.calculate_timespan_winddirection_means(handler, timespan)
      timestamps = handler.retrieve_data_set(:forecast_time)
      u_component = handler.retrieve_data_set(:u_wind)
      v_component = handler.retrieve_data_set(:v_wind)
      wind_direction = Measurand::Wind.calculate_winddirection(u_component, v_component)

      calculate_direction_means(timestamps, timespan, wind_direction)
    end

    # method to sum up the rain data into the given timespan rain sums
    # for that calculate the difference from the rain value at the start and end
    # of the currently checked hour
    # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
    # @param [Symbol] timespan the time attribute for which the sum should be calculated
    # @return [Array] the array with the timespan sums rounded to 3 significant digits
    def self.calculate_timespan_rainsum(handler, timespan)
      timestamps = handler.retrieve_data_set(:forecast_time)
      rain_data = add_rain_data(handler)
      results = Array.new()

      # when using an offset, start with the current value as delta
      previous_timespan = rain_data[0]
      # use send to get the desired value to the time object, e.g. for hourly value get the current hour value
      previous_timestamp = timestamps[0].send(timespan)
      rain_data.zip(timestamps).each { |rain, timestamp|
        # detect new time interval value, when the leading number increases by one
        if (timestamp.send(timespan) != previous_timestamp)
          results << (rain - previous_timespan).round(3)
          previous_timespan = rain
        end
        previous_timestamp = timestamp.send(timespan)
      }

      # workaround to satisfy the current requirement for daily values
      results << (rain_data[rain_data.size-1] - previous_timespan).round(3)
    end

    # method to add the rain data from the two different sources
    # @param [WrfHandler] handler the wrf handler with the data
    # @return [Array] the cumulated rain data of cumulus and explizit rainsums
    private_class_method def self.add_rain_data(handler)
      cumulus_rain = handler.retrieve_data_set(:cumulus_rainfall)
      explicit_rain = handler.retrieve_data_set(:explicit_rainfall)
      rain_data = Array.new()
      cumulus_rain.zip(explicit_rain).each { |c, e| 
        rain_data << c + e
      }
      rain_data
    end

    # method to create mean values for the given data and timespan
    # @param [Array] timestamps the array with the timestamps of the data
    # @param [Symbol] timespan the time attribute for which the sum should be calculated
    # @param [Array] data the data values
    # @return [Array] the hourly means of the input data
    def self.calculate_means_for_timespan(timestamps, timespan, data)
      results = Array.new()
      value_count = 0
      mean = 0.0

      # use send to get the desired value to the time object, e.g. for hourly value get the current hour value
      previous_timestamp = timestamps[0].send(timespan)
      data.zip(timestamps).each { |value, timestamp|
        # detect new time interval value, when the leading number increases by one
        if (timestamp.send(timespan) != previous_timestamp)
          results << (mean / value_count).round(3)
          mean = 0.0
          value_count = 0
        end

        previous_timestamp = timestamp.send(timespan)
        mean += value
        value_count += 1
      }
      results << (mean / value_count).round(3)
    end


    # method to determine the prevalent wind direction for the given data per timespan
    # @param [Array] timestamps the array with the timestamps of the data
    # @param [Symbol] timespan the time attribute for which the sum should be calculated
    # @param [Array] data the data values
    # @return [Array] the hourly means of the input data
    private_class_method def self.calculate_direction_means(timestamps, timespan, data)
      results = Array.new()
      hourly_subset = Array.new()

      # use send to get the desired value to the time object, e.g. for hourly value get the current hour value
      previous_timestamp = timestamps[0].send(timespan)
      data.zip(timestamps).each { |value, timestamp|
        # detect new time interval value, when the leading number increases by one
        if (timestamp.send(timespan) != previous_timestamp)
          directions = WindDirectionRepository.new(hourly_subset)
          results << directions.determine_prevalent_direction
          previous_timestamp = timestamp.send(timespan)
          hourly_subset.clear
        end

        hourly_subset << value
      }
      directions = WindDirectionRepository.new(hourly_subset)
      results << directions.determine_prevalent_direction
    end
  end
 
end

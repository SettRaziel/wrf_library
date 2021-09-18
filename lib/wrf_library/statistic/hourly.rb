module WrfLibrary

  # module to aggregate statistic based logic applied to wrf data
  module Statistic

    # module to generate hourly statistic values for wrf based measurands
    module Hourly

      # method to generate hourly mean values for the given measurand
      # @param [Symbol] measurand the given measurand
      # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
      # @return [Array] the array with the hourly means
      def self.calculate_hourly_means(measurand, handler)
        WrfLibrary::Statistic.calculate_timespan_means(measurand, handler, :hour)
      end

      # method to generate hourly mean values for the wind speed
      # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
      # @return [Array] the array with the hourly values
      def self.calculate_hourly_windspeed_means(handler)
        WrfLibrary::Statistic.calculate_timespan_windspeed_means(handler, :hour)
      end

      # method to sum up the rain data into hourly rain sums
      # for that calculate the difference from the rain value at the start and end
      # of the currently checked hour
      # @param [WrfLibrary::Wrf::Handler] handler the wrf handler with the data
      # @return [Array] the array with the hourly values
      def self.calculate_hourly_rainsum(handler)
        WrfLibrary::Statistic.calculate_timespan_rainsum(handler, :hour)
      end
  
    end

  end

end

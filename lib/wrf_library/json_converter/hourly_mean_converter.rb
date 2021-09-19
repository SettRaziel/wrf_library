require "wrf_library/wrf"

module WrfLibrary

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class HourlyMeanJsonConverter < HourlyJsonConverter

      private

      # implementation of the abstract parent method to create valid json objects
      # for the stored data values
      # @return [Hash] the key-value hashes for the json output 
      def generate_data_values
        if (@measurand == :wind_speed)
          {"wind_speed" => 
            WrfLibrary::Statistic::Hourly.calculate_hourly_windspeed_means(@handler) }
        else
          {@measurand.to_s.tr("@", "") => 
            WrfLibrary::Statistic::Hourly.calculate_hourly_means(@measurand, @handler) }
        end
      end

    end

  end

end

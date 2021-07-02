require "wrf_library/wrf"

module WrfLibrary

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class HourlyJsonConverter < WrfStationJsonConverter

      # initialization
      # @param [Symbol] measurand the used measurand
      # @param [Wrf::Handler] handler the data handler with the wrf data
      def initialize(measurand, handler)
        super(handler.data_repository)
        @handler = handler
        @measurand = measurand
      end

      private

      # @return [Wrf::Handler] the wrf handler with the data
      attr_reader :handler
      # @return [Symbol] the used measurand
      attr_reader :measurand

      # implementation of the abstract parent method to create valid json objects
      # for the stored data values
      # @return [Hash] the key-value hashes for the json output 
      def generate_data_values
        {@measurand.to_s.tr("@", "") => 
          WrfLibrary::Statistic::Hourly.calculate_hourly_rainsum(handler) }
      end

    end

  end

end

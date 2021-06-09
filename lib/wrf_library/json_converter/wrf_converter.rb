require "wrf_library/wrf"

module WrfLibrary

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class WrfJsonConverter < WrfStationJsonConverter

      private

      # implementation of the abstract parent method to create valid json objects
      # for the stored data values
      # @return [Hash] the key-value hashes for the json output 
      def generate_data_values
        data_array = Array.new()
        @data.repository.each { |dataset|
          data_array << create_data_hash(dataset)
        }
        return data_array
      end

      # method to create a valid json hash for a given data entry as 
      # pair {instance_variable, value}
      # @param [WrfEntry] dataset the given data entry
      # @return [Hash] the key-value hashes for the json output     
      def create_data_hash(dataset)
        data_entries = Hash.new()
        dataset.instance_variables.map{ |ivar| 
          data_entries[ivar.to_s.tr("@", "")] = dataset.instance_variable_get(ivar)
        }
        return data_entries
      end

    end

  end

end

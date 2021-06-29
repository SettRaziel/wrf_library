require "spec_helper"
require "wrf_library/data/location_mapping"

describe WrfLibrary::Location::LocationMapping do

  describe ".get_file_to_location" do
    context "given a csv file with location" do
      it "read the file and returns the correct location to the key" do
        locations = WrfLibrary::Location::LocationMapping.new(File.join(__dir__,"../files/locations.csv"))
        expect(locations.get_file_to_location("Ber")).to eq("Berlin")
      end
    end
  end

  describe ".get_file_to_location" do
    context "given a csv file with location" do
      it "read the file and returns nil for an unknown key" do
        locations = WrfLibrary::Location::LocationMapping.new(File.join(__dir__,"../files/locations.csv"))
        expect(locations.get_file_to_location("Hil")).to be_nil
      end
    end
  end

  describe ".new" do
    context "given a csv file with invalid location pairs" do
      # prepare temporary output file
      filename = "../files/locations_fail.csv"
      output = File.new(File.join(__dir__, filename), "w")
      output.puts("wrong;csv;file")
      output.close
      
      it "try to read the file and throw an error" do
        expect { 
          WrfLibrary::Location::LocationMapping.new(File.join(__dir__, filename))
        }.to raise_error(ArgumentError)
      end

      # clean up file
      after(:all) do
        File.delete(File.join(__dir__,filename))
      end
    end
  end

end

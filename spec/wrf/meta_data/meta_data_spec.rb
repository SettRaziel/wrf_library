require "spec_helper"
require "time"

describe WrfLibrary::MetaData do

  describe ".new" do
    context "given an array with the header information" do
      it "create meta data and have the correct station name" do
        header = [ "Berlin", "1", "5", "Ber", "(", "52.490,", "13.360)", "(", "222,", "185)",
                   "(", "52.469,",  "13.371)", "44.2" "meters" ]
        meta_data = WrfLibrary::MetaData.new(header, Time.now())
        expect(meta_data.station.name).to eq("Berlin")
      end
    end
  end

  describe ".new" do
    context "given an array with the header information" do
      it "create meta data and have the correct station name" do
        header = [ "Los_Realejos", "1", "3", "Lor", "(", "28.370,", "-16.580)", "(", "152,", "157)",
                   "(", "28.379,", "-16.590)", "442.3", "meters" ]
        meta_data = WrfLibrary::MetaData.new(header, Time.now())
        expect(meta_data.station.name).to eq("Los Realejos")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have meta data in the handler" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        expect(handler.data_repository.meta_data).to be_truthy
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct grid point data" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        geo_point = handler.data_repository.meta_data.grid_data.grid_point
        expect(geo_point.x).to eq(222)
        expect(geo_point.y).to eq(185)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct grid coordinate data" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        grid_coordinate = handler.data_repository.meta_data.grid_data.grid_coordinates
        expect(grid_coordinate.x).to eq(13.371)
        expect(grid_coordinate.y).to eq(52.469)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station name" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        station = handler.data_repository.meta_data.station
        expect(station.name).to eq("Berlin")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station description" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        station = handler.data_repository.meta_data.station
        expect(station.descriptor).to eq("Ber")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station elevation" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        station = handler.data_repository.meta_data.station
        expect(station.elevation).to eq(44.2)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station elevation" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.now())
        station_coordinate = handler.data_repository.meta_data.station.coordinate
        expect(station_coordinate.x).to eq(13.360)        
        expect(station_coordinate.y).to eq(52.490)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct timestamp" do
        timestamp = Time.parse("2019-06-29 12:00 UTC")
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, timestamp)
        start_time = handler.data_repository.meta_data.start_date
        expect(start_time).to eq(timestamp)        
      end
    end
  end

end

#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-01 13:59:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-09-20 20:35:31

require "spec_helper"

describe WrfLibrary::WrfMetaData do

  describe ".new" do
    context "given an array with the header information" do
      it "create meta data and have the correct station name" do
        header = [ "Berlin", "1", "5", "Ber", "(", "52.490,", "13.360)", "(", "222,", "185)",
                   "(", "52.469,",  "13.371)", "44.2" "meters" ]
        meta_data = WrfLibrary::WrfMetaData.new(header, Date.new(2020, 03, 29))
        expect(meta_data.station.name).to eq("Berlin")
      end
    end
  end

  describe ".new" do
    context "given an array with the header information" do
      it "create meta data and have the correct station name" do
        header = [ "Los_Realejos", "1", "3", "Lor", "(", "28.370,", "-16.580)", "(", "152,", "157)",
                   "(", "28.379,", "-16.590)", "442.3", "meters" ]
        meta_data = WrfLibrary::WrfMetaData.new(header, Date.new(2019, 11, 29))
        expect(meta_data.station.name).to eq("Los Realejos")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have meta data in the handler" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        expect(handler.data_repository.meta_data).to be_truthy
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct grid point data" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        geo_point = handler.data_repository.meta_data.grid_data.grid_point
        expect(geo_point.x).to eq(222)
        expect(geo_point.y).to eq(185)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct grid coordinate data" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        grid_coordinate = handler.data_repository.meta_data.grid_data.grid_coordinates
        expect(grid_coordinate.x).to eq(13.371)
        expect(grid_coordinate.y).to eq(52.469)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station name" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station = handler.data_repository.meta_data.station
        expect(station.name).to eq("Berlin")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station description" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station = handler.data_repository.meta_data.station
        expect(station.descriptor).to eq("Ber")
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station elevation" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station = handler.data_repository.meta_data.station
        expect(station.elevation).to eq(44.2)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station elevation" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station_coordinate = handler.data_repository.meta_data.station.coordinate
        expect(station_coordinate.x).to eq(13.360)        
        expect(station_coordinate.y).to eq(52.490)
      end
    end
  end

end

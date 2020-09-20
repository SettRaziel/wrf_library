#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-01 11:07:37
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-09-20 20:35:46

require "spec_helper"

describe WrfLibrary::Wrf::WrfHandler do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have data in the repository" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        expect(handler.data_repository.repository).to be_truthy
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have 994 entries in the repository" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        expect(handler.data_repository.repository.size).to eq(994)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and check for correct temperature values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        temperature_values = handler.retrieve_data_set(:air_temperature)
        expect(temperature_values[0].round(3)).to eq(273.677)
        expect(temperature_values[4].round(3)).to eq(273.302)
      end
    end
  end

    describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and try to get not available data" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 03, 29))
        expect {
          handler.retrieve_data_set(:something)
        }.to raise_error(ArgumentError)
      end
    end
  end


  describe ".new" do
    context "given a meteogram output file, the date and a duration" do
      it "read the file and have 477 entries in the repository" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 03, 29), 12.0)
        expect(handler.data_repository.repository.size).to eq(477)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file, the date, a duration and an offset" do
      it "read the file and have 507 entries in the repository starting with the correct temperature and time" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 03, 29), 12.0, 6.0)
        expect(handler.data_repository.repository.size).to eq(507)
        temperature_values = handler.retrieve_data_set(:air_temperature)
        forecast_time = handler.retrieve_data_set(:forecast_time)
        expect(temperature_values[0].round(3)).to eq(271.113)
        expect(temperature_values.last.round(3)).to eq(280.919)
        expect(forecast_time[0].round(3)).to eq(0.0)
        expect(forecast_time.last.round(3)).to eq(12.000)
      end
    end
  end


end

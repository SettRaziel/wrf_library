module WrfLibrary

  # This module holds wrf specific data classes and handlers
  module Wrf

    # Simple data class to represent an entry of the wrf station output
    class Entry

      # @return [Time] timestamp of the forecast data
      attr_accessor :forecast_time   
      # @return [Float] 2 m Temperature (K)
      attr_accessor :air_temperature
      # @return [Float] 2 m vapor mixing ratio (kg/kg)
      attr_accessor :mixing_ratio
      # @return [Float] 10 m U wind (earth-relative)
      attr_accessor :u_wind
      # @return [Float] 10 m V wind (earth-relative)
      attr_accessor :v_wind
      # @return [Float] surface pressure (Pa)
      attr_accessor :pressure
      # @return [Float] downward longwave radiation flux at the ground 
      #                 (W/m^2, downward is positive)
      attr_accessor :longwave
      # @return [Float] net shortwave radiation flux at the ground 
      #                 (W/m^2, downward is positive)
      attr_accessor :shortwave         
      # @return [Float] surface sensible heat flux (W/m^2, upward is positive)
      attr_accessor :sensible_heat     
      # @return [Float] surface latent heat flux (W/m^2, upward is positive)
      attr_accessor :latent_heat       
      # @return [Float] skin temperature (K)
      attr_accessor :skin_temperature  
      # @return [Float] top soil layer temperature (K)
      attr_accessor :soil_temperature  
      # @return [Float] rainfall from a cumulus scheme (mm) 
      attr_accessor :cumulus_rainfall  
      # @return [Float] rainfall from an explicit scheme (mm)
      attr_accessor :explicit_rainfall 
      # @return [Float] total column-integrated water vapor and cloud variables
      attr_accessor :water_vapor

    end

  end

end

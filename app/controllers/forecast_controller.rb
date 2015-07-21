require 'open-uri'


class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]


    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
  
    url = "https://api.forecast.io/forecast/8c8c63dbae4ec1265ca59794f492b284/#{@lat},#{@lng}"
    @result=open(url).read
    @parsed_result=JSON.parse(@result) 
    @current_temperature = @parsed_result["currently"]["temperature"]
    @current_summary = @parsed_result["currently"]["summary"]
    @summary_of_next_sixty_minutes = @parsed_result["hourly"]["data"][0]["summary"]
    @summary_of_next_several_hours = @parsed_result["hourly"]["summary"]
    @summary_of_next_several_days = @parsed_result["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end

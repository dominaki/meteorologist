require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
    

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"
    @result= open(url).read
    @parsed_result=JSON.parse(@result) 
    @longitude = @parsed_result["results"][0]["geometry"]["location"]["lng"]
    @latitude = @parsed_result["results"][0]["geometry"]["location"]["lat"]
    
    url = "https://api.forecast.io/forecast/8c8c63dbae4ec1265ca59794f492b284/#{@latitude},#{@longitude}"
    @result=open(url).read
    @parsed_result=JSON.parse(@result)
    @current_temperature = @parsed_result["currently"]["temperature"]
    @current_summary = @parsed_result["currently"]["summary"]
    @summary_of_next_sixty_minutes = @parsed_result["hourly"]["data"][0]["summary"]
    @summary_of_next_several_hours = @parsed_result["hourly"]["summary"]
    @summary_of_next_several_days = @parsed_result["daily"]["summary"]

    render("street_to_weather.html.erb")
    
  end
end

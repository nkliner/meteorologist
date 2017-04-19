require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    stwurl = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address.gsub(" ","+")+""

    stw_data = open(stwurl).read

    parsed_stw = JSON.parse(stw_data)

    lat2 = parsed_stw["results"][0]["geometry"]["location"]["lat"]

    lng2 = parsed_stw["results"][0]["geometry"]["location"]["lng"]

    ctwurl2 = "https://api.darksky.net/forecast/5f440b8b8910403205fdb5f0d57b1f16/#{lat2},#{lng2}"

    ctw_data2 = open(ctwurl2).read

    parsed_ctw2 = JSON.parse(ctw_data2)

    @current_temperature = parsed_ctw2["currently"]["temperature"]

    @current_summary = parsed_ctw2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_ctw2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_ctw2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_ctw2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end

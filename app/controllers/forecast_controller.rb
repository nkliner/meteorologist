require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    ctwurl = "https://api.darksky.net/forecast/5f440b8b8910403205fdb5f0d57b1f16/#{@lat},#{@lng}"

    ctw_data = open(ctwurl).read

    parsed_ctw = JSON.parse(ctw_data)

    @current_temperature = parsed_ctw["currently"]["temperature"]

    @current_summary = parsed_ctw["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_ctw["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_ctw["hourly"]["summary"]

    @summary_of_next_several_days = parsed_ctw["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end

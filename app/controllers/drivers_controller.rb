require 'will_paginate/array'

class DriversController < ApplicationController

  def show
    driver = Driver.find_by(id: params[:id]) 

    if !driver
      render status: 404, json: {
        message: 'Driver not found',
        hint: 'Run rails db:reset then try localhost:3000/drivers/1'
      }
    else
      driver_rides = driver.get_all_rides_scores
      sorted_rides = sort_by_score(driver_rides).paginate(page: params[:page], per_page: params[:limit])
      render status: 200, json: {
        driver_id: driver.id,
        rides: sorted_rides
      }.to_json.camelcase
    end
  end

  def sort_by_score(rides)
    rides.sort_by{|ride| ride[:ride_score]}.reverse
  end
end
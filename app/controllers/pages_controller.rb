class PagesController < ApplicationController
  # GET request for / which is our homepage
  # Instance variables for home signup button queries
  def home
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
  end
  
  # GET request for /about page
  def about
  end
end
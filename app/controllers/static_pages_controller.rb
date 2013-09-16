class StaticPagesController < ApplicationController
  def about
  end

  def contact_us
  end

  def copyright
  end

  def how_it_works
  end

  def team
  end
  
  def welcome
    render layout: "welcome_layout" 
  end

  def terms
  end
end
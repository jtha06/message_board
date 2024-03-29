require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "CollegeZen")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "CollegeZen")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "CollegeZen")
  end

  it "should have a FAQ page at '/faq'" do
    get '/faq'
    response.should have_selector('title', :content => "CollegeZen")
  end
  
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "CollegeZen")
  end  
end
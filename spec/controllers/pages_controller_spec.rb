require 'spec_helper'

describe PagesController do
  render_views

  # Testing home page
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
	
	# Testing the title
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                        :content => "CollegeZen")
    end	
  end

  # Testing FAQ page  
  describe "GET 'FAQ'" do
    it "returns http success" do
      get 'FAQ'
      response.should be_success
    end
	
    it "should have the right title" do
      get 'FAQ'
      response.should have_selector("title",
                        :content => "CollegeZen")
    end		
  end

  # Testing about page
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
	
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content => "CollegeZen")
    end	 
  end
  
  # Testing contact page
  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
	
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content => "CollegeZen")
    end	 
  end
end

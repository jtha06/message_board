# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  firstname       :string(255)
#  lastname        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  zenpoints       :integer
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :firstname => "Foo",
			  :lastname => "Bar",
			  :email => "user@example.com",
			  :password => "asdfgh",
			  :password_confirmation => "asdfgh",
			  :zenpoints => 0
			}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a firstname" do
    no_name_user = User.new(@attr.merge(:firstname => ""))
    no_name_user.should_not be_valid
  end  
  
  it "should require a lastname" do
    no_name_user = User.new(@attr.merge(:lastname => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject firstnames that are too long" do
    long_firstname = "a" * 21
    long_firstname_user = User.new(@attr.merge(:firstname => long_firstname))
    long_firstname_user.should_not be_valid
  end

  it "should reject lastnames that are too long" do
    long_lastname = "a" * 21
    long_lastname_user = User.new(@attr.merge(:lastname => long_lastname))
    long_lastname_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 3
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 21
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
end

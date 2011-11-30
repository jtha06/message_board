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

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :firstname, :lastname
  has_secure_password
  
  validates_presence_of :email, :firstname, :lastname
  validates_length_of :firstname, :lastname, :maximum => 20
  validates_length_of :password, :maximum => 20
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_presence_of :password, :on => :create
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_uniqueness_of :email, :allow_blank => true, :case_sensitive => false
  
  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  include Forem::DefaultPermissions
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :nom, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nom,  :presence => true,
            :length   => { :maximum => 50 }
            :uniqueness => { :case_sensitive => false }

  validates :email, :presence => true,
            :format   => { :with => email_regex }
            :uniqueness => { :case_sensitive => false }

  validates :password, :presence     => true,
            :confirmation => true,
            :length       => { :within => 6..40 }
end
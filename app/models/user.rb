class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods

  has_secure_password

  has_many :record_users
  has_many :records, through: :record_users
  has_many :artists, through: :records
  has_many :labels, through: :records

end

class User < ActiveRecord::Base
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
  
  has_secure_password

end

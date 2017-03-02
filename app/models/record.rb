class Record < ActiveRecord::Base

extend Slugify::ClassMethods
include Slugify::InstanceMethods

has_many :record_users
has_many :users, through: :record_users
belongs_to :label
belongs_to :artist

end

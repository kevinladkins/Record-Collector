class Record < ActiveRecord::Base

  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
  include Upload


  has_many :record_users
  has_many :users, through: :record_users
  belongs_to :label
  belongs_to :artist

  def cover_upload=(upload)
    file = upload[:tempfile]
    self.upload(file)
    self.cover="https://s3.us-east-2.amazonaws.com/#{ENV['AWS_S3_BUCKET_NAME']}/#{File.basename(file)}"
  end

  def manual_upload=(upload)
    File.open(File.join(APP_ROOT, "public", "uploads", upload[:filename]), "w") do |f|
      f.write(upload[:tempfile].read)
    end
    self.cover = "/uploads/#{upload[:filename]}"
  end




end

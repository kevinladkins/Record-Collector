module Upload

  def upload(file)
    s3 = Aws::S3::Resource.new(region: 'us-east-2')
    bucket_name = ENV['AWS_S3_BUCKET_NAME']
    bucket = s3.bucket(bucket_name)
    name = File.basename(file)
    obj = s3.bucket(bucket_name).object(name)
    obj.upload_file(file)
  end

end

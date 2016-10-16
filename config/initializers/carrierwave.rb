CarrierWave.configure do |config|
  config.asset_host      = ENV['CARRIERWAVE_ASSET_HOST'] || ''
  config.fog_directory   = ENV['S3_BUCKET_NAME']
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                ENV['AWS_REGION']
  }
end

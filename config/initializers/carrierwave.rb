CarrierWave.configure do |config|
  config.asset_host = ENV['CARRIERWAVE_ASSET_HOST'] || ''
end

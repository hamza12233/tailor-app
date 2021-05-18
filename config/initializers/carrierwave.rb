CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.s3[:aws_access_key],
    aws_secret_access_key: Rails.application.secrets.s3[:aws_secret_access_key],
    region: Rails.application.secrets.s3[:aws_region]
  }
  config.fog_directory  = Rails.application.secrets.s3[:aws_bucket]
  config.fog_public     = false
  config.fog_attributes = { 'Cache-Control' =>  "max-age=#{365.days.to_i}" }
end

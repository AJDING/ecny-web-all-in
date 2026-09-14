source "https://rubygems.org"
ruby "3.3.6"

gem "rails", "~> 7.2.2"
gem "pg", "~> 1.5"
gem "puma", ">= 6.4"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 3.3"
gem "tailwindcss-ruby", "~> 3.4"
gem "devise", "~> 4.9"
gem "image_processing", "~> 1.13"   # Active Storage thumbnails (needs libvips or ImageMagick)
gem "aws-sdk-s3", require: false      # Cloudflare R2 (S3-compatible) in production
gem "bootsnap", require: false
gem "dotenv-rails", groups: [:development, :test]
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
end

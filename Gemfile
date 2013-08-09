source 'http://rubygems.org'

gem 'sinatra'
#gem 'thin'

# (now part of sinatra contrib:)
# gem 'sinatra-reloader' # if development? #doc: https://github.com/sinatra/sinatra-contrib/

gem 'sinatra-contrib'
gem 'maruku' #or 'kramdown'

gem 'pdfkit' # also requires "gem install wkhtmltopdf-binary"  | doc: github.com/jdpace/PDFKit
gem 'slim'
gem 'haml'
gem 'sass'
gem 'wkhtmltopdf'


group :development, :test  do
  gem 'cucumber', require: false
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rspec-fire'
end
group :development do
  gem 'guard-cucumber'
  gem 'guard-rspec'
end
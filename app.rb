require 'sinatra'
require 'rack/cache'
require './image_resizer'
# require 'pry'

set :bind, '0.0.0.0'

use Rack::Cache, :metastore => 'file:/root/tmp/cache/meta', :entitystore => 'file:/root/tmp/cache/body'

set :public_folder, File.dirname(__FILE__) + '/static'

set :image_widths, -> { Dir.glob('raw/**').map {|dir| dir.gsub(/raw\//, '').to_i }.sort }

get '/' do
  erb :index
end

get '/:width' do
  target_width = params[:width].to_i
  path = Dir.glob("raw/*.{jpg,png}").shuffle[0]
  image = ImageResizer.new(path)
  image.width= target_width
  # TODO: turn me back on
  # cache_control :public, :max_age => 5
  content_type("image/#{image.image_format}")
  image.to_s
end

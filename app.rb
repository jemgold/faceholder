require 'sinatra/base'
require 'rack/cache'
require './image_resizer'
# require 'pry'


class SpaceHolder < Sinatra::Base
  use Rack::Cache, :metastore => 'file:tmp/cache/meta', :entitystore => 'file:tmp/cache/body'

  set :public_folder, File.dirname(__FILE__) + '/static'

  configure do
    set :images, Dir.glob('raw/top100/*.jpg')
  end

  get '/' do
    erb :index
  end

  get '/p' do
    redirect '/p/100'
  end

  get '/p/:width' do
    width = params[:width].to_i
    path = settings.images.shuffle[0]
    image = ImageResizer.new(path)
    image.width= width
    cache_control :public, :max_age => 5
    content_type("image/#{image.image_format}")
    image.to_s
  end
end

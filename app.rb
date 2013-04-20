require 'sinatra/base'
require './image_resizer'
require 'pry'

class SpaceHolder < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/p' do
    redirect '/p/100'
  end

  get '/p/:width' do
    width = params[:width].to_i
    path = Dir.glob('raw/top100/*.jpg').shuffle[0]
    image = ImageResizer.new(path)
    image.width= width
    content_type("image/#{image.image_format}")
    image.to_s
  end
end

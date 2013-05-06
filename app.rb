require 'sinatra/base'
require 'rack/cache'
require './image_resizer'
# require 'pry'


class Faceholder < Sinatra::Base
  use Rack::Cache, :metastore => 'file:tmp/cache/meta', :entitystore => 'file:tmp/cache/body'

  set :public_folder, File.dirname(__FILE__) + '/static'

  set :image_widths, -> { Dir.glob('raw/**').map {|dir| dir.gsub(/raw\//, '').to_i }.sort }

  get '/' do
    erb :index
  end

  get '/:width' do
    target_width = params[:width].to_i
    base_width = find_a_width(target_width)
    path = Dir.glob("raw/#{base_width}/*.{jpg,png}").shuffle[0]
    image = ImageResizer.new(path)
    image.width= target_width
    # TODO: turn me back on
    # cache_control :public, :max_age => 5
    content_type("image/#{image.image_format}")
    image.to_s
  end

  def find_a_width(width)
    arr = settings.image_widths
    arr.each do |w|
      if width <= w
        break w
      else
        return arr.last
      end
    end
  end

end

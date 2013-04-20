require 'mini_magick'

class ImageResizer
  attr_accessor :width
  def initialize(path)
    @image = MiniMagick::Image.open(path)
  end

  def image_format
    @image[:format]
  end

  def to_s
    process!
    @image.to_blob
  end

  private

  def process!
    # grayscale the image
    @image.colorspace 'gray' if @grayscale

    # bail out if there are no dimensions to play with
    return if @height.nil? && @width.nil?

    # keep default dimensions if not given new ones
    @width = @image[:width] if @width.nil? || @width <= 0
    @height = @image[:height] if @height.nil? || @height <= 0

    # ignore the aspect ratio
    if !!@stretch
      @image.resize "#{@width}x#{@height}!"

    # add padding
    elsif !!@padding
      @image.combine_options do |opts|
        opts.extent "#{@width}x#{@height}"
        opts.gravity 'center'
        opts.background 'white'
      end

    # resize with aspect ratio
    else
      @image.resize "#{@width}x#{@height}>"
    end

  end
end
module Streamcast
  class SizeError < StandardError; end
  class RecordingStreamError < StandardError; end

  class HTML
    sizes = {
      :small      => {width:  560, height: 315},
      :medium     => {width:  640, height: 360},
      :large      => {width:  853, height: 480},
      :fullscreen => {width: 1280, height: 720}
    }
    def self.embed(size, recording_stream)
      raise SizeError unless sizes.keys.include?(size)
      raise RecordingStreamError unless recording_stream.class.ancestors.include?(IO)
      "<iframe width=\"#{sizes[size][:width]}\" height=\"#{sizes[size][:height]}\" src=\"//www.youtube.com/embed/S5P63qGTm_g?rel=0\" frameborder=\"0\" allowfullscreen></iframe>"
    end
  end
end

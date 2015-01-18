#################################################################################
# The MIT License (MIT)                                                         #
#                                                                               #
# Copyright (c) 2014, Reinhard Bramel 'dafoxia' <dafoxia@mail.austria.com>      #
#                                                                               #
# Permission is hereby granted, free of charge, to any person obtaining a copy  #
# of this software and associated documentation files (the "Software"), to deal #
# in the Software without restriction, including without limitation the rights  #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     #
# copies of the Software, and to permit persons to whom the Software is         #
# furnished to do so, subject to the following conditions:                      #
#                                                                               #
# The above copyright notice and this permission notice shall be included in    #
# all copies or substantial portions of the Software.                           #
#                                                                               #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     #
# THE SOFTWARE.                                                                 #
#################################################################################

module Celt
  class Decoder
    attr_reader :sample_rate, :frame_size, :channels,
                :prediction_request, :vbr_rate

    def initialize(sample_rate, frame_size, channels)
      @sample_rate = sample_rate
      @frame_size = frame_size
      @channels = channels
      @mode = Celt.celt_mode_create sample_rate, frame_size, nil
      @decoder = Celt.celt_decoder_create @mode, channels, nil
      puts "decoder initialized"
    end

    def destroy
      Celt.celt_decoder_destroy @decoder
      Celt.celt_mode_destroy @mode
    end

    def bitstream_version
      bv = FFI::MemoryPointer.new :int32
      Celt.celt_mode_info @mode, Celt::Constants::CELT_GET_BITSTREAM_VERSION, bv
      bv.read_int32
    end

    def decode( data )
        len = data.size
        packet = FFI::MemoryPointer.new :char, len + 1
        packet.put_string 0,data
        decoded = FFI::MemoryPointer.new :short, @frame_size 
        error = Celt.celt_decode @decoder, packet, len, decoded
        return decoded.read_string_length frame_size * 2 if error == 0
    end
  end
end

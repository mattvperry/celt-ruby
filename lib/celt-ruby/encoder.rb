module Celt
  class Encoder
    attr_reader :sample_rate, :frame_size, :channels,
                :prediction_request, :vbr_rate

    def initialize(sample_rate, frame_size, channels)
      @sample_rate = sample_rate
      @frame_size = frame_size
      @channels = channels

      @mode = Celt.celt_mode_create sample_rate, frame_size, nil
      @encoder = Celt.celt_encoder_create_custom @mode, channels, nil
    end

    def destroy
      Celt.celt_encoder_destroy @encoder
      Celt.celt_mode_destroy @mode
    end

    def bitstream_version
      bv = FFI::MemoryPointer.new :int32
      Celt.celt_mode_info @mode, Celt::Constants::CELT_GET_BITSTREAM_VERSION, bv
      bv.read_int32
    end

    def prediction_request=(value)
      @prediction_request = value
      v_ptr = FFI::MemoryPointer.new :int
      v_ptr.put_int 0, value
      Celt.celt_encoder_ctl @encoder, Celt::Constants::CELT_SET_PREDICTION_REQUEST, :pointer, v_ptr
    end

    def vbr_rate=(value)
      @vbr_rate = value
      v_ptr = FFI::MemoryPointer.new :int
      v_ptr.put_int 0, value
      Celt.celt_encoder_ctl @encoder, Celt::Constants::CELT_SET_VBR_REQUEST, :pointer, v_ptr
    end

    def encode(data, size)
      out = FFI::MemoryPointer.new :char, data.size + 1
      buf = FFI::MemoryPointer.new :char, data.size + 1
      buf.put_string 0, data
      len = Celt.celt_encode @encoder, buf, nil, out, size
      out.read_string_length len
    end
  end
end

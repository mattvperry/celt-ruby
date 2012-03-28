require 'ffi'
require 'celt-ruby/version'
require 'celt-ruby/encoder'

module Celt
  extend FFI::Library

  ffi_lib 'celt0'

  module Constants
    CELT_OK                         = 0
    CELT_BAD_ARG                    = -1
    CELT_INVALID_MODE               = -2
    CELT_INTERNAL_ERROR             = -3
    CELT_CORRUPTED_DATA             = -4
    CELT_UNIMPLEMENTED              = -5
    CELT_INVALID_STATE              = -6
    CELT_ALLOC_FAIL                 = -7
    CELT_GET_MODE_REQUEST           = 1
    CELT_SET_COMPLEXITY_REQUEST     = 2
    CELT_SET_PREDICTION_REQUEST     = 4
    CELT_SET_BITRATE_REQUEST        = 6
    CELT_RESET_STATE_REQUEST        = 8
    CELT_SET_VBR_CONSTRAINT_REQUEST = 10
    CELT_SET_VBR_REQUEST            = 12
    CELT_SET_INPUT_CLIPPING_REQUEST = 14
    CELT_SET_START_BAND_REQUEST     = 10000
    CELT_SET_END_BAND_REQUEST       = 10001
    CELT_SET_CHANNEL_REQUEST        = 10002
    CELT_GET_LOOKAHEAD              = 1001
    CELT_GET_SAMPLE_RATE            = 1003
    CELT_GET_BITSTREAM_VERSION      = 2000
  end

  attach_function :celt_mode_create, [:int32, :int, :pointer], :pointer
  attach_function :celt_mode_destroy, [:pointer], :void
  attach_function :celt_mode_info, [:pointer, :int, :pointer], :int

  attach_function :celt_encoder_get_size, [:int], :int
  attach_function :celt_encoder_get_size_custom, [:pointer, :int], :int
  attach_function :celt_encoder_create, [:int, :int, :pointer], :pointer
  attach_function :celt_encoder_create_custom, [:pointer, :int, :pointer], :pointer
  attach_function :celt_encoder_init, [:pointer, :int, :int, :pointer], :pointer
  attach_function :celt_encoder_init_custom, [:pointer, :pointer, :int, :pointer], :pointer
  attach_function :celt_encoder_destroy, [:pointer], :void
  attach_function :celt_encode_float, [:pointer, :pointer, :int, :pointer, :int], :int
  attach_function :celt_encode, [:pointer, :pointer, :int, :pointer, :int], :int
  attach_function :celt_encoder_ctl, [:pointer, :int, :varargs], :int

  attach_function :celt_decoder_get_size, [:int], :int
  attach_function :celt_decoder_get_size_custom, [:pointer, :int], :int
  attach_function :celt_decoder_create, [:int, :int, :pointer], :pointer
  attach_function :celt_decoder_create_custom, [:pointer, :int, :pointer], :pointer
  attach_function :celt_decoder_init, [:pointer, :int, :int, :pointer], :pointer
  attach_function :celt_decoder_init_custom, [:pointer, :pointer, :int, :pointer], :pointer
  attach_function :celt_decoder_destroy, [:pointer], :void
  attach_function :celt_decode_float, [:pointer, :pointer, :int, :pointer, :int], :int
  attach_function :celt_decode, [:pointer, :pointer, :int, :pointer, :int], :int
  attach_function :celt_decoder_ctl, [:pointer, :int, :varargs], :int

  attach_function :celt_strerror, [:int], :pointer
end

module Passbook
  class KeyReader < Struct.new(:key_type)
    KeyTypeError = Class.new ArgumentError

    def read(key)
      case key_type
      when :file   then key && File.read(key)
      when :string then key
      else raise KeyTypeError.new('key_type must be a "file" or "string".')
      end
    end
  end
end

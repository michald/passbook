module Passbook
  class Config
    attr_reader :certificate, :key, :wwdc, :password

    def initialize(params = {})
      key_type   = params.fetch(:key_type, Passbook.key_type || :file).to_sym
      key_reader = KeyReader.new key_type

      @certificate = key_reader.read params.fetch(:certificate, Passbook.p12_certificate)
      @key         = key_reader.read params.fetch(:key, params.empty? ? Passbook.p12_key : nil)
      @wwdc        = key_reader.read params.fetch(:wwdc_cert, Passbook.wwdc_cert)
      @password    = params.fetch :password, Passbook.p12_password
    end
  end
end


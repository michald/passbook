module Passbook
  class KeyChain
    attr_reader :certificate, :key, :wwdc

    def initialize(params = {})
      @config = Config.new params
      compute_keys!
    end

    private

    def compute_keys!
      @wwdc = OpenSSL::X509::Certificate.new @config.wwdc

      if @config.key
        @key         = OpenSSL::PKey::RSA.new @config.key, @config.password
        @certificate = OpenSSL::X509::Certificate.new @config.certificate
      else
        p12 = OpenSSL::PKCS12.new @config.certificate, @config.password
        @key, @certificate = p12.key, p12.certificate
      end
    end
  end
end

module Passbook
  class Signer
    PKCS7_FLAG = OpenSSL::PKCS7::BINARY | OpenSSL::PKCS7::DETACHED

    def initialize(params = {})
      @key_chain = KeyChain.new params
    end

    def sign(data)
      Decoder.base64 sign_data(data)
    end

    private

    def sign_data(data)
      data = OpenSSL::PKCS7.sign @key_chain.certificate, @key_chain.key,
                                 data.to_s, [@key_chain.wwdc], PKCS7_FLAG
      OpenSSL::PKCS7.write_smime data
    end
  end
end

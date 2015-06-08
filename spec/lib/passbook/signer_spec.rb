require 'spec_helper'

describe 'Signer' do
  context 'sign data' do
    before do
      Passbook::KeyReader.any_instance.stub :read
      Passbook::KeyChain.any_instance.stub :compute_keys!

      key_chain = Passbook::KeyChain.new
      key_chain.stub certificate: 'certificate', key: 'key', wwdc: 'wwdc'

      Passbook::KeyChain.should_receive(:new).
        with({}).ordered.
        and_return key_chain
      OpenSSL::PKCS7.should_receive(:sign).
        with('certificate', 'key', 'data', ['wwdc'], 192).ordered.
        and_return 'signed_data'
      OpenSSL::PKCS7.should_receive(:write_smime).
        with('signed_data').ordered.
        and_return "filename=\"smime.p7s\"\n\nsmime_signed_data\n\n------"
      Passbook::Decoder.should_receive(:base64).
        with("filename=\"smime.p7s\"\n\nsmime_signed_data\n\n------").ordered.
        and_return "decoded_smime_signed_data"
    end

    it 'returns signed base64 decoded data' do
      expect(Passbook::Signer.new.sign 'data').to eq(
        'decoded_smime_signed_data'
      )
    end
  end
end

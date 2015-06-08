require 'openssl'
require 'base64'
require 'digest/sha1'

require 'zip'
require 'active_support/core_ext/module/attribute_accessors'
require 'grocer/passbook_notification'

require 'passbook/version'
require 'passbook/decoder'
require 'passbook/key_reader'
require 'passbook/config'
require 'passbook/key_chain'
require 'passbook/signer'
require 'passbook/pkpass'
require 'passbook/push_notification'
require 'rack/passbook_rack'

module Passbook
  mattr_accessor :p12_certificate, :p12_password, :wwdc_cert, :p12_key,
                 :key_type, :notification_cert, :notification_gateway

  def self.configure
    yield self
  end
end

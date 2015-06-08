module Passbook
  class Decoder
    STR_DEBUT = "filename=\"smime.p7s\"\n\n"
    STR_END   = "\n\n------"

    def self.base64(data)
      Base64.decode64(data[
        data.index(STR_DEBUT) + STR_DEBUT.length .. data.index(STR_END) - 1
      ])
    end
  end
end

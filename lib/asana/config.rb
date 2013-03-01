module Asana
  module Config

    API_VERSION      = '1.0'
    API_ENDPOINT     = "https://app.asana.com/api/#{API_VERSION}/"
    USER_AGENT       = "rbright/asana gem #{Asana::VERSION}"

    attr_accessor :api_key

    def configure
      yield self
      self
    end

  end
end

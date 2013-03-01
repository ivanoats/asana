module Asana
  class Resource
    class << self

      def connection
        @connection ||= Faraday.new(Config::API_ENDPOINT) do |c|
          c.basic_auth(Asana.api_key, '')
          c.adapter :net_http
          c.headers[:user_agent] = Config::USER_AGENT
        end
      end

      def get(path, params = {})
        data = request(:get, path, params).fetch('data')
        if data.is_a? Array
          get_collection(data)
        elsif data.is_a? Hash
          get_member(data)
        end
      end

      def post(path, data)
        self.new(request(:post, path, data.to_query))
      end

      def put(path, data)
        self.new(request(:put, path, data.to_query))
      end

      def delete(path)
        request(:delete, path, data.to_query)
      end

      private

        def request(method, path, data)
          res = connection.send(method, path, data)
          if res.success?
            JSON.load(res.body)
          end
        end

        def get_collection(data)
          [].tap do |a|
            data.each do |o|
              a << self.new(o)
            end
          end
        end

        def get_member(data)
          self.new(data)
        end

    end

    def initialize(h = {})
      h.each_pair do |k, v|
        self.class.module_eval { attr_accessor k.to_sym }
        self.send(:"#{k}=", v)
      end
    end

    def path
      "#{self.class::COLLECTION}/#{id}"
    end

    def get(path, params = {})
      self.class.get(path, params)
    end

    def post(data)
      self.class.post(path, data)
    end

    def put(data)
      self.class.put(path, Hash.new(self).merge(data))
    end

    def delete
      self.class.delete(path)
    end

  end
end


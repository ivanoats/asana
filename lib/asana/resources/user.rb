module Asana
  class User < Resource

    COLLECTION = "users"

    class << self

      def all
        get("#{COLLECTION}")
      end

      def find(id)
        get("#{COLLECTION}/#{id}")
      end

      def me
        get("#{COLLECTION}/me")
      end

    end

  end
end

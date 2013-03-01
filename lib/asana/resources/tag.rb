module Asana
  class Tag < Resource

    COLLECTION = "tags"

    class << self

      def find(id)
        get("#{COLLECTION}/#{id}")
      end

    end

  end
end

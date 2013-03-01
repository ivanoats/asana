module Asana
  class Story < Resource

    COLLECTION = "stories"

    class << self

      def find(id)
        get("#{COLLECTION}/#{id}")
      end

    end

  end
end

module Asana
  class Project < Resource

    COLLECTION = "projects"

    class << self

      def all
        get("#{COLLECTION}")
      end

      def find(id)
        get("#{COLLECTION}/#{id}")
      end

      def create(data)
        post("#{COLLECTION}/#{id}", data)
      end

      def update(id, data)
        put("#{COLLECTION}/#{id}", data)
      end

      def tasks(id, params = {})
        Asana::Task.get("#{COLLECTION}/#{id}/#{Task::COLLECTION}", {
          :assignee => 'me'
        }.merge(params))
      end

      def stories(id)
        Asana::Story.get("#{COLLECTION}/#{id}/#{Story::COLLECTION}")
      end

      def create_story(id, data)
        Asana::Story.post("#{COLLECTION}/#{id}/#{Story::COLLECTION}", data)
      end

    end

    def update(data)
      put(data)
    end

    def tasks(params = {})
      Asana::Task.get("#{path}/#{Task::COLLECTION}", {
        :assignee => 'me'
      }.merge(params))
    end

    def stories
      Asana::Story.get("#{path}/#{Story::COLLECTION}")
    end

    def create_story(data)
      Asana::Story.post("#{path}/#{Story::COLLECTION}", data)
    end

  end
end

module Asana
  class Task < Resource

    COLLECTION = "tasks"
    SUBTASK_COLLECTION = "subtasks"

    class << self

      def find(id)
        get("#{COLLECTION}/#{id}")
      end

      def update(id, data)
        put("#{COLLECTION}/#{id}", data)
      end

      def projects(id)
        Project.get("#{COLLECTION}/#{id}/#{Project::COLLECTION}")
      end

      def stories(id)
        Story.get("#{COLLECTION}/#{id}/#{Story::COLLECTION}")
      end

      def create_story(id, data)
        Asana::Story.post("#{COLLECTION}/#{id}/#{Story::COLLECTION}", data)
      end

      def tags(id)
        Tag.get("#{COLLECTION}/#{id}/#{Tag::COLLECTION}")
      end

      def subtasks(id)
        get("#{COLLECTION}/#{id}/#{SUBTASK_COLLECTION}")
      end

      def create_subtask(id, data)
        post("#{COLLECTION}/#{id}/#{SUBTASK_COLLECTION}", {
          :assignee => 'me'
        }.merge(data))
      end

    end

    def update(data)
      put("#{path}", data)
    end

    def projects
      Project.get("#{path}/#{Project::COLLECTION}")
    end

    def stories
      Story.get("#{path}/#{Story::COLLECTION}")
    end

    def create_story(data)
      Asana::Story.post("#{path}/#{Story::COLLECTION}", data)
    end

    def tags
      Tag.get("#{path}/#{Tag::COLLECTION}")
    end

    def subtasks
      get("#{path}/#{SUBTASK_COLLECTION}")
    end

    def create_subtask(data)
      post({
        :assignee => 'me'
      }.merge(data), "#{path}/#{SUBTASK_COLLECTION}")
    end

  end
end

module Asana
  class Workspace < Resource

    COLLECTION = "workspaces"

    class << self

      def all
        get("#{COLLECTION}")
      end

      def find(id)
        get("#{COLLECTION}/#{id}")
      end

      def update(id, data)
        put("#{COLLECTION}/#{id}", data)
      end

      def projects(id)
        Asana::Project.get("#{COLLECTION}/#{id}/#{Project::COLLECTION}")
      end

      def create_project(id, data)
        Asana::Project.post("#{COLLECTION}/#{id}/#{Project::COLLECTION}", data)
      end

      def tasks(id, params = {})
        Asana::Task.get("#{COLLECTION}/#{id}/#{Task::COLLECTION}", {
          :assignee => 'me'
        }.merge(params))
      end

      def create_task(id, data)
        Asana::Task.post("#{COLLECTION}/#{id}/#{Task::COLLECTION}", {
          :assignee => 'me'
        }.merge(data))
      end

      def users(id)
        Asana::User.get("#{COLLECTION}/#{id}/#{User::COLLECTION}")
      end

      def tags(id)
        Asana::Tag.get("#{COLLECTION}/#{id}/#{Tag::COLLECTION}")
      end

      def create_tag(id, data)
        Asana::Tag.post("#{COLLECTION}/#{id}/#{Tag::COLLECTION}", data)
      end

    end

    def update(data)
      put(data)
    end

    def projects
      Asana::Project.get("#{path}/#{Project::COLLECTION}")
    end

    def create_project(data)
      Asana::Project.post("#{path}/#{Project::COLLECTION}", data)
    end

    def tasks(params = {})
      Asana::Task.get("#{path}/#{Task::COLLECTION}", {
        :assignee => 'me'
      }.merge(params))
    end

    def create_task(data)
      Asana::Task.post("#{path}/#{Task::COLLECTION}", {
        :assignee => 'me'
      }.merge(data))
    end

    def users
      Asana::User.get("#{path}/#{User::COLLECTION}")
    end

    def tags
      Asana::Tag.get("#{path}/#{Tag::COLLECTION}")
    end

    def create_tag(data)
      Asana::Tag.post("#{path}/#{Tag::COLLECTION}", data)
    end

  end
end

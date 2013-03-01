require_relative '../../spec_helper'

module Asana
  describe Workspace do

    before do
      VCR.insert_cassette('workspaces', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it "should return all of the user's workspaces" do
        workspaces = Workspace.all
        workspaces.must_be_instance_of Array
        workspaces.last.must_be_instance_of Workspace
      end
    end

    describe '.find' do
      it "should return a single workspace" do
        workspace = Workspace.find(Workspace.all.first.id)
        workspace.must_be_instance_of Workspace
      end
    end

    describe '.update' do
      it "should update the given workspace with a new name" do
        workspace = Workspace.all.last
        Workspace.update(workspace.id, :name => 'foo')
        workspace = Workspace.find(workspace.id)
        workspace.name.must_equal 'foo'
      end
    end

    describe '.projects' do
      it "should return all projects for the given workspace" do
        workspace = Workspace.all.last
        projects = Workspace.projects(workspace.id)
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '.create_project' do
      it "should create a new project for the given workspace" do
        workspace = Workspace.all.last
        project = Workspace.create_project(workspace.id, :name => 'asana-test-project')
        project.must_be_instance_of Project
      end
    end

    describe '.tasks' do
      it "should return all tasks for the given workspace" do
        workspace = Workspace.all.last
        tasks = Workspace.tasks(workspace.id)
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

    describe '.create_task' do
      it "should create a new task for the given workspace" do
        workspace = Workspace.all.last
        task = Workspace.create_task(workspace.id, :name => 'asana-test-task', :assignee => 'me')
        task.must_be_instance_of Task
      end
    end

    describe '.users' do
      it "should return all users for the given workspace" do
        workspace = Workspace.all.last
        users = Workspace.users(workspace.id)
        users.must_be_instance_of Array
        users.first.must_be_instance_of User
      end
    end

    describe '.tags' do
      it "should return all tags for the given workspace" do
        workspace = Workspace.all.last
        tags = Workspace.tags(workspace.id)
        tags.must_be_instance_of Array
        tags.first.must_be_instance_of Tag
      end
    end

    describe '.create_tag' do
      it "should create a new tag for the given workspace" do
        workspace = Workspace.all.last
        task = Workspace.create_tag(workspace.id, :name => 'asana-test-tag')
        task.must_be_instance_of Tag
      end
    end

    describe '#update' do
      it "should update the given workspace with a new name" do
        workspace = Workspace.all.last
        workspace.update(:name => 'foo')
        workspace.name.must_equal 'foo'
      end
    end

    describe '#projects' do
      it "should return all projects for the given workspace" do
        workspace = Workspace.all.last
        projects = workspace.projects
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '#create_project' do
      it "should create a new project for the given workspace" do
        workspace = Workspace.all.last
        project = workspace.create_project(:name => 'asana-test-project')
        project.must_be_instance_of Project
      end
    end

    describe '#tasks' do
      it "should return all tasks for the given workspace" do
        workspace = Workspace.all.last
        tasks = workspace.tasks
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

    describe '#create_task' do
      it "should create a new task for the given workspace" do
        workspace = Workspace.all.last
        task = workspace.create_task(:name => 'asana-test-task', :assignee => 'me')
        task.must_be_instance_of Task
      end
    end

    describe '#users' do
      it "should return all users for the given workspace" do
        workspace = Workspace.all.last
        users = workspace.users
        users.must_be_instance_of Array
        users.first.must_be_instance_of User
      end
    end

    describe '#tags' do
      it "should return all tags for the given workspace" do
        workspace = Workspace.all.last
        tags = workspace.tags
        tags.must_be_instance_of Array
        tags.first.must_be_instance_of Tag
      end
    end

    describe '#create_tag' do
      it "should create a new tag for the given workspace" do
        workspace = Workspace.all.last
        task = workspace.create_tag(:name => 'asana-test-tag')
        task.must_be_instance_of Tag
      end
    end

  end
end

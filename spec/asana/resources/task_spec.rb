require_relative '../../spec_helper'

module Asana
  describe Task do

    before do
      VCR.insert_cassette('tasks', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.find' do
      it 'should return a single task' do
        task = Task.find(Workspace.all.last.tasks.first.id)
        task.must_be_instance_of Task
      end
    end

    describe '.update' do
      it "should update the given task with a new name" do
        task = Workspace.all.last.create_task(:name => 'asana-test-foo')
        Task.update(task.id, :name => 'asana-test-bar')
        task = Task.find(task.id)
        task.name.must_equal 'asana-test-bar'
      end
    end

    describe '.projects' do
      it 'should return all projects for the given task' do
        task = Project.all.first.tasks.first
        projects = Task.projects(task.id)
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '.stories' do
      it 'should return all stories for the given task' do
        task = Project.all.first.tasks.first
        stories = Task.stories(task.id)
        stories.must_be_instance_of Array
        stories.first.must_be_instance_of Story
      end
    end

    describe '.create_story' do
      it 'should create a new story for the given task' do
        task = Project.all.first.tasks.first
        story = Task.create_story(task.id, :text => 'foo')
        story.must_be_instance_of Story
      end
    end

    describe '.tags' do
      it 'should return all tags for the given task' do
        task = Project.all.last.tasks.first
        tags = Task.tags(task.id)
        tags.must_be_instance_of Array
        tags.first.must_be_instance_of Tag
      end
    end
    describe '#projects' do
      it 'should return all projects for the given task' do
        task = Project.all.first.tasks.first
        projects = task.projects
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '#stories' do
      it 'should return all stories for the given task' do
        task = Project.all.first.tasks.first
        stories = task.stories
        stories.must_be_instance_of Array
        stories.first.must_be_instance_of Story
      end
    end

    describe '#create_story' do
      it 'should create a new story for the given task' do
        task = Project.all.first.tasks.first
        story = task.create_story(:text => 'foo')
        story.must_be_instance_of Story
      end
    end

    describe '#tags' do
      it 'should return all tags for the given task' do
        task = Project.all.last.tasks.first
        tags = task.tags
        tags.must_be_instance_of Array
        tags.first.must_be_instance_of Tag
      end
    end

  end
end

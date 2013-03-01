require_relative '../../spec_helper'

module Asana
  describe Project do

    before do
      VCR.insert_cassette('projects', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it "should return all of the user's projects" do
        projects = Project.all
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '.find' do
      it 'should return a single project' do
        project = Project.find(Project.all.first.id)
        project.must_be_instance_of Project
      end
    end

    describe '.update' do
      it "should update the given project with a new name" do
        project = Workspace.all.last.create_project(:name => 'asana-test-project-foo')
        project.update(:name => 'asana-test-project-bar')
        project.name.must_equal 'asana-test-project-bar'
      end
    end

    describe '.tasks' do
      it 'should return all tasks for the given project' do
        project = Project.all.first
        tasks = Project.tasks(project.id)
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

    describe '.stories' do
      it 'should return all stories for the given project' do
        project = Project.all.first
        stories = Project.stories(project.id)
        stories.must_be_instance_of Array
        stories.first.must_be_instance_of Story
      end
    end

    describe '#update' do
      it "should update the given project with a new name" do
        project = Workspace.all.last.create_project(:name => 'asana-test-project-foo')
        Project.update(project.id, :name => 'asana-test-project-bar')
        project = Project.find(project.id)
        project.name.must_equal 'asana-test-project-bar'
      end
    end

    describe '#tasks' do
      it 'should return all tasks for the given project' do
        project = Project.all.first
        tasks = project.tasks
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

    describe '#stories' do
      it 'should return all stories for the given project' do
        project = Project.all.first
        stories = project.stories
        stories.must_be_instance_of Array
        stories.first.must_be_instance_of Story
      end
    end

    describe '#create_story' do
      it 'should create a new story for the given project' do
        project = Workspace.all.last.create_project(:name => 'asana-test-project-story')
        story = project.create_story(:text => 'foo')
        story.must_be_instance_of Story
      end
    end

  end
end

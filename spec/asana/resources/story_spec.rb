require_relative '../../spec_helper'

module Asana
  describe Story do

    before do
      VCR.insert_cassette('stories', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.find' do
      it 'should return a single story' do
        story = Project.all.first.tasks.first.stories.first.id
        Story.find(story.id).must_be_instance_of Story
      end
    end

  end
end

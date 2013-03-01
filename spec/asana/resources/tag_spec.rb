require_relative '../../spec_helper'

module Asana
  describe Tag do

    before do
      VCR.insert_cassette('tags', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.find' do
      it 'should return a single tag' do
        tag = Project.all.first.tasks.first.tags.first
        Tag.find(tag.id).must_be_instance_of Tag
      end
    end

  end
end

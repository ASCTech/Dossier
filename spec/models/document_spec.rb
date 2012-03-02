require 'spec_helper'

describe Document do

  let(:document) { create(:document) }

  describe 'adding tags' do

    it 'should create tags on the fly' do
      Tag.where(:name => 'cool').should_not exist
      Tag.where(:name => 'rad').should_not exist
      document.add_tags('cool,rad')
      document.all_tags.should include('cool')
      document.all_tags.should include('rad')
      Tag.where(:name => 'cool').should exist
      Tag.where(:name => 'rad').should exist
    end

    it 'should use existing tags if they match' do
      cool_tag = Tag.create!(:name => 'cool')
      rad_tag  = Tag.create!(:name => 'rad')
      document.add_tags('cool,rad')
      document.all_tags.should include('cool')
      document.all_tags.should include('rad')
      document.tags.should include cool_tag
      document.tags.should include  rad_tag
    end

  end

end

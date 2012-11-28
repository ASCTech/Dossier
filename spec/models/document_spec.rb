require 'spec_helper'

describe Document do

  let(:document) { create(:document) }
  let(:tag)      { create(:tag) }

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

    it 'should not allow duplicate tags on a document' do
      document.tags << tag
      document.document_tags.new(:tag_id => tag.id).should_not be_valid
      create(:document).document_tags.new(:tag_id => tag.id).should be_valid
    end

  end

  describe 'filtering by tags' do

    it 'should know which documents have a tag' do
      Document.has_tag(tag).should_not exist

      document.document_tags.create!(:tag_id => tag.id)
      Document.has_tag(tag).should include document
    end

    it 'should know which documents have a set of tags' do
      tag2 = create(:tag, :name => 'Algebraic')
      Document.has_tag(tag).has_tag(tag2).should_not exist
      document.tags << tag
      Document.has_tag(tag).has_tag(tag2).should_not exist
      document.tags << tag2
      Document.has_tag(tag).has_tag(tag2).should include document
    end

  end

end

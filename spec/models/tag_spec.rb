require 'spec_helper'

describe Tag do

  describe 'validations' do

    it 'should not allow numeric tag names' do
      Tag.new(:name => 12345).should_not be_valid
      Tag.new(:name => "123").should_not be_valid
      Tag.new(:name => '123').should_not be_valid
      Tag.new(:name => "1-2").should     be_valid
      Tag.new(:name => "12s").should     be_valid
      Tag.new(:name => 's12').should     be_valid
    end

  end

end

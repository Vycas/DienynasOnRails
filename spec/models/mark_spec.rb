require 'spec_helper'

describe Mark do
  before(:each) do
     @mark = Mark.new(:value => 10)
   end

   it 'should be able to access its value' do
     @mark.value.should == 10
   end

   it 'should have value of integer in range 1-10 or string "n" or "p"' do
     [(1..10).to_a, 'p', 'n'].flatten.each do |v|
       lambda { Mark.new(:value => v).save }.should_not raise_error
     end
     (('a'..'z').to_a - ['p', 'n']).each do |v|
       lambda { Mark.new(:value => v).save }.should raise_error
     end
     ((-100..100).to_a - (1..10).to_a).each do |v|
       lambda { Mark.new(:value => v).save }.should raise_error
     end
   end
end

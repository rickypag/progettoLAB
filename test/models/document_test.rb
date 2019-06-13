require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
   def setup
	@document = Document.new(title: "Example")
  end
  
  test "should be valid" do
	assert @document.valid?
  end
  
  test "title should be present" do
	@document.title= ""
	assert_not @document.valid?
  end
end

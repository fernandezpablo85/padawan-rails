require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DomainObject,".sanitize_html!" do

  before do
    @object = Course.new

    @object.name = "Some cool name"
    @object.description = "<h1>markup gone</h1>"
  end

  it "should remove tags when called" do

    @object.sanitize_html!
    
    @object.name.should eql("Some cool name")
    @object.description.should eql("markup gone")

  end

  it "should be called before saving the object" do
    @object.should_receive(:sanitize_html!).once
    @object.save
  end

end

require File.dirname(__FILE__) + '/spec_helper'

  describe "Frebbe" do
 
  before :all do
     @f = Frebbe
     @f.connect(:server=> 'localhost',:db=> 'frebbe4')
     @f.pres.remove()
  end
 
  it "should connect to DB /" do
      @f.pres.should_not == nil     
  end
  
  it "should not have any data /" do
      @f.pres.find().to_a.length.should == 0
  end
  
  it "should insert a post" do
    data = {:site=>"test 1",:titulo=>"test",:lineas=>["uno","dos"], :parentId=>"",:image=>"/images/test.png"}
    @f.insert(data).object_id.should_not == nil
  end
  
  it  "should contain one Home Page Post /" do
      presentations = @f.findByParent("").to_a
      presentations.length.should == 1
  end
  
  it "should delete the Home Page Post /" do    
      presentations = @f.findByParent("").to_a
      presentations.length.should == 1
      
      id = presentations[0]['_id']
      @f.delete id
      
      presentations = @f.findByParent("").to_a
      presentations.length.should == 0
  end
  
  it "should create a post inside another Post" do
    data = {:site=>"test",:titulo=>"test",:lineas=>["uno","dos"], :parentId=>"",:image=>"/images/test.png"}
    data_parent = @f.insert(data)

    data_son = {:site=>"test",:titulo=>"test son",:lineas=>["uno","dos"], :parentId => data_parent ,:image=>"/images/test.png"}
    data_son =@f.insert(data_son)
    
    data_son_0 = {:site=>"test",:titulo=>"test son son ",:lineas=>["uno","dos"], :parentId => data_parent ,:image=>"/images/test.png"}
    data_son_0 =@f.insert(data_son_0)
    
    data_son_ = {:site=>"test",:titulo=>"test son son ",:lineas=>["uno","dos"], :parentId => data_son ,:image=>"/images/test.png"}
    data_son_ =@f.insert(data_son_)
    
    data_son_1 = {:site=>"test",:titulo=>"test son son ",:lineas=>["uno","dos"], :parentId => data_son_ ,:image=>"/images/test.png"}
    data_son_1 =@f.insert(data_son_1)
    
    presentations = @f.findByParent(data_parent).to_a
    presentations.length.should > 0
    
  end
  
   it "should check that a post has children" do
     presentations = @f.findByParent("").to_a
     presentations[0]['children'].length.should > 0
    end
  
  it "should erase posts and children" do
    presentation = @f.findByParent("").to_a[0]
    @f.deleteRecursive presentation['_id']
    presentations = @f.findByParent("")    
    presentations.length.should == 0
  end
  
  it "should find presentations by tag" do
    data = {:site=>"test",:titulo=>"test",:lineas=>["uno","dos"], :parentId=>"",:image=>"/images/test.png",:tags=>["tag one","tag2","tag 3"]}
    data_parent = @f.insert(data)

    data_son = {:site=>"test",:titulo=>"test son",:lineas=>["uno","dos"], :parentId => data_parent ,:image=>"/images/test.png",:tags=>["tag two","tag3","tag 4"]}
    data_son =@f.insert(data_son)

    data_son_0 = {:site=>"test",:titulo=>"test son son ",:lineas=>["uno","dos"], :parentId => data_parent ,:image=>"/images/test.png",:tags=>["tag three","tag4","tag 5"]}
    data_son_0 =@f.insert(data_son_0)

    data_son_1 = {:site=>"test",:titulo=>"test son son ",:lineas=>["uno","dos"], :parentId => data_son ,:image=>"/images/test.png",:tags=>["tag four","tag5","tag 6"]}
    data_son_1 =@f.insert(data_son_1)

    data_son_2 = {:site=>"test",:titulo=>"test son son ",:lineas=>["uno","dos"], :parentId => data_son_1 ,:image=>"/images/test.png",:tags=>["tag five","tag6","tag 7"]}
    data_son_2 =@f.insert(data_son_2)
    
     
    presentations = @f.findByTag([Regexp.new("3"),Regexp.new("5")]).to_a
    presentations.length.should == 4
    
    
    
  end
  
  
end

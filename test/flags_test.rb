require 'helper'

class FlagsTest < Test::Unit::TestCase

  context "When using the Gowalla API and working with flags" do
    setup do
      @client = gowalla_test_client
    end

    should "retrieve a list of flags" do
      stub_get("http://pengwynn:0U812@api.gowalla.com/flags", "flags.json")
      flags = @client.flags
      flags.first.spot.name.should == 'Wild Gowallaby #1'
      flags.first.user.url.should == '/users/340897'
      flags.first[:type].should == 'invalid'
      flags.first.status.should == 'open'
    end

    should "retrieve information about a specific flag" do
      stub_get("http://pengwynn:0U812@api.gowalla.com/flags/1", "flag.json")
      flag = @client.flag(1)
      flag.spot.name.should == 'Wild Gowallaby #1'
      flag.user.url.should == '/users/340897'
      flag[:type].should == 'invalid'
      flag.status.should == 'open'
    end


    should "retrieve flags associated with that spot" do
      stub_get("http://pengwynn:0U812@api.gowalla.com/spots/1/flags", "flags.json")
      flags = @client.spot_flags(1)
      flags.first.spot.name.should == 'Wild Gowallaby #1'
      flags.first.user.url.should == '/users/340897'
      flags.first[:type].should == 'invalid'
      flags.first.status.should == 'open'
    end

    should "set a flag on a specific spot" do
      url = "http://pengwynn:0U812@api.gowalla.com/spots/1/flags/invalid"
      FakeWeb.register_uri(:post, url, :body => '{"result": "flag created"}')
      response = @client.create_spot_flag(1, 'invalid', 'my problem description')
      response.result.should == 'flag created'
    end

  end
end
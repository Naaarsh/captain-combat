require 'test_helper'

class FighterTest < ActiveSupport::TestCase
  test "should be valid" do
    f = Fighter.new(life: 0, attack: 0, dodge: 0, critical: 0, name: "Michel")
    assert f.save
  end

  test "should not save Fighter without a title" do
    f = Fighter.new(life: 0, attack: 0, dodge: 0, critical: 0)
    assert_not f.save
  end

  test "should not be valid with skillpoint under 0" do
    f = Fighter.new(life: 0, attack: 0, dodge: 0, critical: -1, name: "Michel")
    assert_not f.save
  end

  test "should not be valid with skillpoint over 10" do
    f = Fighter.new(life: 0, attack: 0, dodge: 0, critical: 11, name: "Michel")
    assert_not f.save
  end

  test "should not be valid with more than a total of 15 skillpoints" do
    f = Fighter.new(life: 5, attack: 5, dodge: 5, critical: 5, name: "Michel")
    assert_not f.save
  end

  test "should be valid with a total of 15 skillpoints" do
    f = Fighter.new(life: 5, attack: 5, dodge: 5, critical: 0, name: "Michel")
    assert f.save
  end

end

require 'test_helper'

class GoodTest < ActiveSupport::TestCase
  def setup
    @user = users(:qleg)
    @good = @user.goods.build(name: "レディース 幅広スポーティスニーカー", user_id: @user.id, goods_condition:"新品", delivery_condition:"ピックアップ", area:"Novi", price:"20", size: "23.5cm", description:"流行りのデザインで通学、体育館シューズ、仕事履きにオススメ☆滑り止め付きで靴底も厚いのでランニングシューズ、ウォーキングシューズ、運動靴としてもお使いいただけると思います。アディダス ナイキ などのスポーツメーカーに見劣りしないデザイン性の高いスニーカーでオススメです♪")
  end

  test "should be valid" do
    assert @good.valid?
  end

  test "user id should be present" do
    @good.user_id = nil
    assert_not @good.valid?
  end

  test "name should be present" do
    @good.name = "   "
    assert_not @good.valid?
  end

  test "goods_condition should be present" do
    @good.goods_condition = "   "
    assert_not @good.valid?
  end

  test "delivery_condition should be present" do
    @good.delivery_condition = "   "
    assert_not @good.valid?
  end

  test "area should be present" do
    @good.area = "   "
    assert_not @good.valid?
  end
  
  test "description should be present" do
    @good.description = "   "
    assert_not @good.valid?
  end
  test "price should be present" do
    @good.price = "   "
    assert_not @good.valid?
  end
  test "size should be present" do
    @good.size = "   "
    assert_not @good.valid?
  end

  test "description should be at most 300 characters" do
    @good.description = "a" * 301
    assert_not @good.valid?
  end

  test "order should be most recent first" do
    assert_equal goods(:most_recent), Good.first
  end

end

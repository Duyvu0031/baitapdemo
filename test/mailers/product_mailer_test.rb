require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "còn hàng" do
    mail = ProductMailer.with(product: products(:tshirt), subscriber: subscribers(:david)).in_stock
    assert_equal "còn hàng", mail.subject
    assert_equal [ "duypet524@gmail.com" ], mail.to
    assert_equal [ "duypet524@gmail.com" ], mail.from
    assert_match "Bạn Nhận Được Một Tin Mới!", mail.body.encoded
  end
end

require 'test_helper'

class FaceIdentControllerTest < ActionController::TestCase
  test "should get ident_image" do
    get('ident_image',{:filename=>'linjunjie.jpeg'})
    assert_response :success
  end
  test "should get ident_image no face" do
    get('ident_image',{:filename=>'noface.jpg'})
    assert_response 400
  end
end

require 'test_helper'

class BulletinsControllerTest < ActionController::TestCase
  setup do
    @bulletin = bulletins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulletins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should save bulletin" do
    assert_difference('Bulletin.count') do
      post :save, bulletin: {condo_id: @bulletin.condo_id, content: @bulletin.content, date: @bulletin.date, int: @bulletin.int, send_notify: @bulletin.send_notify, title: @bulletin.title}
    end

    assert_redirected_to bulletin_path(assigns(:bulletin))
  end

  test "should show bulletin" do
    get :show, id: @bulletin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bulletin
    assert_response :success
  end

  test "should update bulletin" do
    patch :update, id: @bulletin, bulletin: {condo_id: @bulletin.condo_id, content: @bulletin.content, date: @bulletin.date, int: @bulletin.int, send_notify: @bulletin.send_notify, title: @bulletin.title}
    assert_redirected_to bulletin_path(assigns(:bulletin))
  end

  test "should destroy bulletin" do
    assert_difference('Bulletin.count', -1) do
      delete :destroy, id: @bulletin
    end

    assert_redirected_to bulletins_path
  end

  # test "the truth" do
  #   assert true
  # end
end


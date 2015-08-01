require 'test_helper'

class TimecodesControllerTest < ActionController::TestCase
  setup do
    @timecode = timecodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timecodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timecode" do
    assert_difference('Timecode.count') do
      post :create, timecode: { end_time: @timecode.end_time, start_time: @timecode.start_time }
    end

    assert_redirected_to timecode_path(assigns(:timecode))
  end

  test "should show timecode" do
    get :show, id: @timecode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @timecode
    assert_response :success
  end

  test "should update timecode" do
    patch :update, id: @timecode, timecode: { end_time: @timecode.end_time, start_time: @timecode.start_time }
    assert_redirected_to timecode_path(assigns(:timecode))
  end

  test "should destroy timecode" do
    assert_difference('Timecode.count', -1) do
      delete :destroy, id: @timecode
    end

    assert_redirected_to timecodes_path
  end
end

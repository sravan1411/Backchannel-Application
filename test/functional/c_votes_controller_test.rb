require 'test_helper'

class CVotesControllerTest < ActionController::TestCase
  setup do
    @c_vote = c_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:c_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create c_vote" do
    assert_difference('CVote.count') do
      post :create, c_vote: {  }
    end

    assert_redirected_to c_vote_path(assigns(:c_vote))
  end

  test "should show c_vote" do
    get :show, id: @c_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @c_vote
    assert_response :success
  end

  test "should update c_vote" do
    put :update, id: @c_vote, c_vote: {  }
    assert_redirected_to c_vote_path(assigns(:c_vote))
  end

  test "should destroy c_vote" do
    assert_difference('CVote.count', -1) do
      delete :destroy, id: @c_vote
    end

    assert_redirected_to c_votes_path
  end
end

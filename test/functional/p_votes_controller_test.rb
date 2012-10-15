require 'test_helper'

class PVotesControllerTest < ActionController::TestCase
  setup do
    @p_vote = p_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:p_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create p_vote" do
    assert_difference('PVote.count') do
      post :create, p_vote: {  }
    end

    assert_redirected_to p_vote_path(assigns(:p_vote))
  end

  test "should show p_vote" do
    get :show, id: @p_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @p_vote
    assert_response :success
  end

  test "should update p_vote" do
    put :update, id: @p_vote, p_vote: {  }
    assert_redirected_to p_vote_path(assigns(:p_vote))
  end

  test "should destroy p_vote" do
    assert_difference('PVote.count', -1) do
      delete :destroy, id: @p_vote
    end

    assert_redirected_to p_votes_path
  end
end

require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resp = responses(:one)

  end

  test "should get index" do
    get responses_url
    assert_response :success
  end

  test "should get new" do
    get new_response_url
    assert_response :success
  end

  test "should create response" do
    assert_difference('Response.count') do
      post responses_url, params: { response: { content: @resp.content, question_id: @resp.question_id } }
    end

    assert_redirected_to response_url(Response.last)
  end

  test "should show response" do
    get response_url(@resp)
    assert_response :success
  end

  test "should get edit" do
    get edit_response_url(@resp)
    assert_response :success
  end

  test "should update response" do
    puts @resp.content.inspect
    patch response_url(@resp), params: { response: { content: @resp.content, question_id: @resp.question_id } }
    assert_redirected_to response_url(@resp)
  end

  test "should destroy response" do
    assert_difference('Response.count', -1) do
      delete response_url(@resp)
    end

    assert_redirected_to responses_url
  end
end

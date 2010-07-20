require 'test_helper'

class PartDetailsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:part_details)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_part_detail
    assert_difference('PartDetail.count') do
      post :create, :part_detail => { }
    end

    assert_redirected_to part_detail_path(assigns(:part_detail))
  end

  def test_should_show_part_detail
    get :show, :id => part_details(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => part_details(:one).id
    assert_response :success
  end

  def test_should_update_part_detail
    put :update, :id => part_details(:one).id, :part_detail => { }
    assert_redirected_to part_detail_path(assigns(:part_detail))
  end

  def test_should_destroy_part_detail
    assert_difference('PartDetail.count', -1) do
      delete :destroy, :id => part_details(:one).id
    end

    assert_redirected_to part_details_path
  end
end

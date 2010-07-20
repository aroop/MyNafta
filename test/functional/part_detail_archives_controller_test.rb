require 'test_helper'

class PartDetailArchivesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:part_detail_archives)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_part_detail_archive
    assert_difference('PartDetailArchive.count') do
      post :create, :part_detail_archive => { }
    end

    assert_redirected_to part_detail_archive_path(assigns(:part_detail_archive))
  end

  def test_should_show_part_detail_archive
    get :show, :id => part_detail_archives(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => part_detail_archives(:one).id
    assert_response :success
  end

  def test_should_update_part_detail_archive
    put :update, :id => part_detail_archives(:one).id, :part_detail_archive => { }
    assert_redirected_to part_detail_archive_path(assigns(:part_detail_archive))
  end

  def test_should_destroy_part_detail_archive
    assert_difference('PartDetailArchive.count', -1) do
      delete :destroy, :id => part_detail_archives(:one).id
    end

    assert_redirected_to part_detail_archives_path
  end
end

require 'test_helper'

class ImportersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:importers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_importer
    assert_difference('Importer.count') do
      post :create, :importer => { }
    end

    assert_redirected_to importer_path(assigns(:importer))
  end

  def test_should_show_importer
    get :show, :id => importers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => importers(:one).id
    assert_response :success
  end

  def test_should_update_importer
    put :update, :id => importers(:one).id, :importer => { }
    assert_redirected_to importer_path(assigns(:importer))
  end

  def test_should_destroy_importer
    assert_difference('Importer.count', -1) do
      delete :destroy, :id => importers(:one).id
    end

    assert_redirected_to importers_path
  end
end

require 'test_helper'

class CertifiedRepositoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:certified_repositories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_certified_repository
    assert_difference('CertifiedRepository.count') do
      post :create, :certified_repository => { }
    end

    assert_redirected_to certified_repository_path(assigns(:certified_repository))
  end

  def test_should_show_certified_repository
    get :show, :id => certified_repositories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => certified_repositories(:one).id
    assert_response :success
  end

  def test_should_update_certified_repository
    put :update, :id => certified_repositories(:one).id, :certified_repository => { }
    assert_redirected_to certified_repository_path(assigns(:certified_repository))
  end

  def test_should_destroy_certified_repository
    assert_difference('CertifiedRepository.count', -1) do
      delete :destroy, :id => certified_repositories(:one).id
    end

    assert_redirected_to certified_repositories_path
  end
end

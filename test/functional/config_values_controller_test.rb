require 'test_helper'

class ConfigValuesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:config_values)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_config_value
    assert_difference('ConfigValue.count') do
      post :create, :config_value => { }
    end

    assert_redirected_to config_value_path(assigns(:config_value))
  end

  def test_should_show_config_value
    get :show, :id => config_values(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => config_values(:one).id
    assert_response :success
  end

  def test_should_update_config_value
    put :update, :id => config_values(:one).id, :config_value => { }
    assert_redirected_to config_value_path(assigns(:config_value))
  end

  def test_should_destroy_config_value
    assert_difference('ConfigValue.count', -1) do
      delete :destroy, :id => config_values(:one).id
    end

    assert_redirected_to config_values_path
  end
end

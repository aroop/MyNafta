# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def user_is_admin?
    session[:user_id] && (user = User.find(session[:user_id])) && user.is_admin
  end

  def controller_is(*attrs) # <= check for one or multiple controllers
    attrs.collect{|attr| attr.to_s}.include?(controller.controller_name)
  end

  def action_is(*attrs) # <= check for  one or multiple actions
    attrs.map{|attr| attr.to_s}.include?(controller.action_name)
  end

  def controller_action_is(c,a) # <= check for controller and action
    controller_is(c) && action_is(a)
  end

  def show_directory_navigation?
    controller_is('movies', 'actors', 'photos', 'videos', 'profiles')
  end



end

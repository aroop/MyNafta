class SubMenu
  
  attr_accessor :path, :title, :icon_filename, :active
  
  def initialize(path, title, icon_filename, active=false)
    @title = title
    @path = path
    @icon_filename = icon_filename
    @active = active
  end

end
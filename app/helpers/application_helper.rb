module ApplicationHelper
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if !@title then
      base_title
    else
      base_title +" | " + @title
    end
      
  end
end

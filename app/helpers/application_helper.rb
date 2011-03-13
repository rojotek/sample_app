module ApplicationHelper
  def logo
     image_tag "logo.png", :alt=> 'Sample App', :class=> 'round'
  end
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if !@title then
      base_title
    else
      base_title +" | " + @title
    end
      
  end
end

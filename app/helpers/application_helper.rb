module ApplicationHelper
  
  #Regresa el logo para el header
  def logo
    log = image_tag("logo.png", :alt => "App de ejemplo", :class => "round")
  end
  
  #Regresa un titulo por cada página
  def title
    base_title = "App de ejemplo del Tutorial de Ruby on Rails"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end

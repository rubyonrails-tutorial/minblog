module ApplicationHelper

  def logo
    image_tag("logo-minblog.png", :alt => "Logo Mini Blog", :class => "round")
  end
  
  # Retourner un titre basé sur la page.
  def title
    p base_title = "Mini Blog"
    p "#{base_title} - #{@title}".html_safe if !@title.nil?
  end
end
module ApplicationHelper

  def logo
     image_tag("open-source-logo.png", :alt => "Application exemple", :class => "round")
  end
  
  # Retourner un titre basé sur la page.
  def title
   p base_title = "Mini Blog"
   p "#{base_title} - #{@title}".html_safe if @titre.nil?
  end
end
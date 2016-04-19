module ApplicationHelper

  def logo
    image_tag("logo-minblog.png", :alt => "Logo Mini Blog", :class => "round")
  end
  
  # Retourner un titre basé sur la page.
  def title
    p base_title = "Mini Blog"
    p "#{base_title} - #{@title}".html_safe if @titre.nil?
  end
 
  def errors_full_messages
    byebug
    flash.each do |key, value|
      p += "<div class='flash #{key}'>#{value}</div>"
    end
    p
  end
end
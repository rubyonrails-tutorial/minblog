module ApplicationHelper

  def logo
     image_tag("open-source-logo.png", :alt => "Application exemple", :class => "round")
  end
  
  # Retourner un titre basé sur la page.
  def title
    base_title = "Mini Blog"
    if @titre.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
    byebug
  end
end

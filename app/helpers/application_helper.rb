module ApplicationHelper

  # Retourner un titre basé sur la page.
  def title
    base_title = "Mini Blog"
    if @titre.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end

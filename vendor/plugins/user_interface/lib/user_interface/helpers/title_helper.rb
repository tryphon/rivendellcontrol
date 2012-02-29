module UserInterface::TitleHelper

  def title(title = nil)
    @title = title if title
    h @title
  end

  def title_tag(title = nil)
    content_tag :h1, title(title)
  end

end

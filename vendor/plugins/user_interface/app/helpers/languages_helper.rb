module LanguagesHelper
  def link_to_language(language)
    link_to image_tag("ui/flags/#{language}.gif"), language_path(language), :method => :put, :title => translate("languages.link_to_language", :locale => language)
  end

  def links_to_languages
    [:en, :fr].collect do |language|
      link_to_language language
    end.join(' ')
  end
end

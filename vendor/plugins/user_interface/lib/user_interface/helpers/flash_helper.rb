module UserInterface::FlashHelper

  def flash_tag(flash)
    unless flash.empty?
      content_tag(:div, :id => "flash") do
        flash.collect do |level, message|
          content_tag :div, sanitize(message), :class => level
        end.join("\n")
      end
    end
  end

end

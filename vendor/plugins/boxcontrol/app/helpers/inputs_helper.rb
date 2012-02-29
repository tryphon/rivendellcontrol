module InputsHelper
  
  def form_for_input(input, &block)
    form_for :input, input, :url => input_path, :html => { :method => :put }, &block
  end

  def input_partial(input)
    {:partial => input_partial_name(input), :object => input}
  end

  def form_input_partial(f, input)
    { :partial => "form_" + input_partial_name(input), :locals => { :form => f } }
  end

  def input_partial_name(input)
    input.class.name.underscore
  end

end

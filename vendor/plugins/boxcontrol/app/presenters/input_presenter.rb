class InputPresenter 
  
  def initialize(input)
    @input = input
  end

  def partial
    {:partial => partial_name, :object => @input}
  end

  def form_partial(f)
    { :partial => "form_#{partial_name}", :locals => { :form => f } }
  end

  def partial_name
    @input.class.name.underscore
  end

end

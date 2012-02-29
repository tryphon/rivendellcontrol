class SupportPresenter

  attr_accessor :network

  def initialize(support)
    @support = support
  end

  def poll_check
    if @support.poll_check == 1
      "active"
    else
      "inactive"
    end
  end

  def boot_check
    if @support.boot_check == 1
      "active"
    else
      "inactive"
    end
  end
end

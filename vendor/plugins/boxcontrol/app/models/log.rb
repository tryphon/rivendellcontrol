class Log

  def self.human_name(*args)
    I18n.translate("activerecord.models.log")
  end

  attr_accessor :filter

  def last_lines
    filtered_lines.last(500).reverse
  end

  def filtered_lines
    filter.present? ? readlines.grep(/#{filter}/i) : readlines
  end

  def compressed
    ActiveSupport::Gzip.compress read
  end

  @@syslog_file = "/var/log/syslog"
  cattr_accessor :syslog_file

  def read
    IO.read syslog_file
  end

  def readlines
    IO.readlines syslog_file
  end

end

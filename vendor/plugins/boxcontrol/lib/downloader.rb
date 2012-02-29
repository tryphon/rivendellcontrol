require 'net/http'

class Downloader

  attr_reader :url

  def initialize(url)
    @url = URI.parse url
  end

  def self.open(url, &block) 
    new(url).open(&block)
  end

  def open(&block)
    if url.scheme == "http"
      open_http &block
    else
      open_file &block
    end
  end

  def open_file(&block)
    content_length = File.size(url.path)
    File.open(url.path, "r") do |file|
      downloaded_size = 0
      while data = file.read(1024)
        downloaded_size += data.size
        yield data, downloaded_size, content_length
      end
    end
  end

  def open_http(&block)
    send_request do |response|
      content_length = nil
      if response.key?('Content-Length')
        content_length = response['Content-Length'].to_i
      end

      downloaded_size = 0
      response.read_body do |data|
        downloaded_size += data.size
        yield data, downloaded_size, content_length
      end
    end
  end

  def send_request(target = url, redirection_count = 0, &block)
    raise "Too many redirections, last one was #{target}" if redirection_count > 10

    Net::HTTP.start(target.host, target.port) do |http|
      request = Net::HTTP::Get.new target.path
      http.request(request) do |response|
        case response
        when Net::HTTPSuccess
          yield response
        when Net::HTTPMovedPermanently, # 301
          Net::HTTPFound, # 302
          Net::HTTPSeeOther, # 303
          Net::HTTPTemporaryRedirect # 307
          send_request URI.parse(response['location']), redirection_count+1, &block
        else
          response.error!
        end
      end
    end
  end

end

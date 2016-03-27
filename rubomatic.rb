require 'rss'
require 'open-uri'
require 'transmission_api'

URL = 'http://showrss.info/rss.php?user_id=17648&hd=null&proper=null'
CACHE = "/tmp/feed_status.txt"

class FileCache
  def initialize(f)
    @file = f
  end

  def set(line)
    cache_file = File.open(@file, "a")
    cache_file.write("#{line}\n")
    cache_file.close
  end

  def exists?(line)
    return false unless File.exists? @file
    cache = File.read(@file).split("\n")
    cache.include? line
  end
end

cache = FileCache.new CACHE

transmission_api_client = TransmissionApi::Client.new(
  :url      => "http://127.0.0.1:9091/transmission/rpc"
)

open(URL) do |rss|
  feed = RSS::Parser.parse(rss)
  feed.items.each do |item|
    next if cache.exists? item.title
    puts "Adding #{item.title} to the download queue"
    torrent = transmission_api_client.create(item.link)
    cache.set(item.title)
  end

end

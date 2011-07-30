
require 'trollop'
require 'aws/s3'
require 'yajl/json_gem'

module SST
  def self.version
    File.read(File.join(File.dirname(__FILE__), '../VERSION')).chomp
  end

  def self.plist_version
    1
  end
end

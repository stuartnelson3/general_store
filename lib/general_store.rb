require "yaml"
require "ostruct"
require "fileutils"

class GeneralStore
  attr_accessor :config

  def self.read dir_name
    new YAML.load_file config_file dir_name
  rescue Errno::ENOENT
    puts 'You need to setup your General Store first!'
  end

  def self.create dir, ostruct = OpenStruct.new
    @dir = dir
    create_config_file
    yield ostruct
    new(ostruct.to_h).set dir
  end

  def set dir
    klass = self.class
    klass.write_file klass.config_file(dir), config
  end

  def initialize config_contents
    self.config = config_contents
    config.each do |k,v|
      accessor = k.to_sym
      self.class.class_eval do
        attr_accessor accessor
      end
      send("#{accessor}=", v)
    end
  end
  private_class_method :new

  def self.config_file dir_name
    File.expand_path File.join dir_name, "config.yml"
  end

  def self.config_dir
    File.expand_path @dir
  end

  def self.create_config_file
    ensure_dir_existence
    ensure_file_existence
  end

  def self.write_file file, data
    File.open file, File::RDWR|File::TRUNC|File::CREAT, 0600 do |config|
      config.write YAML.dump data
    end
  end

  def self.ensure_dir_existence
    FileUtils.mkdir_p config_dir
  end

  def self.ensure_file_existence
    file = config_file @dir
    unless File.exists? file
      write_file file, {}
    end
  end
end

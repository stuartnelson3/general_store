require "yaml"
require "ostruct"

class GeneralStore
  attr_accessor :config

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

  def self.read dir_name
    new YAML.load_file config_file dir_name
  rescue Errno::ENOENT
    puts 'You need to setup your General Store first!'
  end

  def self.create dir
    @dir = dir
    create_config_file
    ostruct = OpenStruct.new
    yield ostruct
    new(ostruct.to_h).set dir
  end

  def self.config_file dir_name
    File.expand_path File.join dir_name, "config.yml"
  end
  private_class_method :config_file

  def self.config_dir
    File.expand_path @dir
  end
  private_class_method :config_dir

  def set dir
    klass = self.class
    klass.write_file klass.config_file(dir), config
  end
  private :set

  def self.create_config_file
    check_dir_existence
    check_file_existence
  end
  private_class_method :create_config_file

  def self.write_file file, data
    File.open file, File::RDWR|File::TRUNC|File::CREAT, 0600 do |config|
      config.write YAML.dump data
    end
  end
  private_class_method :write_file

  def self.check_dir_existence
    unless Dir.exists? config_dir
      Dir.mkdir config_dir
    end
  end
  private_class_method :check_dir_existence

  def self.check_file_existence
    file = config_file @dir
    unless File.exists? file
      write_file file, {}
    end
  end
  private_class_method :check_file_existence
end

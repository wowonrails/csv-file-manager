# frozen_string_literal: true

require "csv"
require "csv_file_manager/file_manager"
require "csv_file_manager/file_redactor"
require "csv_file_manager/instance_properties"
require "csv_file_manager/base_methods"

# Dir[File.dirname(__FILE__).concat('/**/*.rb')].each { |path| require path }

module CsvFileManager
  def self.create_file(class_name)
    FileManager.create(class_name)
  end

  def self.destroy_file(class_name)
    FileManager.destroy(class_name)
  end

  class Base
    extend  CsvFileManager::FileRedactor
    include CsvFileManager::InstanceProperties
    include CsvFileManager::BaseMethods
  end
end

class Post < CsvFileManager::Base
  my_properties :title, :content
end

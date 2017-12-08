require "active_support/inflector"

module CsvFileManager
  class FilePath
    class << self
      def retrieve(class_object)
        database_store_path << file_name(class_object)
      end

      def file_name(class_object)
        class_object.name.pluralize << "_table.csv"
      end

      def database_store_path
        dir = Dir.home << "/my-database/"

        Dir.mkdir(dir) unless Dir.exist?(dir)

        dir
      end
    end
  end
end

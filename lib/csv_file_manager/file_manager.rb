require "csv_file_manager/file_path"

module CsvFileManager
  class FileManager
    class << self
      def create(class_name, _headers = [])
        CSV.open(FilePath.retrieve(class_name), "w+")
      end

      def destroy(class_name)
        File.delete(FilePath.retrieve(class_name))
      end
    end
  end
end

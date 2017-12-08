require "csv_file_manager/file_path"

module CsvFileManager
  module FileRedactor
    def create_row(**params)
      @params = params.merge(id: new_id, created_at: Time.now, updated_at: Time.now)

      record_row(@file_path, @params)
    end

    def find_row(id)
      fetch_table.find { |row| row[:id] == id }
    end

    def update_row(id, **params)
      table = fetch_table.each do |row|
        next if row[:id] != id

        row[:updated_at] = Time.now

        params.each do |key, value|
          row[key] = value if props.include?(key)
        end
      end

      rewrite_file(table)
    end

    def delete_row(id)
      table = fetch_table.delete_if do |row|
        row[:id] == id
      end

      rewrite_file(table)
    end

    def all_rows
      array_rows = []

      fetch_table.each do |row|
        array_rows << row.to_hash
      end

      array_rows
    end

    def first_id
      fetch_table.map { |row| row[:id] }.min
    end

    def last_id
      @last_id = fetch_table.map { |row| row[:id] }.max
    end

    private

    def new_id
      last_id ? @last_id + 1 : 1
    end

    def fetch_table
      @table ||= CSV.table(retrieve_file_path, headers: true, header_converters: :symbol)
    end

    def retrieve_file_path
      @file_path = FilePath.retrieve(self)
    end

    def record_row(file_path, params)
      row = CSV::Row.new(props, [], false)

      props.each do |header|
        row[header] = params[header]
      end

      CSV.open(file_path, "a") do |csv|
        csv << row
      end
    end

    def rewrite_file(table)
      File.open(@file_path, "w") do |f|
        f.write(table)
      end
    end
  end
end

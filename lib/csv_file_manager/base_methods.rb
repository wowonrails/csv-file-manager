require "time"

module CsvFileManager
  module BaseMethods
    def self.included(base)
      base.extend(BaseMethods::ClassMethods)
    end

    def save
      if id
        update(attributes)
      else
        self.class.create(attributes)
      end
    end

    def update(**params)
      self.class.update_row(id, params)

      self.class.find(id)
    end

    def destroy
      self.class.delete_row(id)

      self
    end

    def attributes
      Hash[self.class.props.map { |name, _| [name, send(name)] }]
    end

    module ClassMethods
      def create(**params)
        create_row(params)

        new @params
      end

      def find(id)
        attributes = parse_time_attributes(find_row(id).to_hash)

        new attributes
      end

      def first
        attributes = parse_time_attributes(find_row(first_id).to_hash)

        new attributes
      end

      def last
        attributes = parse_time_attributes(find_row(last_id).to_hash)

        new attributes
      end

      def all
        all_rows.map { |attrs| new parse_time_attributes(attrs) }
      end

      private

      def parse_time_attributes(attrs)
        attrs.tap do |h|
          h[:created_at] = Time.parse(h[:created_at])
          h[:updated_at] = Time.parse(h[:updated_at])
        end
      end
    end
  end
end

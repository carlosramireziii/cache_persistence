module CachePersistence
  module Finders
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def where(attrs = {})
        records = self.all
        attrs.each do |name, value|
          records.reject! { |r| r.send(name) != value }
        end
        records
      end

      def find_by(attrs = {})
        where(attrs).first
      end

      def limit(num)
        self.all.take(num)
      end

      def first
        self.all.first
      end

      def last
        self.all.last
      end

    end
  end
end
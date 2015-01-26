require 'cache_persistence/database'
require 'cache_persistence/errors'

module CachePersistence
  module Persistence
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        include ActiveModel::Model

        attr_reader :id

        def persisted?
          id.present?
        end

        def ==(other)
          id == other.id
        end
      end
    end

    def save
      return unless valid?
      database = Database.new(self.class)
      @id ||= database.next_id
      database.commit(self.id, self)
    end
    alias_method :save!, :save

    def update(params)
      return unless valid?
      params.each do |name, value|
        self.send("#{name}=", value)
      end
      database = Database.new(self.class.to_s)
      database.commit(self.id, self)
    end

    def destroy
      database = Database.new(self.class.to_s)
      database.commit(self.id, nil)
    end

    def valid?
      true
    end

    module ClassMethods

      def find(id)
        database = Database.new(self.to_s)
        database.fetch(id)
      end

      def all
        database = Database.new(self.to_s)
        database.fetch_all
      end

      def destroy_all
        database = Database.new(self.to_s)
        database.fetch_all.each do |record|
          record.destroy
        end
      end

      def count
        database = Database.new(self.to_s)
        database.fetch_all.size
      end

      def create(attrs = {})
        self.new(attrs).tap { |r| r.save }
      end
    end
  end
end
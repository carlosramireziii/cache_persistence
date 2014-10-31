# NOTE: this will probably suffer from multithreading problems
# TODO: let the cache object be configurable instead of hardcoding Rails.cache
module CachePersistence
  class Database

    def initialize(klass)
      @cache_key = "#{klass.to_s}/all"
    end

    def fetch(id)
      records_hash[id.to_i] or raise Errors::RecordNotFound.new("Record with id #{id} not found")
    end

    def fetch_all
      records_hash.values
    end

    def commit(id, record)
      records_hash[id.to_i] = record
      records_hash.delete(id) if record.nil?
      rewrite_records_hash
    end

    def next_id
      records_hash.keys.max.to_i + 1
    end

    private

    def records_hash
      @records_hash ||= fetch_records_hash
    end

    def fetch_records_hash
      Rails.cache.read(@cache_key) || {}
    end

    def rewrite_records_hash
      Rails.cache.write(@cache_key, records_hash)
    end
  end
end
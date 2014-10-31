require 'cache_persistence/persistence'
require 'cache_persistence/finders'

module CachePersistence
  class Base
    include Persistence
    include Finders
  end
end
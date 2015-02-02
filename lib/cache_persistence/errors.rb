module CachePersistence
  module Errors
    RecordNotFound = Class.new(StandardError)
    RecordInvalid = Class.new(StandardError)
  end
end
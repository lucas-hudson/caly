module Caly
  class Util
    def self.classify(str)
      str.to_s.split("_").collect!(&:capitalize).join
    end

    def self.compact_blank(hash)
      hash.compact.reject do |_k, v|
        v.nil? || (v.respond_to?(:blank?) && v.blank?) || (v.respond_to?(:empty?) && v.empty?)
      end
    end
  end
end

module Caly
  class Util
    def self.classify(str)
      str.to_s.split("_").collect!(&:capitalize).join
    end

    def self.compact_blank(hash)
      hash.reject {|_k, v| v.blank?}
    end
  end
end

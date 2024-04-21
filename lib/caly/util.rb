module Caly
  class Util
    def self.classify(str)
      str.to_s.split("_").collect!(&:capitalize).join
    end
  end
end

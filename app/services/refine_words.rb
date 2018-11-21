class RefineWords
  def self.call(words)
    words.split("\n").first(5)
  end
end

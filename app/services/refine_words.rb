class RefineWords
  def self.call(words)
    new_words = +words
    # omit letters in parentheses
    new_words.gsub!(/\(.*\)/, "")
    # omit numbers
    new_words.gsub!(/(\d+.?)/, "")
    # omit non-alphabet letters(pipes, commas, slashes)
    new_words.gsub!(/[\|\/\,\.\:\;\[\]]/, "")
    # after these actions, omit whitespaces both head and tail
    # call reduce method with empty? in the brock
    new_words.split("\n").reject do |word|
      word.strip!
      word.empty?
    end
  end
end

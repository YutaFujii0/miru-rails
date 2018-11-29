class RefineWords
  def self.call(words)
    return nil if words.nil?

    # store words because argument word is frozen
    new_words = +words
    # omit letters in parentheses
    new_words.gsub!(/\(.*\)/, "")
    # omit numbers
    new_words.gsub!(/(\d+.?)/, "")
    # omit non-alphabet letters(pipes, commas, slashes)
    new_words.gsub!(/[\|\/\,\.\:\;\[\]\=\$\¥\円]/, "")
    # after these actions, omit whitespaces both head and tail
    # call reduce method with empty? in the brock
    new_words.split("\n").reject do |word|
      word.strip!
      word.empty?
    end
  end
end

class RefineWords
  def self.call(words)

    # ascii code

    # omit letters in parentheses
    words.gsub!(/\(.*\)/, "")
    # omit numbers
    words.gsub!(/(\d+.?)/, "")
    # omit non-alphabet letters(pipes, commas, slashes)
    words.gsub!(/[\|\/\,\.\:\;\[\]]/, "")
    puts "after 3rd action #{words}"
    # after these actions, omit whitespaces both head and tail
    # words.strip!
    # call reduce method with empty? in the brock
    words.split("\n").reject do |word|
      word.strip!
      word.empty?
    end
  end
end

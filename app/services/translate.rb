require "google/cloud/translate"

class Translate
  def self.call(foreign_word)
    target = "en"
    translate = (Google::Cloud::Translate.new project: ENV["GOOGLE_CLOUD_PROJECT"])
    translation = translate.translate foreign_word, to: target
  end
end

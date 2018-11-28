class GoogleCloudVisionJob < ApplicationJob
  queue_as :default

  def perform(path)
    # DetectWords returns a hash with language and text
    ocr_results = DetectWords.call(path)
    # for the text, call the RefineWords method
    ocr_results[:text] = RefineWords.call(ocr_results[:text]) # -> REFERENCE 1 (refer to the bottom)
    # and return the hash
    ocr_results
  end
end

# REFERENCES
# 1. ocr_results[:text] can be a hash when the image has no letter
#     We set if statement in RefineWords class to avoid causing undefined method
#     error *** for NilClass.
#     Also see app/services/detect_words.rb and app/services/refine_words.rb
#     As a next step, in MenuController, render view with error message

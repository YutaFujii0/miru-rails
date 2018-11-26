class GoogleCloudVisionJob < ApplicationJob
  queue_as :default

  def perform(path)
    # DetectWords returns a hash with language and text
    detect_results = DetectWords.call(path)
    # for the text, call the RefineWords method
    detect_results[:text] = RefineWords.call(detect_results[:text])
    # and return the hash
    detect_results
  end
end

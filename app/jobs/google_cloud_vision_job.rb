class GoogleCloudVisionJob < ApplicationJob
  queue_as :default

  def perform(path)
    detect_words = DetectWords.call(path)
    RefineWords.call(detect_words)
  end
end

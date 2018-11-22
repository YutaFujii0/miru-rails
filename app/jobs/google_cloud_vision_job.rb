class GoogleCloudVisionJob < ApplicationJob
  queue_as :default

  def perform(path)
    detect_words = "00000000000 1000\n本日のおすすめ\n播磨産生カキ\nお刺身盛合せ\n秋田しいたけ\nピクルス\n天ぷら\nマヨチーズ焼き5 9\nサーモンとキノコ"
    # detect_words = DetectWords.call(path)
    RefineWords.call(detect_words)
  end
end

class GoogleCloudVisionJob < ApplicationJob
  queue_as :default

  def perform(path)
    detect_words = "-7 チキンナンバン690\nかきあげ690 |\n山田醤油\nおでん盛合せ690|みりん干し,590モモステーキ\n大根玉子竹輪なると11唐揚げ 590\nちくわぶつみれさつま揚\nおろし葱ソース\nサーモンハラス焼590-チューリップ唐揚げ-\nワカサギ天ぷら490\n芝海老かき揚げ590\nレモンバター焼き690\n:\n2本290"
    # detect_words = DetectWords.call(path)
    RefineWords.call(detect_words)
  end
end

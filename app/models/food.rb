class Food < ApplicationRecord
  has_many :results, dependent: :destroy

  # for temporary use
  SAMPLE_IMAGES = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROOxkx63-nDWNxgEFCIIDxg4EIB8A16PLTaGfEttPEqFgvtkO8aN9yhtM",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCHPLNtU2fTUJvbA6T7-LNhf6PiTHmJDrlyymgR3vr5jm-O90JgjOdtjI",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUoMnJPRsuCb6FR0DWeEICML84nDYIXLGN7mxKB5xahU9yZ-82JrNxZ7x0",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEbm52BNP-3N9KeD1B-WnC7N6lxIhLG6SWLuP0U82zkHfXeaqUovXx09og",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Wz7HyCHbgr3AEG4XFfQglZvVh_cdvUOc7BdT7-ajRAJimYytCU3xEDTW",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5ccGlcyS-uo0PNMVimcpP9pgQptx3Gbf50uLcjOmqkOYmlUfpYBil_mPb",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUzJYxy5Jn-mH2nXSzVNvhmg2pKUjj7OTCS_G2eL_8UsIPU6CafCu76mQ",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfw_DGC8E2LiFCI37v_z5L0gQF3pFhqngKf22hBykX_ESPOybDaB9wjIYp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMAUsY6QemwF48ujlv2et21tPbe1_rQVzeGpyv3L1IkzdyXiXB78jsCog",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi-uTxIS9sz--YeEuhNbIBYGSeN2j0W3c7KUpEg_DxuyaJRi-yc5QTAITo"
  ]
  DEFAULT_IMAGE = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi-uTxIS9sz--YeEuhNbIBYGSeN2j0W3c7KUpEg_DxuyaJRi-yc5QTAITo"
end

class Food < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :favourites, dependent: :destroy

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
  DEFAULT_IMAGE = "https://res.cloudinary.com/dwoaw9y1s/image/upload/v1543452501/jo2zhhomilrau2h9dsy2.png"
end

# default image file is stored in app/assets/images/default_image.png

# [3] pry(main)> Cloudinary::Uploader.upload("app/assets/images/default_image.png")
# => {"public_id"=>"jo2zhhomilrau2h9dsy2",
#  "version"=>1543452501,
#  "signature"=>"8604ce43f874b68ac7d3c882d45b3559a00e807f",
#  "width"=>1200,
#  "height"=>1200,
#  "format"=>"png",
#  "resource_type"=>"image",
#  "created_at"=>"2018-11-29T00:48:21Z",
#  "tags"=>[],
#  "bytes"=>55317,
#  "type"=>"upload",
#  "etag"=>"d3922f45abc44b21995c6dbee10c21fd",
#  "placeholder"=>false,
#  "url"=>"http://res.cloudinary.com/dwoaw9y1s/image/upload/v1543452501/jo2zhhomilrau2h9dsy2.png",
#  "secure_url"=>"https://res.cloudinary.com/dwoaw9y1s/image/upload/v1543452501/jo2zhhomilrau2h9dsy2.png",
#  "original_filename"=>"default_image"}

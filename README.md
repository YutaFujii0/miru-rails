Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

## for contributers
set the following environment variables
```
# /.env

CLOUDINARY_URL=cloudinary://12***********89:***************************@********

SEARCH_ENGINE_ID
GOOGLE_CUSTOM_SEARCH_KEY
GOOGLE_CLOUD_PROJECT
GOOGLE_APPLICATION_CREDENTIALS
```
where to find...
- cloudinary key: [cloudinary console](https://cloudinary.com/console)
- SEARCH_ENGINE_ID: open [custom search](https://cse.google.com/cse/), select your search engine and see 'Search engine ID'
- about google custom search, you need several settings => [see this](https://github.com/YutaFujii0/menu_scrape/blob/master/google-custom-search-API.md)
- GOOGLE_CLOUD_PROJECT: open [Google Cloud Platform](https://console.cloud.google.com/home/) and select your project, in the dashboard select 'Project Info' -> see 'Project ID'
- GOOGLE_CUSTOM_SEARCH_KEY: open [Google Cloud Platform](https://console.cloud.google.com/home/) and select your project, beneath the dashboard select 'Project Info' -> 'credentials' tab -> 'API keys' 'Key'



## Google Cloud Vision API

- Set up: follow [Cloud Vision API documents](https://cloud.google.com/vision/docs/libraries)

1. create service account (no coding)
  - IMPORTANT: you'll download a json file when create a service key. Note the path of that json file as you'll use it to set credential.(No need for contributers)
2. set credential in terminal,
  ```bash
  export GOOGLE_CLOUD_PROJECT="[PROJECT NAME]"
  export GOOGLE_APPLICATION_CREDENTIALS="[PATH]"
  ```

- Usage: [method library for image](https://googleapis.github.io/google-cloud-ruby/docs/google-cloud-vision/latest/Google/Cloud/Vision/Image.html#text-instance_method)

1. Add gem 'google-cloud-vision' in Gemfile
2. `bundle install`
3. check the methods library and conceive what you can do
4. create vision instance, then call a `.image` method
5. call whatever method you want

```ruby
    # in this application
    # you can see the project name in your api console
    vision = Google::Cloud::Vision.new project: "PROJECT_ID"
    text  = vision.image(image_path).text
    puts text.text # -> return an array
```

## Google Custom Search API

[Google Custom Search](https://developers.google.com/custom-search/v1/cse/list)

use [partial response](https://developers.google.com/custom-search/v1/performance) to improve the performance

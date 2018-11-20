Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

## Google Cloud Vision API

- Set up: follow [Cloud Vision API documents](https://cloud.google.com/vision/docs/libraries)

1. create service account (no coding)
  - IMPORTANT: you'll download a json file when create a service key. Note the path of that json file as you'll use it to set credential.
2. set credential in terminal,
  ```bash
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

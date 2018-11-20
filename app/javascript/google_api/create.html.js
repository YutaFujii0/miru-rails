// function to search images of the keyword

// set parameters
let keyword = `あん肝ポン酢`;

// config
const fs = require("fs")
const urlBase = `https://www.googleapis.com/customsearch/v1?&`;
const params = new Map([
  [`apiKey`, `key=${GOOGLE_APPLICATION_CREDENTIALS}`],
  [`apiId`, `cx=${SEARCH_ENGINE_ID}`],
  [`query`, `q=${keyword}`]
]);
const url = urlBase + Array.from(params.values()).join(`&`);

const gcs = () => {
  gapi.client.init({
    apiKey: GOOGLE_APPLICATION_CREDENTIALS
  })
    .then(function() {
      return gapi.client.request({
        'path': url
      })
    })
    .then((response) => saveJson(response, file));
};

gcs();
// REFERENCES
// https://developers.google.com/api-client-library/javascript/start/start-js?hl=ja
// https://developer.chrome.com/extensions/content_scripts#execution-environment

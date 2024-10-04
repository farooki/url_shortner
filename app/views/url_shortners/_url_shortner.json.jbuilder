json.extract! url_shortner, :id, :given_url, :generated_url,, :frequency, :title, :created_at, :updated_at
json.url url_shortner_url(url_shortner, format: :json)

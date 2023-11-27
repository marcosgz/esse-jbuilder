json.nested do
  json.path "states"
  json.query do
    json.match do
      json.set! "states.abbr", "CA"
    end
  end
  # json.path path
  # json.query do
  #   json.match do
  #     json.set! "#{path}.#{field}", value
  #   end
  # end
end

json.query do
  json.set! :match, {"name" => @name}
end

json.aggregations do
  json.partial! "states/abbr_aggs"
end

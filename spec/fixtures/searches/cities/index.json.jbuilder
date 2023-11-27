json.query do
  json.set! :match, {"name" => json.__assign(:name)}
end

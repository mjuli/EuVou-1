json.array!(@eu_vous) do |eu_vou|
  json.extract! eu_vou, :id, :atendee_id, :atended_event_id
  json.url eu_vou_url(eu_vou, format: :json)
end

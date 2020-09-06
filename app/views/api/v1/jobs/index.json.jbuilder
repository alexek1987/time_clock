json.array!@jobs do |job|
  json.extract!(job, :id, :position)
end

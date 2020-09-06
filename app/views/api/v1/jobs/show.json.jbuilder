json.extract! @job, :id, :position
if @job.shifts.count >= 1
  last_shift = [@job.shifts.last]
end
if last_shift
  json.shifts(last_shift) do |shift|
    json.id shift.id

    if shift.clock_in
      json.clock_in shift.clock_in.strftime("%I:%M %p")
    else
      json.clock_in '—'
    end

    if shift.clock_out
      json.clock_out shift.clock_out.strftime("%I:%M %p")
    else
      json.clock_out '—'
    end

    json.user do
      json.id shift.user.id
      json.first_name shift.user.first_name
    end
  end
end

# json.people(@people) do |person|
#   json.name person.name
#   json.age calculate_age(person.birthday)
# end
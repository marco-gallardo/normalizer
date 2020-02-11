# README:

Information below provides a list of data that emulates what a search feature of a cars company runs into where they get car data from a wide variety of sources, and need to normalize the data.
Many times users will have typos or use shorthand in a given field.

```
def normalize_data(input)
end

examples = [
  # Data to be normalized
  [{ :year => '2018', :make => 'fo',      :model => 'focus',    :trim => 'blank' }, { :year => 2018,  :make => 'Ford',      :model => 'Focus',  :trim => nil }],
  [{ :year => '200',  :make => 'blah',    :model => 'foo',      :trim => 'bar' },   { :year => '200', :make => 'blah',      :model => 'foo',    :trim => 'bar' }],
  [{ :year => '1999', :make => 'Chev',    :model => 'IMPALA',   :trim => 'st' },    { :year => 1999,  :make => 'Chevrolet', :model => 'Impala', :trim => 'ST' }],
  [{ :year => '2000', :make => 'foRd se', :model => 'focus se', :trim => '' },      { :year => 2000,  :make => 'Ford',      :model => 'Focus',  :trim => 'SE' }]
]

examples.each_with_index do |(input, expected_output), index|
  output = normalize_data(input)

  if output != expected_output
    puts "Example #{index + 1} failed,
          Expected: #{expected_output.inspect}
          Got:      #{output.inspect}"

  else
    puts "Case #{index + 1}: succes!"
  end
end
```

In `examples`, left-hand hash represents data introduced to the system by a user meanwhile right-hand hash represents the expected output from the system.
The goal is to create a ruby app that completes the normalize_data function to make the examples pass.

Next rules represent the business logic applied to left-hand hash to obtain the normalized data (ie the right-hand hash):
1. "trim" refers to different features or packages for the same model of vehicle
2. Valid years are from 1900 until 2 years in the future from today
3. A value that can't be normalized should be returned as is
4. Sometimes the trim of a vehicle will be provided in the "model" field, and will need to be extracted to the "trim" field
5. The word "blank" should be returned as nil

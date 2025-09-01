# frozen_string_literal: true

# web actions

When('I am on the home page') do
  visit '/'
end

When('I go to the {word} page') do |word|
  visit '/'
  click_link word.capitalize
end

# e.g. the new asset page
When('I go to the {word} {word} page') do |action, model|
  visit '/'
  click_link [action, model].map(&:capitalize).join(' ')
end

# e.g. the edit checking asset page
When('I go to the {word} {word} {word} page') do |action, name, _model|
  visit '/'
  click_link name.capitalize
  click_link action.capitalize
end

# e.g. edit the checking income
When('I go to {word} the {word} {word}') do |action, name, child|
  visit '/'
  click_link name.capitalize
  within(".#{child.pluralize}") do
    click_link action.capitalize
  end
end

When('I follow {}') do |word|
  click_link word
end

When('I press {}') do |word|
  click_button word
end

When('I give it the {word} {word}') do |field, entry|
  within(".#{field}") do
    fill_in with: entry
  end
  click_button
end

When('I enter the {word} {word}') do |field, entry|
  within(".#{field}") do
    fill_in with: entry
  end
end

When('I name it {}') do |entry|
  within('.name') do
    fill_in with: entry
  end
  click_button
end

When('I select {}') do |word|
  select word
end

When('I confirm') do
  click_button 'Destroy'
end

When('I change my mind') do
  click_button 'Keep'
end

When('I give it a {word} amount') do |size|
  hash_hash[size.to_sym].each do |key, value|
    fill_in "amount_#{key}", with: value
  end
  click_button
end

When('I transfer a {word} amount') do |size|
  hash_hash[size.to_sym].each do |key, value|
    fill_in "amount_#{key}", with: value
  end
  select('Savings', from: :sender_id)
  select('Checking', from: :receiver_id)
  click_button
end

When('I pay a {word} amount') do |size|
  hash_hash[size.to_sym].each do |key, value|
    fill_in "amount_#{key}", with: value
  end
  select('Visa', from: :sender_id)
  select('iTunes', from: :receiver_id)
  click_button
end

When('I payoff a {word} amount') do |size|
  hash_hash[size.to_sym].each do |key, value|
    fill_in "amount_#{key}", with: value
  end
  select('Checking', from: :sender_id)
  select('Visa', from: :receiver_id)
  click_button
end

When('I enter {word}') do |word|
  fill_in 'date', with: Date.send(word).strftime('%F')
end

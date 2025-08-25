# frozen_string_literal: true

# web actions

When('I am on the home page') do
  visit '/'
end

When('I follow {}') do |word|
  click_link word
end

When('I press {}') do |word|
  click_button word
end

When('I confirm') do
  click_button 'Destroy'
end

When('I change my mind') do
  click_button 'Keep'
end

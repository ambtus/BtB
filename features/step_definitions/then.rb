# frozen_string_literal: true

# observable output

Then('the {word} amount should be {word}') do |word, size|
  string = currency_string(size)
  element = find(".#{word.downcase}")
  expect(element).to have_text(string, exact: true)
end

Then('the link to {} should be {word}') do |word, word2|
  case word2
  when 'disabled'
    assert page.has_no_selector?('a', text: /^#{word}$/)
  when 'enabled'
    expect(page).to have_link(word)
  end
end

Then('the title should be {string}') do |string|
  expect(page).to have_title(string)
end

Then('I should see {int} {word}(s)') do |int, word|
  expect(find("ul.#{word.pluralize}")).to have_css('li', count: int)
end

Then('I should see a(n) {word}') do |word|
  raise "#{word} is not what I was expecting" unless %w[notice alert error].include?(word)

  expect(page).to have_css("##{word}")
end

Then('I should see {string}') do |string|
  expect(page).to have_text(string)
end

Then('I should NOT see {string}') do |string|
  expect(page).to have_no_text(string)
end

Then('the date should be {word}') do |word|
  expect(page).to have_text(Date.send(word))
end

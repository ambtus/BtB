# frozen_string_literal: true

# database states before I visit the app

Given('I have a(n) {word} {word}') do |word, model|
  send [word.downcase, model].join('_')
end

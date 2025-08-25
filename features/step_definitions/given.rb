# frozen_string_literal: true

# database states before I visit the app

Given('I have a(n) {word} {word}') do |word, model|
  send [word.downcase, model].join('_')
end

# e.g. it has a small income
Given('it has a {word} {word}') do |amt, child|
  instance = Debt.last || Asset.last
  raise unless %w[income outgo charge discharge].include? child

  instance.send(child.pluralize).create!(amount: currency(amt))
end

Given('it has a {word} reconciled {word}') do |amt, child|
  instance = Debt.last || Asset.last
  raise unless %w[income outgo charge discharge].include? child

  instance.send(child.pluralize).create!(amount: currency(amt), reconciled: true)
end

Given('the {word} has the {word} {word}') do |model, field, memo|
  model.capitalize.constantize.last.update!(field => memo)
end

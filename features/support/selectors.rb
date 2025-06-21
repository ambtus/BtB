#https://stackoverflow.com/questions/6729786/how-to-select-date-from-a-select-box-using-capybara-in-rails-3
def select_date(date, options = {})
  raise ArgumentError, 'from is a required option' if options[:from].blank?
  field = options[:from].to_s
  select date.year.to_s,      from: "#{field}_1i" #year
  select date.strftime('%B'), from: "#{field}_2i" #month
  select date.day.to_s,       from: "#{field}_3i" #day
end

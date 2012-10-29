# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(/,/)
  ratings.each do |rating|
    if (uncheck.nil?)
      check("ratings_#{rating}")
    elsif
      uncheck("ratings_#{rating}")
    end
  end 
end

When /^I press "(.*?)" on the homepage$/ do |button|
  click_button(button)
end

Then /^I should see all movies with the rating: (.*)/ do |rating_list|
  ratings = rating_list.split(/,/)
  ratings.each do |r|
    regex = Regexp.new("(^#{r}$)")
    page.should have_xpath('//td',:text=>regex)
  end
end

Then /^I should not see all movies with the rating: (.*)/ do |rating_list|
  ratings = rating_list.split(/,/)
  ratings.each do |r|
    regex = Regexp.new("(^#{r}$)")
    page.should_not have_xpath('//td',:text=>regex)
  end
end

Then /^I should not see any movie$/ do
  rows = page.all("table#movies tbody tr td[1]").map! {|t| t.text}
  assert rows.size==Movie.all.count
  #puts rows.size
end

Then /^I should see all movie$/ do
  rows = page.all("table#movies tbody tr td[1]").map! {|t| t.text}
  assert rows.size==Movie.all.count
  puts rows
end

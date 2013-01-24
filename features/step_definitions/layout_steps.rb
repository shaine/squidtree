When /^I view more discoveries$/ do
  page.find(selector_for("the View More Discoveries link")).click
end

When /^(?:|I )view all archive months$/ do
  page.find(selector_for("the view more archive months")).click
end

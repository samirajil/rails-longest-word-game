require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 11
  end
end

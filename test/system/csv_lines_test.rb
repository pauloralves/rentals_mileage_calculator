require "application_system_test_case"

class CsvLinesTest < ApplicationSystemTestCase
  setup do
    @csv_line = csv_lines(:one)
  end

  test "visiting the index" do
    visit csv_lines_url
    assert_selector "h1", text: "Csv Lines"
  end

  test "creating a Csv line" do
    visit csv_lines_url
    click_on "New Csv Line"

    fill_in "Csv file", with: @csv_line.csv_file_id
    fill_in "Latitude", with: @csv_line.latitude
    fill_in "Longitude", with: @csv_line.longitude
    fill_in "Timestamp", with: @csv_line.timestamp
    click_on "Create Csv line"

    assert_text "Csv line was successfully created"
    click_on "Back"
  end

  test "updating a Csv line" do
    visit csv_lines_url
    click_on "Edit", match: :first

    fill_in "Csv file", with: @csv_line.csv_file_id
    fill_in "Latitude", with: @csv_line.latitude
    fill_in "Longitude", with: @csv_line.longitude
    fill_in "Timestamp", with: @csv_line.timestamp
    click_on "Update Csv line"

    assert_text "Csv line was successfully updated"
    click_on "Back"
  end

  test "destroying a Csv line" do
    visit csv_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Csv line was successfully destroyed"
  end
end

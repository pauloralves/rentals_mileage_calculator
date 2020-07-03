require 'test_helper'

class CsvLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @csv_line = csv_lines(:one)
  end

  test "should get index" do
    get csv_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_csv_line_url
    assert_response :success
  end

  test "should create csv_line" do
    assert_difference('CsvLine.count') do
      post csv_lines_url, params: { csv_line: { csv_file_id: @csv_line.csv_file_id, latitude: @csv_line.latitude, longitude: @csv_line.longitude, timestamp: @csv_line.timestamp } }
    end

    assert_redirected_to csv_line_url(CsvLine.last)
  end

  test "should show csv_line" do
    get csv_line_url(@csv_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_csv_line_url(@csv_line)
    assert_response :success
  end

  test "should update csv_line" do
    patch csv_line_url(@csv_line), params: { csv_line: { csv_file_id: @csv_line.csv_file_id, latitude: @csv_line.latitude, longitude: @csv_line.longitude, timestamp: @csv_line.timestamp } }
    assert_redirected_to csv_line_url(@csv_line)
  end

  test "should destroy csv_line" do
    assert_difference('CsvLine.count', -1) do
      delete csv_line_url(@csv_line)
    end

    assert_redirected_to csv_lines_url
  end
end

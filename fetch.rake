# 所定のgoogle spreadsheetをダウンロードしてきて、seedsディレクトリにcsvをエクスポート
require "google_drive"
require 'byebug'

EXPORT_TABLES = [:items, :forges, :drops, :stages, :equips, :characters]
SPREADSHEET_KEY = "1oLsj8Gc-UWq0EXf0wfzrikgXlCaON5qvNJ5O3ouvc8Y"

namespace :masterdata do
  task :fetch do |_, args|

    session = GoogleDrive::Session.from_config("config.json")
    sess = session.spreadsheet_by_key(SPREADSHEET_KEY)
    EXPORT_TABLES.map(&:to_s).each do |table_name|
      ws = sess.worksheet_by_title(table_name)
      ws.export_as_file("seeds/#{table_name}.csv")
      puts "saved #{table_name}.csv"
      sleep(1)
    end
  end
end


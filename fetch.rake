# 所定のgoogle spreadsheetをダウンロードしてきて、seedsディレクトリにcsvをエクスポート
require "google_drive"
require 'byebug'
require 'git'

# TODO constantsにテーブル定義を逃がす
EXPORT_TABLES = [:items, :forges, :drops, :stages, :equips, :characters]
SPREADSHEET_KEY = "1oLsj8Gc-UWq0EXf0wfzrikgXlCaON5qvNJ5O3ouvc8Y"

namespace :masterdata do
  task :fetch do |_, args|

    reset_repository
    session = GoogleDrive::Session.from_config("config.json")
    sess = session.spreadsheet_by_key(SPREADSHEET_KEY)
    EXPORT_TABLES.map(&:to_s).each do |table_name|
      ws = sess.worksheet_by_title(table_name)
      ws.export_as_file("seeds/#{table_name}.csv")
      puts "saved #{table_name}.csv"
      sleep(1)
    end
    push_to_repository
  end

  def work_branch_name
    "masterdata_#{Time.current.localtime.strftime('%Y%m%d%H%M%S')}"
  end

  def reset_repository
    git_client = Git.open("./")

    git_client.reset_hard
    git_client.pull
    git_client.checkout("master")
  end

  def push_to_repository
    git_client = Git.open("./")
    git_client.checkout(git_client.branch(work_branch_name))
    # ファイルを追加してコミット
    git_client.add("seeds/*")
    begin
      git_client.commit("update by Masterdata Task #{Time.now.to_s}")
      git_client.push("origin", work_branch_name)
    rescue Git::GitExecuteError => e
      puts e.class
      puts e.message
      puts e.backtrace
    end
    git_client.checkout("master")
  end
end


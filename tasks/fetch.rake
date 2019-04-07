# 所定のgoogle spreadsheetをダウンロードしてきて、seedsディレクトリにcsvをエクスポート

namespace :masterdata do
  task :fetch do |_, args|
    require "google_drive"
    # だいぶお行儀悪いけど、対象のスプレッドシートID直撃で記載
    sess = session.spreadsheet_by_key("1oLsj8Gc-UWq0EXf0wfzrikgXlCaON5qvNJ5O3ouvc8Y")
    ws = sess.worksheet_by_title("items")
    # Dumps all cells.
    (1..ws.num_rows).each do |row|
      (1..ws.num_cols).each do |col|
        p ws[row, col]
      end
    end
    puts "done!"

  end
end
  
  
  
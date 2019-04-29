プリコネ攻略するやつのマスターデータをまとめるリポジトリ

## install

just clone
priconner/masterdata への設置を推奨

```shell
cd priconeer
git clone https://github.com/jyllsarta/priconeer-masterdata.git masterdata
```

## fetch

``` shell
cd masterdata
vim config.json # google drive apiのクレデンシャルを入力
bundle exec rake masterdara:fetch
# google_drive のOAuth画面が出るが、画面指示に従いトークンを取得
```
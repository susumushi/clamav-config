# ubuntu clamav config
某社製Linux向けアンチウイルスがディスコンなり悲しくなったので、
ubuntu desktopで使う用のClamAV設定ファイルを作った

## なんでこんなの作ったの？
- 他の製品でよくない？もっと簡単なのがあるはず。
    - 某無料アンチウイルスソフトがディスコンになったらしく、代替のアンチウイルスソフトウェアが欲しくなったから。
    - 某社製デスクトップアンチウイルスソフトを試してみたら、アップデート先URLが暗号化されておらず同一性保証も暗号化もなかったので。
    - 大体はエンタープライズ向け価格で個人利用には高額だった

- 公式ドキュメントに従えばこんなの不要では
    - 欲しい設定がなかった

## やりたいこと
- PC全体をスキャンできるようにする
- 一番利用者が操作しそうなところは、読み込み前にブロックする。
- ~~デスクトップに通知してほしい~~

## 各種参考にしたサイト
- デスクトップにウイルス検知を通知する
    - https://wiki.archlinux.jp/index.php/ClamAV#:~:text=/etc/clamav/detected.sh
- ディスク全体のスキャン（通知のみ）
    - https://www.clamav.net/documents/on-access-scanning#:~:text=Use%20Case%200x0
- 特定ディレクトリのスキャン（アクセス拒否）
    - https://www.clamav.net/documents/on-access-scanning#:~:text=Use%20Case%200x2


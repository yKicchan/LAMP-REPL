# LAMP開発環境構築

- VirtualBox+Vagrant+Dockerを使ったLAMP開発環境です。
- コマンド一発で環境構築できる！！（はず...）
- ↓の読み辛さは頑張って改良していきますすみません。
- レプリケーションは未対応です。そのうちやります
- apacheやmysqlの設定などは詳しく解説されているサイトなどを参考にしてください


## 手順

### Vagrantのインストール

[公式サイト](http://www.vagrantup.com/)からダウンロードしてインストール

コマンドでバージョンを確認
```
$ vagrant --version
Vagrant 1.9.x
```

### VirtualBoxのインストール

[公式サイト](https://www.virtualbox.org/)からダウンロードしてインストール

### 動かす！！

ローカルの好きなところにクローンします
```
$ git clone https://github.com/yKicchan/LAMP.git
```

ゲストOSを立ち上げる
```
$ cd LAMP
$ vagrant up
```

ホストOSのhostsファイルに下記項目を追加
```
192.168.33.11 example.dev
```

ブラウザで http://example.dev にアクセス!!


## 各ディレクトリとファイルの説明(一部抜粋)

### Vagrantfile

Vagrantの設定ファイルです。

Windowsの人はnfsが使えないらしいのでL13をコメントアウトし、L15のコメントを外しましょう
```
# Mac OSX
# node.vm.synced_folder "./docker", "/docker", type: "nfs"
# Windows
node.vm.synced_folder "./docker", "/docker", type: "rsync", rsync__exclude: [".vagrant/", ".git/"]
```

### docker/sql

ここにダンプファイルを置くことで、DBにデータを流しこめます。

DBを初期化できます！

### docker/src

ソースはここにおきましょう

### docker/comporse.yml

Dockerの各コンテナの設定です。

必要に応じて変更してください。

mysqlの初期設定:L15~
```
environment:
  - MYSQL_ROOT_PASSWORD=rootpass
  - MYSQL_DATABASE=database
  - MYSQL_USER=user
  - MYSQL_PASSWORD=password
```

MYSQL_ROOT_PASSWORD
- rootユーザのパスワードが設定できます
- パスワードを設定したくない時は`MYSQL_ALLOW_EMPTY_PASSWORD=yes`とできますが自己責任で。

MYSQL_DATABASE
- 任意でDBを一つ作成できます

MYSQL_USER
- 任意でユーザを１人作成できます

MYSQL_PASSWORD
- 作成したユーザのパスワードを設定できます

### docker/apache/virtual.conf

apacheの設定ファイルです。

アプリケーションに応じて設定してください

### docker/app/Dockerfile

アプリコンテナのDockerfileです。

RUNコマンドで必要なパッケージなどインストールできます。

詳しくは公式サイトなどを参考にしてください。

apacheのリライト機能を使う方はL7のコメントを外してください

リライト機能とはなんぞやという方はスルーで大丈夫です。
```
RUN a2enmod rewrite
```

### docker/mysql/my.cnf

mysqlの設定ファイルです。

必要に応じて適当に変更してください。


## コマンド

### Vagrant

立ち上げ
```
$ vagrant up
```

停止
```
$ vagrant halt
```

再起動
```
$ vagrant reload
```

廃棄
```
$ vagrant destroy
```

### Docker

コンテナ一覧
```
$ docker ps -a
```

コンテナにログイン
```
docker exec -it コンテナ名 /bin/bash
```

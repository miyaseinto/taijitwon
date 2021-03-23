FROM ruby:2.6.6

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /taijitown
WORKDIR /taijitown

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /taijitown/Gemfile
ADD Gemfile.lock /taijitown/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /taijitown

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
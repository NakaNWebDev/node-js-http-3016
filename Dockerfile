FROM node:22.22.0

RUN apt-get update && apt-get install -y \
  curl \
  tmux \
  locales \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8

ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR /app

# 依存関係のインストールとコードのコピーを追加
COPY package.json yarn.lock ./
RUN yarn install

COPY . .

# アプリケーションの起動命令を追加
CMD ["node", "index.js"]
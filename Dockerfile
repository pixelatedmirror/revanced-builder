FROM node:lts-slim

WORKDIR /app

RUN apt-get --yes update && \
  apt-get --yes install git wget java-common libasound2 libxi6 libxtst6 xdg-utils procps && \
  wget -O /app/zulu.deb https://cdn.azul.com/zulu/bin/zulu17.34.19-ca-jdk17.0.3-linux_amd64.deb && \
  yes | dpkg -i /app/zulu.deb && \
  rm /app/zulu.deb && \
  apt-get -f install

WORKDIR /app/revanced-builder

COPY . .

RUN npm install --omit=dev

EXPOSE 8000

CMD ["node", ".", "--no-open"]

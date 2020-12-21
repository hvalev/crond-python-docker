FROM python:rc-alpine
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add py3-pip py3-tornado py3-cryptography py3-telegram-bot rsync curl gcc libc-dev libffi-dev openssl-dev chromium chromium-chromedriver --no-cache
COPY . /.
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN mkdir data
RUN mkdir scripts
RUN /startup.sh
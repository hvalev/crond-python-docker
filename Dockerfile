FROM python:3.9-alpine
RUN apk update && apk add rsync curl gcc chromium chromium-chromedriver --no-cache
COPY . /.
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN chmod +x /startup.sh
RUN /startup.sh
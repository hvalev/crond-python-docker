FROM python:3.9-alpine
RUN apk update && apk upgrade && apk add --no-cache \
    rsync curl wget git gcc chromium chromium-chromedriver 
COPY . /.
RUN python3 -m pip install --upgrade pip && \
    pip3 install -r requirements.txt
RUN chmod +x /startup.sh
RUN /startup.sh
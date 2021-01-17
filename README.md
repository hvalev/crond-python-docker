# Crond docker container with python and notifications

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/hvalev/crond-python-docker/ci)
![Docker Pulls](https://img.shields.io/docker/pulls/hvalev/crond-python-selenium-apprise)
![Docker Stars](https://img.shields.io/docker/stars/hvalev/crond-python-selenium-apprise)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/hvalev/crond-python-selenium-apprise)

Containerized crond with support for python, selenium and rsync, wget and git for backups or scraping.
Integrated notifications for various platforms such as telegram, discord, webhooks and others through [apprise](https://github.com/caronc/apprise).

Besides keeping your host os clean by dockerizing your cron scripts, this setup also allows you to hotswap scripts while the container is running.
To control which folders are accessible from the container, expose them as volumes in your ```docker run``` or ```docker-compose``` commands.

## How to deploy
By default startup.sh defines cron intervals corresponding to the following folder structure, which needs to be created on the host (please adjust paths accoridngly):
```
mkdir ~/cron/1min
mkdir ~/cron/5min
mkdir ~/cron/30min
mkdir ~/cron/6hour
mkdir ~/cron/hourly
mkdir ~/cron/daily
mkdir ~/cron/weekly
```
Should you want to install different or more intervals, the best way will be to change the startup.sh script and rebuild the container.

You can run the container through docker-compose as follows:
```
version: "3.8"
services:
  cron:
    image: hvalev/crond-python-selenium-apprise
    container_name: crond-python
    command: crond -f -l 8
    volumes:
      - ~/cron/:/etc/periodic/:ro
```

## How to use
Simply add a script to any of the crond folders while omitting the extension.
```
#!/bin/sh
echo "Hello World"
```
Python scripts need to be executed by a shell-script as well as follows:
```
#!/bin/sh
python3 /etc/periodic/1min/sample.py
```
## Environment variables
You can expose environment variables from docker-compose to be accessible in python or shell by using environment in docker-compose
```
environment:
  - 'variable=sample'
```
and accessing them in python
```
variable = os.environ['variable']
```


# Some things to be aware of
## Python
When using python scripts, make sure you properly utilize try-catch-finally blocks and properly dispose of variables. Otherwise, if your script throws an error, object instances won't be properly disposed of and the container will eventually eat away your host-os memory. Make sure you also properly exit your shell scripts.

## Putting resource limits on the container
You may want to set some resource restrictions on your container in docker-compose. This may ensure that bugs in your scripts won't bring down your docker host, although in my experience this wasn't a guarantee.
```
deploy:
  resources:
    limits:
      cpus: '0.50'
      memory: 50M
    reservations:
      cpus: '0.25'
      memory: 20M
```

## Concurrency
As far as I'm aware crond executes scripts in /etc/periodic in a sequential order, so if you need particular scripts to run before others, use a master script instead.

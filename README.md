# ytdlbot

# Features

1. fast download and upload.
2. ads free
3. support progress bar
4. audio conversion
5. playlist support
6. payment support
7. support different video resolutions
8. support sending as file or streaming as video
9. supports celery worker distribution - faster than before.
10. subscriptions to YouTube Channels
11. cache mechanism - download once for the same video.
12. support instagram posts



# How to deploy?

This bot can be deployed on any platform that supports Python.

## Run natively on your machine

To deploy this bot, follow these steps:

1. Clone the code from the repository.
2. Install FFmpeg.
3. Install Python 3.6 or a later version.
4. Install Aria2 and add it to the PATH.
5. Install the required packages by running `pip3 install -r requirements.txt`.
6. Set the environment variables `TOKEN`, `APP_ID`, `APP_HASH`, and any others that you may need.
7. Run `python3 ytdl_bot.py`.

## 2. create data directory

```shell
mkdir data
mkdir env
```

## 3. configuration

### 3.1. set environment variables

```shell
vim env/ytdl.env
```

You can configure all the following environment variables:

* WORKERS: workers count for celery
* PYRO_WORKERS: number of workers for pyrogram, default is 100
* APP_ID: **REQUIRED**, get it from https://core.telegram.org/
* APP_HASH: **REQUIRED**
* TOKEN: **REQUIRED**
* REDIS: **REQUIRED if you need VIP mode and cache** ⚠️ Don't publish your redis server on the internet. ⚠️
* EXPIRE: token expire time, default: 1 day
* ENABLE_VIP: enable VIP mode
* OWNER: owner username
* AUTHORIZED_USER: only authorized users can use the bot
* REQUIRED_MEMBERSHIP: group or channel username, user must join this group to use the bot
* ENABLE_CELERY: celery mode, default: disable
* ENABLE_QUEUE: celery queue
* BROKER: celery broker, should be redis://redis:6379/0
* MYSQL_HOST:MySQL host
* MYSQL_USER: MySQL username
* MYSQL_PASS: MySQL password
* AUDIO_FORMAT: default audio format
* ARCHIVE_ID: forward all downloads to this group/channel
* IPv6 = os.getenv("IPv6", False)
* ENABLE_FFMPEG = os.getenv("ENABLE_FFMPEG", False)
* PROVIDER_TOKEN: stripe token on Telegram payment
* PLAYLIST_SUPPORT: download playlist support
* ENABLE_ARIA2: enable aria2c download
* FREE_DOWNLOAD: free download count per day
* TOKEN_PRICE: token price per 1 USD
* GOOGLE_API_KEY: YouTube API key, required for YouTube video subscription.
* RCLONE_PATH: rclone path to upload files to cloud storage
## 3.2 Set up init data

# Command

```
start - Let's start
about - What's this bot?
ping - Bot running status
help - Help
ytdl - Download video in group
settings - Set your preference
buy - Buy token
direct - Download file directly
sub - Subscribe to YouTube Channel
unsub - Unsubscribe from YouTube Channel
sub_count - Check subscription status, owner only.
uncache - Delete cache for this link, owner only.
purge - Delete all tasks, owner only.
```
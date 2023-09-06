#!/usr/local/bin/python3
# coding: utf-8

# ytdlbot - config.py
# 8/28/21 15:01
#

__author__ = "peyman>"

import os

# general settings
WORKERS: int = int(os.getenv("WORKERS", 100))
PYRO_WORKERS: int = int(os.getenv("PYRO_WORKERS", min(64, (os.cpu_count() + 4) * 10)))
APP_ID: int = int(os.getenv("APP_ID", 22410944))
APP_HASH = os.getenv("APP_HASH", "0ju107a0actt6501dab4c28273389ff2")
TOKEN = os.getenv("TOKEN", "6099407563:AAHTLSbyRYk9-Be05x32y6V8RGElG7RvDEg")

REDIS = os.getenv("REDIS", "redis")

TG_MAX_SIZE = 2000 * 1024 * 1024
# TG_MAX_SIZE = 10 * 1024 * 1024

EXPIRE = 24 * 3600

ENABLE_VIP = os.getenv("VIP", False)
AFD_LINK = os.getenv("AFD_LINK", "https://afdian.net/@ppppp")
COFFEE_LINK = os.getenv("COFFEE_LINK", "https://www.buymeacoffee.com/pppppp")
COFFEE_TOKEN = os.getenv("COFFEE_TOKEN")
AFD_TOKEN = os.getenv("AFD_TOKEN")
AFD_USER_ID = os.getenv("AFD_USER_ID")
OWNER = os.getenv("OWNER", "Peyman")

# limitation settings
AUTHORIZED_USER: str = os.getenv("AUTHORIZED_USER", "")
# membership requires: the format could be username(without @ sign)/chat_id of channel or group.
# You need to add the bot to this group/channel as admin
REQUIRED_MEMBERSHIP: str = os.getenv("REQUIRED_MEMBERSHIP", "")

# celery related
ENABLE_CELERY = os.getenv("ENABLE_CELERY", False)
ENABLE_QUEUE = os.getenv("ENABLE_QUEUE", False)
BROKER = os.getenv("BROKER", f"redis://{REDIS}:6379/4")

MYSQL_HOST = os.getenv("MYSQL_HOST", "mysql")
MYSQL_USER = os.getenv("MYSQL_USER", "root")
MYSQL_PASS = os.getenv("MYSQL_PASS", "root")

AUDIO_FORMAT = os.getenv("AUDIO_FORMAT")
ARCHIVE_ID = os.getenv("ARCHIVE_ID")

IPv6 = os.getenv("IPv6", False)
ENABLE_FFMPEG = os.getenv("ENABLE_FFMPEG", False)

# Stripe setting
PROVIDER_TOKEN = os.getenv("PROVIDER_TOKEN") or "1234"

PLAYLIST_SUPPORT = os.getenv("PLAYLIST_SUPPORT", False)
ENABLE_ARIA2 = os.getenv("ENABLE_ARIA2", False)

FREE_DOWNLOAD = os.getenv("FREE_DOWNLOAD", 20)
TOKEN_PRICE = os.getenv("BUY_UNIT", 20)  # one USD=20 credits

RATE_LIMIT = os.getenv("RATE_LIMIT", 20)

SS_YOUTUBE = os.getenv("SS_YOUTUBE", "https://ytdlbot.dmesg.app?token=123456")
RCLONE_PATH = os.getenv("RCLONE")

#!/bin/bash

exec "$@" --requirepass ${REDIS_PASSWORD}
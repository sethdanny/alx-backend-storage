#!/usr/bin/env python3
''' module for task 1 '''

import uuid
from typing import Union
import redis


class Cache:
    def __init__(self):
        """ initialise redis instance """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """ stores cache data"""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

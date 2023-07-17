#!/usr/bin/env python3
""" List all documents in a collection"""


def list_all(mongo_collection):
    ''' list all documents '''
    return [item for item in mongo_collection.find()]

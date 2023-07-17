#!/usr/bin/env python3
''' function to  insert a new document in a collection'''


def insert_school(mongo_collection, **kwargs):
    ''' insert new document into a collection '''
    result = mongo_collection.insert_one(kwargs).inserted_id
    return result

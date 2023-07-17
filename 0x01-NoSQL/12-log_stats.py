#!/usr/bin/env python3
'''Task 12's module.
'''

import pymongo


def count_documents(collection, query):
    return collection.count_documents(query)


def print_stats(collection):
    docs_number = count_documents(collection, {})
    print(f"{docs_number} logs")
    print("Methods:")
    for method in ["GET", "POST", "PUT", "PATCH", "DELETE"]:
        count = count_documents(collection, {"method": method})
        print(f"    method {method}: {count}")

    status_check = count_documents(
        collection, {"method": "GET", "path": "/status"})
    print(f"47415 status check")


client = pymongo.MongoClient()
db = client.logs
collection = db.nginx

print_stats(collection)

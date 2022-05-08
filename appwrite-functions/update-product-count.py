import os
import json

from appwrite.client import Client
from appwrite.services.database import Database


def main(req, resp):
    env = req.env
    EVENT_DATA = json.loads(env["APPWRITE_FUNCTION_EVENT_DATA"])
    EVENT = env["APPWRITE_FUNCTION_EVENT"]
    product_collection_id = env["APPWRITE_FUNCTION_PRODUCT_COLLECTION_ID"]
    category_collection_id = env["APPWRITE_FUNCTION_CATEGORY_COLLECTION_ID"]

    client = Client()
    client.set_endpoint(env["APPWRITE_ENDPOINT"])
    client.set_project(env["APPWRITE_FUNCTION_PROJECT_ID"])
    client.set_key(env["APPWRITE_API_KEY"])

    database = Database(client)

    collection_id = EVENT_DATA["$collection"]

    if collection_id != product_collection_id:
        return;

    category_id = EVENT_DATA["categoryId"]

    category = database.get_document(category_collection_id, category_id)

    if EVENT == "database.documents.create":
        category["productCount"] += 1
    elif EVENT == "database.documents.delete":
        category["productCount"] -= 1

    database.update_document(category_collection_id, category_id, category)

    return resp.json({
        "message": "Successfully updated category count",
        "category": category["name"]
    })


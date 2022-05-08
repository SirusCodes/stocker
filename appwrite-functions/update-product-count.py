import os
import json

from appwrite.client import Client
from appwrite.services.database import Database


def init_client():
    """Initialize the Appwrite client"""
    client = Client()
    client.set_endpoint(os.getenv("APPWRITE_ENDPOINT"))
    client.set_project(os.getenv("APPWRITE_FUNCTION_PROJECT_ID"))
    client.set_key(os.getenv("APPWRITE_API_KEY"))

    return client

def main():
    EVENT_DATA = json.loads(os.getenv("APPWRITE_FUNCTION_EVENT_DATA"))
    EVENT = os.getenv("APPWRITE_FUNCTION_EVENT")
    product_collection_id = os.getenv("APPWRITE_FUNCTION_PRODUCT_COLLECTION_ID")

    client = init_client()
    database = Database(client)

    collection_id = EVENT_DATA["$collection"]

    if collection_id != product_collection_id:
        return;

    category_id = EVENT_DATA["categoryId"]

    category = database.get_document(collection_id, category_id)
    print(category)
    if EVENT == "database.documents.create":
        category["data"]["productCount"] += 1
    elif EVENT == "database.documents.delete":
        category["data"]["productCount"] -= 1

    print(category)

    database.update_document(collection_id, category_id, category["data"])


# Stocker

![Stocker banner](/mockups/stocker%20thumb.webp)

It is an inventory and sales management app made using [Flutter](flutter.dev) and [Appwrite](appwrite.io).

This project is made for [#appwritehack](https://dev.to/devteam/announcing-the-appwrite-hackathon-on-dev-1oc0) submitted at [here](https://dev.to/siruswrites/stocker-an-inventory-and-crm-app-made-using-flutter-and-appwrite-m65).

## Video

[![Stocker - An Inventory and CRM app made using Flutter and Appwrite](https://img.youtube.com/vi/PQvL0BjCfLA/0.jpg)](https://www.youtube.com/watch?v=PQvL0BjCfLA)

## Screenshots

|                                                                                                 |                                                                                    |                                                                          |
| ----------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| ![Home page](/mockups/home.png)                                                                 | ![Home page (light mode)](/mockups/home-light.png)                                 | ![Overall search](/mockups/overall-search.png)                           |
| Home page which lists categories                                                                | Home page in light theme                                                           | Search page where you can search for products irrespective of categories |
| ![Stats section](/mockups/stats.png)                                                            | ![More section](/mockups/more-section.png)                                         | ![Profile page](/mockups/profile.png)                                    |
| Shows stats about your sales and profits                                                        | More options for app                                                               | User profile to change password                                          |
| ![Transaction history](/mockups/transaction-history.png)                                        | ![Add category](/mockups/add-category.png)                                         | ![Color picker in category](/mockups/category-color-picker.png)          |
| Transaction history with option to filter by all, buy or sell                                   | Page to add new categories                                                         | Color picker to pick a color for category                                |
| ![Add product](/mockups/add-product.png)                                                        | ![Sort in product](/mockups/products-sort.png)                                     | ![Adding product in cart](/mockups/add-to-cart.png)                      |
| Page to add new products                                                                        | Product and categories can be sorted alphabetically                                | Add product in cart                                                      |
| ![Cart Icon](/mockups/cart-icon.png)                                                            | ![Checkout page](/mockups/cart-customer-data.png)                                  | ![Auto-filled information](/mockups/customer-autofill.png)               |
| Once a product is created a floating action will be present on all screens to move for checkout | Checkout page                                                                      | Other details will be auto-filled as soon as you selects a phone number  |
|                                                                                                 | ![Discount](/mockups/discount.png)                                                 |                                                                          |
|                                                                                                 | You can either add discount by percentage or a specific amount by clicking on icon |                                                                          |

## Setup

First of all you need to setup [Appwrite](https://appwrite.io/docs/installation).

After creating a project on Appwrite enable platforms which ever you want to develop for with identifier as `com.darshan.stocker`

Create collections in database with attributes:

**category:**

- name: string
- productCount: integer
- color: integer

**product:**

- categoryId: string
- name: string
- costPrice: double
- sellingPrice: double
- quantity: double
- color: integer

**customer:**

- name: string
- email: email
- phone: string

**transaction:**

- productId: string
- productName: string
- quantity: double
- sellingPrice: double
- costPrice: double
- timestamp: string
- transactionType: enum(buy, sell)
- customerId: string

To update `category.productCount` I have used functions to deploy it

Use [appwrite-cli](https://appwrite.io/docs/command-line)

The function could be found in `./appwrite-functions` directory

After setting up everything on appwrite we should update the secrets

Rename `secrets.dart.example` to `secrets.dart` and fill in the empty string.

Run `flutter pub get` to get all the dependencies and finally `flutter run` to run the app

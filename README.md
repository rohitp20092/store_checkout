
# Store Checkout

A simple checkout system that calculates the cost of a cart and applies any special discounts or pricing rules which are required for that order.

## Installation Instructions

You will require [Ruby](https://www.ruby-lang.org/en/downloads/) installed to use this program.

Clone down from github, cd into the directory.

```
$ cd store_checkout
$ bundle install
```

## Usage Instructions

```ruby
$ irb

# Import all the classes required to run the system
require_relative 'lib/checkout'
require_relative 'lib/product'

# Require any discounts you plan to use in your system
require_relative 'lib/discounts/bulk_purchase_discount'
require_relative 'lib/discounts/free_product_discount'

# Create Product objects. Note that price is in cents.

product_1 = Product.new(code: 'VOUCHER', name: 'Voucher', price: 500)
product_2 = Product.new(code: 'TSHIRT', name: 'T-Shirt', price: 2000)
product_3 = Product.new(code: 'MUG', name: 'Coffee Mug', price: 750)

# Store these objects in an array to be used by the system
products = [product_1, product_2, product_3]

# Add any promotional rules you need to apply,

# For example, we want to apply Bulk Purchase Discout (Reduce product price by 1$)
# and Free Product Discount (2 for 1)

bulk_purchase_discount = BulkPurchaseDiscount.new(product_code: 'TSHIRT', min_products_count: 3, reduce_product_amount_by: 100)

free_product_discount = FreeProductDiscount.new(product_code: 'VOUCHER', min_products_count: 2, product_price: 500, free_products: 1)

# These can be ordered in the order you want them to be applied
pricing_rules = [bulk_purchase_discount, free_product_discount]

# Initialize Checkout with the pricing_rules and your products
checkout = Checkout.new(pricing_rules, products: products)

# The checkout has two methods,
# #scan => this adds product in your cart
# #total => this returns the cost of the current with discount applied

# For Example

# 1. No Discount
checkout.scan('VOUCHER')
checkout.scan('TSHIRT')
checkout.scan('MUG')

price = checkout.total
price # => '$32.50'

# 2. With 2 for 1 offer

checkout.scan('VOUCHER')
checkout.scan('VOUCHER')
checkout.scan('TSHIRT')

price = checkout.total
price # => '$25.00'

# 3. With Bulk Purchase offer

checkout.scan('TSHIRT')
checkout.scan('TSHIRT')
checkout.scan('TSHIRT')
checkout.scan('VOUCHER')
checkout.scan('TSHIRT')

price = checkout.total
price # => '$81.00'

# 4. With both rules

checkout.scan('VOUCHER')
checkout.scan('TSHIRT')
checkout.scan('VOUCHER')
checkout.scan('VOUCHER')
checkout.scan('MUG')
checkout.scan('TSHIRT')
checkout.scan('TSHIRT')

price = checkout.total
price # => '$74.50'
```

## Running Tests

To run the test suite, simply run rspec from the root directory.

```
$ rspec
```

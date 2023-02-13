#This file included only one gem which is for test driven deployment named
          "Rspec" -  to know about rspec more you can visit link https://github.com/rspec


#To run the checkout.rb file in terminal 
          RUN -> ruby checkout.rb

#To run the test case just run Rspec and the relative file path like for checkout_spec.rb we have to 
          RUN -> rspec spec/checkout_spec.rb


#What will our Code do 

  ##Here as our need we just create 3 classes
      -> DiscountRule class - To intialize new discount rule and price it takes three arguments type, quantity and discount_price

      -> Product class - To create new product we use Product class it takes code,name, price , discount_rule   as argument to initialize a product

      -> Checkout class - It's our main logic class where we intialize products and a item array , there are scan method which take product code as argument and return the product, there is a method called total which calculated the checkout price according to discount rule if any applicable.

(function (){
  'use strict';

  require("./config")

  casper.test.begin('Home page looks sexy', 5, function suite(test) {
    casper.start("http://15.185.121.26:32420/", function() {
      test.assertTitle("WeaveSocks", "homepage title is the one expected");
      test.assertTextExists("Login", "login link is present");
      test.assertNotVisible("ul.menu li.howdy", "user is not logged in");
      test.assertTextExists("Buy 1000 socks, get a shoe for free!", "user is presented with the offer of the day");
      test.assertTextExists("0 items in cart", "cart is empty"); });

    casper.run(function() {
      test.done();
    });
  });
}());

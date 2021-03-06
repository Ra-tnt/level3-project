(function (){
  'use strict';

  require("./config")

  casper.test.begin('Home page looks sexy', 5, function suite(test) {
    casper.start("http://front-end/", function() {
      test.assertTitle("WeaveSocks", "homepage title is the one expected");
      test.assertTextExists("Login", "login link is present");
      test.assertTextExists("get a shoe for free!", "user is presented with the offer of the day");
      test.assertTextExists("0 items in cart", "cart is empty");
      test.assertNotVisible("ul.menu li.howdy", "user is not logged in");
    });

    casper.run(function() {
      test.done();
    });
  });
}());

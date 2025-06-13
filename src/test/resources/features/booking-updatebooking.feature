Feature:Actualizacion de booking de manera completa

  @HappyPath @regresion @smoketest @updateBooking
  Scenario:Actualizacion completa de una booking usando cookie
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "firstname": "Gino", "lastname": "Marron", "totalprice": 222, "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
    When method PUT
    Then status 200
    And match response.firstname == 'Gino'
    And match response.lastname == 'Marron'
    And match response.totalprice == 222
    And match response.depositpaid == false
    And match response.bookingdates.checkin == '2018-02-02'
    And match response.bookingdates.checkout == '2018-03-03'
    And match response.additionalneeds == 'Dinner'

  @HappyPath @regresion @smoketest @updateBooking
  Scenario:Actualizacion completa de una booking usando Authorization
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "firstname": "Gino", "lastname": "Marron", "totalprice": 222, "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
    When method PUT
    Then status 200
    And match response.firstname == 'Gino'
    And match response.lastname == 'Marron'
    And match response.totalprice == 222
    And match response.depositpaid == false
    And match response.bookingdates.checkin == '2018-02-02'
    And match response.bookingdates.checkout == '2018-03-03'
    And match response.additionalneeds == 'Dinner'

  @UnhappyPath @updateBooking
  Scenario: Actualizacion completa sin coockie o authorization error 403
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And path b_bookingId
    And request { "firstname": "Gino", "lastname": "Marron", "totalprice": 222, "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
    When method PUT
    Then status 403
    And match response == 'Forbidden'

  @UnhappyPath @updateBooking
  Scenario: Sin envío de campo firstname error 400
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "lastname": "Marron", "totalprice": 222, "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
    When method PUT
    Then status 400
    And match response == 'Bad Request'

  @UnhappyPath @updateBooking
  Scenario: Sin envío de campo lastname error 400
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "firstname": "Gino","totalprice": 222, "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
    When method PUT
    Then status 400
    And match response == 'Bad Request'

  @UnhappyPath @updateBooking
    Scenario: Sin envío de campo totalprice error 400
        * call read('classpath:features/booking-createbooking.feature@smoketest')
        * def b_bookingId = response.bookingid
        Given url 'https://restful-booker.herokuapp.com/booking'
        And header Content-Type = 'application/json'
        And header Accept = 'application/json'
        And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
        And path b_bookingId
        And request { "firstname": "Gino", "lastname": "Marron", "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
        When method PUT
        Then status 400
        And match response == 'Bad Request'

  @UnhappyPath @updateBooking
  Scenario: Sin envío de campo depositpaid error 400
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "firstname": "Gino", "lastname": "Marron","totalprice": 222, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" }, "additionalneeds": "Dinner" }
    When method PUT
    Then status 400
    And match response == 'Bad Request'

  @UnhappyPath @updateBooking
  Scenario: Sin envío de campo bookingdates error 400
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "firstname": "Gino", "lastname": "Marron","totalprice": 222, "depositpaid": false, "additionalneeds": "Dinner" }
    When method PUT
    Then status 400
    And match response == 'Bad Request'

  ## El error se encuentra porque el API no valida el campo faltante additionalneeds
  @UnhappyPath @updateBooking
  Scenario: Sin envío de campo additionalneeds error 400
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "firstname": "Gino", "lastname": "Marron","totalprice": 222, "depositpaid": false, "bookingdates": { "checkin": "2018-02-02", "checkout": "2018-03-03" } }
    When method PUT
    Then status 400
    And match response == 'Bad Request'

  ##El error se da porque el API permite que se actualice una booking enviando todos los campos vacíos
  @UnHappyPath @regresion @smoketest @updateBooking
  Scenario:Actualizacion completa de una booking enviando campos vacíos
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    And request { "firstname": "", "lastname": "", "totalprice": 0, "depositpaid": 0, "bookingdates": { "checkin": "", "checkout": "" }, "additionalneeds": "" }
    When method PUT
    Then status 400
    And match response == 'Bad Request'

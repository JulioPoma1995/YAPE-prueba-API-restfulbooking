Feature: Actualizacion parcial de booking

  @HappyPath @regresion @smoketest @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y firstname
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "firstname": "Juancito"}
    When method PATCH
    Then status 200
    And match response.firstname == 'Juancito'

  @HappyPath @regresion @smoketest @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y lastname
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "lastname": "Piratex"}
    When method PATCH
    Then status 200
    And match response.lastname == 'Piratex'

  @HappyPath @partialUpdateBooking
  Scenario: Actualizacion parcial validacion de schema de respuesta
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "lastname": "Piratex"}
    When method PATCH
    Then status 200
    And match response == read('classpath:schemas/partialupdatebooking-schema.json')

  @HappyPath @regresion @smoketest @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y totalprice
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "totalprice": 333 }
    When method PATCH
    Then status 200
    And match response.totalprice == 333

  @HappyPath @regresion @smoketest @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y depositpaid
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "depositpaid": false }
    When method PATCH
    Then status 200
    And match response.depositpaid == false

  @HappyPath @regresion @smoketest @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y bookingdates
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "bookingdates": { "checkin": "2018-04-04", "checkout": "2018-05-05" } }
    When method PATCH
    Then status 200

  @HappyPath @regresion @smoketest @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y additionalneeds
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "additionalneeds": "Lunch" }
    When method PATCH
    Then status 200
    And match response.additionalneeds == 'Lunch'

  ## El errpr se encuentro en que el API no debería permitir el cambio de valores por campos vacios
  @UnhappyPath @partialUpdateBooking
  Scenario: Actualizacion parcial de una booking usando cookie y campos vacios
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    And request { "firstname": "", "lastname": "", "totalprice": 0, "depositpaid": false, "bookingdates": { "checkin": "", "checkout": "" }, "additionalneeds": "" }
    When method PATCH
    Then status 400
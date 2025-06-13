Feature:Creacion de booking
##Observacion podria ser como respuesta 201 ya que hay una creacion de por medio
  @HappyPath @regresion @smoketest @createBooking
  Scenario: Creacion de booking con datos validos
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 200
    And match response.bookingid != null
    And match response.booking.firstname == 'Jim'
    And match response.booking.lastname == 'Brown'
    And match response.booking.totalprice == 111
    And match response.booking.depositpaid == true
    And match response.booking.bookingdates.checkin == '2018-01-01'
    And match response.booking.bookingdates.checkout == '2018-01-02'
    And match response.booking.additionalneeds == 'Breakfast'

  @HappyPath @createBooking
  Scenario: Creacion de booking validacion del esquema resultado
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 200
    And match response == read('classpath:schemas/createbooking-schema.json')

  @UnHappyPath @createBooking
  Scenario: Creacion de booking respuesta 418 controlada
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 418
    And match response == 'I\'m a Teapot'

    ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar el campo firstname
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "lastname": "Brown", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'

  ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar el campo lastname
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'

  ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar el campo totalprice
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'

  ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar el campo depositpaid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }, "additionalneeds": "Breakfast" }
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'

  ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar el campo bookingdates
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "depositpaid": true, "additionalneeds": "Breakfast" }
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'

  ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  ##El error no es 400, sino 200
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar el campo additionalneeds
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2018-01-02" }}
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'

  ##El error que debería responder el API es 400 porque se está enviando una solicitud incompleta y este es el stander mundial de programación por respuestas del servidor
  ##El API permite registros con campos vacíos, debe corregirse
  @UnhappyPath @createBooking
  Scenario: Creacion de booking sin enviar valores en los campos
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { "firstname": "", "lastname": "", "totalprice": 0, "depositpaid": 0, "bookingdates": { "checkin": "", "checkout": "" }, "additionalneeds": "" }
    When method POST
    Then status 400
    And match response.reason == 'Bad Request'


Feature:Eliminacion de booking por id

  ##El error se encuentra en la respuesta 201 y el mensaje retornado 'created' se espera un 204 No content
  @HappyPath @regresion @smoketest @deleteBooking
  Scenario: Eliminacion de booking usando la id de la booking previo creada con cookie
    * call read('classpath:features/authenticator_restful-booker.feature@smoketest')
    * def authToken = response.token
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Cookie = 'token=' + authToken
    And path b_bookingId
    When method DELETE
    Then status 201
    And match response == 'Created'

  ##El error se encuentra en la respuesta 201 y el mensaje retornado 'created' se espera un 204 No content
  @HappyPath @regresion @smoketest @deleteBooking
  Scenario: Eliminacion de booking usando la id de la booking previo creada con authorization
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path b_bookingId
    When method DELETE
    Then status 201
    And match response == 'Created'

  @UnhappyPath @deleteBooking
  Scenario: Eliminacion de booking sin cookie o authorization
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And path b_bookingId
    When method DELETE
    Then status 403
    And match response == 'Forbidden'

  @UnhappyPath @deleteBooking
  Scenario: Eliminacion de booking sin enviar un id en el path
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And path '/:id'
    When method DELETE
    Then status 405
    And match response == 'Method Not Allowed'

  @UnhappyPath @deleteBooking
  Scenario: Eliminacion de booking sin enviar path
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    When method DELETE
    Then status 404
    And match response == 'Not Found'
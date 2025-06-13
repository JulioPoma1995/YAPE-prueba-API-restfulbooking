Feature: Busqueda de booking por id

  @HappyPath @regresion @smoketest @getBookingById
  Scenario: Busqueda de booking usando la id de la booking previo creada
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    * def fullUrl = 'https://restful-booker.herokuapp.com/booking/' + b_bookingId
    * print 'URL completa: ', fullUrl
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And path b_bookingId
    When method GET
    Then status 200

  @HappyPAth @getBookingById
  Scenario: Busqueda de booking por id validacion del esquema resultado
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And path b_bookingId
    When method GET
    Then status 200
    And match response == read('classpath:schemas/getbookingbyid-schema.json')

  @HappyPath @getBookingById
  Scenario: Busqueda de booking por id respuesta 418 controlada
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And path b_bookingId
    When method GET
    Then status 418

  @UnHappyPath @getBookingById
  Scenario: Busqueda de booking por id inválida
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And path 'abc123'
    When method GET
    Then status 404
    And match response == 'Not Found'

  @UnHappyPath @getBookingById
  Scenario: Busqueda de booking por id inexistente
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And path '9999999999'
    When method GET
    Then status 404
    And match response == 'Not Found'
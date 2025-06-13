Feature: Obtencion de booking por ids

  @HappyPath @regresion @smoketest @bookingIds
  Scenario:Obtencion de booking ids sin parametros
    Given url 'https://restful-booker.herokuapp.com/booking'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros lastname
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param lastname = 'Brown'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros checkin
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param checkin = '2018-01-01'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros checkout
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param checkout = '2018-01-02'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname y lastname
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    And param lastname = 'Brown'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname y checkin
  Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    And param checkin = '2018-01-01'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname y checkout
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    And param checkout = '2018-01-02'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros lastname y checkin
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param lastname = 'Brown'
    And param checkin = '2018-01-01'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros lastname y checkout
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param lastname = 'Brown'
    And param checkout = '2018-01-02'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname, lastname y checkin
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    And param lastname = 'Brown'
    And param checkin = '2018-01-01'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname, lastname y checkout
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    And param lastname = 'Brown'
    And param checkout = '2018-01-02'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de booking ids con parametros firstname, checkin y checkout
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = 'Jim'
    And param checkin = '2018-01-01'
    And param checkout = '2018-01-02'
    When method GET
    Then status 200
    And match response == '#[]'

  @HappyPath @regresion @bookingIds
    Scenario: Obtencion de booking ids con parametros lastname, checkin y checkout
    * def fecha_actual = new Date().toISOString().substring(0, 10)
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param lastname = 'Brown'
    And param checkin = '2014-01-01'
    And param checkout = fecha_actual
    When method GET
    Then status 200
    And match response == '#[]'

    ## Se encontró un error debido a que al ingresar todos los parametros de busqueda, el endpoint devuelve vacío el array de respuesta
  @HappyPath @regresion @bookingIds
  Scenario: Obtencion de bokking ids con parametros mapeados en creacion
    * call read('classpath:features/booking-createbooking.feature@smoketest')
    * def b_bookingId = response.bookingid
    * def b_firstname = response.booking.firstname
    * def b_lastname = response.booking.lastname
    * def b_checkin = response.booking.bookingdates.checkin
    * def b_checkout = response.booking.bookingdates.checkout
    Given url 'https://restful-booker.herokuapp.com/booking'
    And param firstname = b_firstname
    And param lastname = b_lastname
    And param checkin = b_checkin /*Se valida que quitando este campo si se llega a encontrar el bookingid*/
    And param checkout = b_checkout
    When method GET
    Then status 200
    And match response contains { bookingid: '#(b_bookingId)' }


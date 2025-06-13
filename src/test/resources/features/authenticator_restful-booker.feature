Feature: Autenticacion en Restful Booker API

  @HappyPath @regresion @smoketest @auth
  Scenario: Obtener token de autenticacion
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    And match response.token != null
    And match response.token == '#regex ^[a-zA-Z0-9]{15}$'

  @HappyPath @regresion @auth
  Scenario: Validar esquema de respuesta
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    And match response == read('classpath:schemas/auth-schema.json')

  @UnhappyPath @auth
  Scenario: Envio de username erroneo en token de autenticacion
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request { username: 'adminfake', password: 'password123' }
    When method POST
    Then status 200
    And match response.reason == 'Bad credentials'

  @UnhappyPath @auth
  Scenario: Envío de password erroneo en token de autenticacion
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request { username: 'admin', password: 'password123fake' }
    When method POST
    Then status 200
    And match response.reason == 'Bad credentials'

Feature: Autenticación en Restful Booker API

  Scenario: Obtener token de autenticación
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    And match response.token != null

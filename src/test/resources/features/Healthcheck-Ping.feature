Feature: pigneo para validar estatus del servicio

  ##Error el endpoint de ping debería devolver un status 200 y un mensaje OK
  @HappyPath @regresion @smoketest @healthcheckPing
  Scenario: Se valida el estatus del servicio
    Given url 'https://restful-booker.herokuapp.com/ping'
    When method GET
    Then status 201
    And match response == 'Created'


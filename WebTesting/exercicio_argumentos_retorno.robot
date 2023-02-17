*** Settings ***
Documentation    Exercicio para fixação do conteúdo sobre keywords com argumentos e retorno
Library    String
Library    FakerLibrary

*** Variables ***
${PALAVRA_ALEATORIA_FAKER_LIB}

*** Test Cases ***
Caso de teste 01
    Uma keyword com argumentos e retorno
    
*** Keywords ***
Uma keyword com argumentos e retorno
    ${EMAIL_GERADO}    Uma subkeyword com argumentos e retorno    philipe    melo    ${PALAVRA_ALEATORIA_FAKER_LIB}
    Log To Console    ${EMAIL_GERADO}

Uma subkeyword com argumentos e retorno    
    [Arguments]    ${NOME}    ${SOBRENOME}    ${PALAVRA_ALEATORIA_FAKER_LIB}
    ${PALAVRA_ALEATORIA}    Generate Random String
    ${PALAVRA_ALEATORIA_FAKER_LIB}    FakerLibrary.Country
    ${GERAR_EMAIL}    Set Variable    O e-mail gerado foi:${NOME}_${SOBRENOME}_${PALAVRA_ALEATORIA}_${PALAVRA_ALEATORIA_FAKER_LIB}@email.com
    RETURN    ${GERAR_EMAIL}
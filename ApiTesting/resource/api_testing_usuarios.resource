*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections

*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@email.teste.com
    Log To Console    ${EMAIL_TESTE}

Cadastar o usuário criado na ServeRest
    [Arguments]    ${email}    ${status_code_desejado}
    ${body}    Create Dictionary    
    ...    nome=Fulano da Silva    
    ...    email=${email}    
    ...    password=1234    
    ...    administrador=true
    Log    ${body}
    
    Criar sessão na ServeRest
    
    ${resposta}    POST On Session    
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${body}
    ...    expected_status=${status_code_desejado}
    
    Log    ${resposta.json()}

    IF    ${resposta.status_code} == 201
          Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}
    END

    # Atribuir a variável local ${resposta.json()} como valor da variável de teste ${RESPOSTA}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    
Criar sessão na ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev

Conferir se o usuário foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${RESPOSTA}    _id

Repetir o cadastro do usuário
    Cadastar o usuário criado na ServeRest    email=${EMAIL_TESTE}    status_code_desejado=400

Verificar se a API impede o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}    GET On Session    alias=ServeRest    url=/usuarios/${ID_USUARIO}    expected_status=200

    # Exemplo de uso das propriedades da resposta de uma requisição, com base no conteúdo disponível em:
    # https://www.w3schools.com/python/ref_requests_response.asp

    Log    ${resposta_consulta.status_code}
    Log    ${resposta_consulta.reason}
    Log    ${resposta_consulta.headers}
    Log    ${resposta_consulta.elapsed}
    Log    ${resposta_consulta.text}
    Log    ${resposta_consulta.json()}
    Log    ${resposta_consulta.url}

    Set Test Variable    ${RESPOSTA_CONSULTA}    ${resposta_consulta.json()}



Conferir os dados retornados
    Log    ${RESPOSTA_CONSULTA}
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    nome            Fulano da Silva
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    email           ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    password        1234
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    administrador   true
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    _id             ${ID_USUARIO}
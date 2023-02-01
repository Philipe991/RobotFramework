*** Settings ***
Library       SeleniumLibrary

*** Variables ***
# Esta seção declara variáveis que tem valores constantes (fixos)
${BROWSER}             chrome
${URL}                 https://www.amazon.com.br/
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}  //span[@class='a-size-base a-color-base apb-browse-refinements-indent-1 a-text-bold'][contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Wait Until Page Contains    text=${TITULO}
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//span[@class='nav-a-content'][contains(.,'${NOME_CATEGORIA}')]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}
    
Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')]

# GHERKIN STEPS

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element    locator=(//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')])[1]
    Wait Until Element Is Visible    locator=add-to-cart-button
    Click Element    locator=add-to-cart-button

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]

Remover o produto "${PRODUTO}" do carrinho
    Click Element    locator=//span[@aria-hidden='true'][contains(.,'Carrinho')]
    Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]
    Click Element    locator=//input[@data-action='delete']

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]

Quando adicionar o produto "${PRODUTO}" no carrinho
    Acessar a home page do site Amazon.com.br
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "${PRODUTO}" no carrinho

Então o produto "${PRODUTO}" deve ser mostrado no carrinho
    Verificar se o produto "${PRODUTO}" foi adicionado com sucesso

E existe o produto "${PRODUTO}" no carrinho
    Quando adicionar o produto "${PRODUTO}" no carrinho
    Então o produto "${PRODUTO}" deve ser mostrado no carrinho

Quando remover o produto "${PRODUTO}" do carrinho
    Remover o produto "${PRODUTO}" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
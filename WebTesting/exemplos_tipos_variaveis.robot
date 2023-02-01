*** Settings ***
Documentation    Exemplo de tipos de variáveis: Simples, Listas e Dicionários

*** Variables ***
#Simples
${GLOBAL_SIMPLES}    Vamos ver os tipos de variáveis do robot

#Lista
@{FRUTAS}            morango    banana    maçã    uva    abacaxi

#Dicionário
&{PESSOA}             nome=Philipe Oliveira    email=philipe991@exemplo.com.br    idade=31    sexo=masculino

@{MESES}   janeiro
...        fevereiro
...        março
...        abril
...        maio
...        junho
...        julho
...        agosto
...        setembro
...        outubro
...        novembro
...        dezembro

&{DIAS_POR_MES_2022}   janeiro=31
...                    fevereiro=28
...                    março=31
...                    abril=30
...                    maio=31
...                    junho=30
...                    julho=31
...                    agosto=31
...                    setembro=30
...                    outubro=31
...                    novembro=30
...                    dezembro=31

*** Test Cases ***
Caso de teste de exemplo 01
    Uma keyword qualquer 01

Imprimir os meses do ano
    Log To Console     Mês 01: ${MESES[0]}
    Log To Console     Mês 02: ${MESES[1]}
    Log To Console     Mês 03: ${MESES[2]}
    Log To Console     Mês 04: ${MESES[3]}
    Log To Console     Mês 05: ${MESES[4]}
    Log To Console     Mês 06: ${MESES[5]}
    Log To Console     Mês 07: ${MESES[6]}
    Log To Console     Mês 08: ${MESES[7]}
    Log To Console     Mês 09: ${MESES[8]}
    Log To Console     Mês 10: ${MESES[9]}
    Log To Console     Mês 11: ${MESES[10]}
    Log To Console     Mês 12: ${MESES[11]}

Imprimir dias por mês de 2022
    Log To Console     Em JANEIRO há ${DIAS_POR_MES_2022.janeiro} dias!
    Log To Console     Em FEVEREIRO há ${DIAS_POR_MES_2022.fevereiro} dias!
    Log To Console     Em MARÇO há ${DIAS_POR_MES_2022.março} dias!
    Log To Console     Em ABRIL há ${DIAS_POR_MES_2022.abril} dias!
    Log To Console     Em MAIO há ${DIAS_POR_MES_2022.maio} dias!
    Log To Console     Em JUNHO há ${DIAS_POR_MES_2022.junho} dias!
    Log To Console     Em JULHO há ${DIAS_POR_MES_2022.julho} dias!
    Log To Console     Em AGOSTO há ${DIAS_POR_MES_2022.agosto} dias!
    Log To Console     Em SETEMBRO há ${DIAS_POR_MES_2022.setembro} dias!
    Log To Console     Em OUTUBRO há ${DIAS_POR_MES_2022.outubro} dias!
    Log To Console     Em NOVEMBRO há ${DIAS_POR_MES_2022.novembro} dias!
    Log To Console     Em DEZEMBRO há ${DIAS_POR_MES_2022.dezembro} dias!

*** Keywords ***
Uma keyword qualquer 01
    #Simples
    Log    ${GLOBAL_SIMPLES}
    #Lista
    Log    Tem que ser uma maçã: ${FRUTAS[2]} e um morango: ${FRUTAS[0]}
    #Dicionário
    Log    Nome: ${PESSOA.nome} e email: ${PESSOA.email}
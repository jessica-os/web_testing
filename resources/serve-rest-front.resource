*** Settings ***
Library    Browser
Library    FakerLibrary
Library    OperatingSystem

*** Variables ***
${BROWSER}            chromium
${HEADLESS}           ${false}
${SITE_SERVE_REST}    https://front.serverest.dev    
${NOME_PROD}          Headset Gamer Havit
${DESCRIÇÃO}          DescriçãoDescriçãoDescriçãoDescriçãoDescrição
${WIDTH}              1200     
${HEIGHT}             800
${CAMINHO_IMAGEM}     ${EXECDIR}${/}assets${/}fone.png

*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}  
    ...            headless=${HEADLESS}
    New Context    viewport={"width": ${WIDTH}, "height": ${HEIGHT}}

Ir para o site Serve Rest Front
    New Page    url=${SITE_SERVE_REST} 
    ${title}    Get Title    ==    Front - ServeRest
    Log         ${title}

Preencher os dados do novo usuário e cadastrar
    Click               css=a[data-testid="cadastrar"]
    Fill Text           css=input[data-testid="nome"]    Jessica Oliveira
    ${EMAIL}            FakerLibrary.Email
    Set Global Variable    ${EMAIL}
    Fill Text           css=input[data-testid="email"]    ${EMAIL}
    Fill Text           css=input[data-testid="password"]    123456    
    Check Checkbox      css=input[data-testid="checkbox"]
    Click               css=button[data-testid="cadastrar"]

Conferir usuário cadastrado com sucesso
    Wait For Elements State    h1    visible
    Get Text                   h1    ==    Bem Vindo Jessica Elisa
    Get Element States         css=button[data-testid="logout"]    validate    value & visible

Logar com usuário e senha
    Fill Text      css=input[data-testid="email"]    jessicaelisateste@teste.com
    Fill Text      css=input[data-testid="senha"]    54321    
    Click          css=button[data-testid="entrar"]  

Abrir a lista de usuários
    Click          css=a[data-testid="listarUsuarios"]
    Get Text       h1    ==    Lista dos usuários  

Verificar se existe o usuário "Jessica Elisa"
    ${elemento}        Get Table Cell Element    css=table    "Nome"    "jessicaelisateste@teste.com"
    ${usuario_nome}    Get Text    ${elemento}    ==    Jessica Elisa
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${True}

Clicar no botão "Cadastrar" para abrir a tela para o cadastro
    Click         xpath=//a[@data-testid='cadastrarProdutos']

Preencher os dados do novo produto
    Fill Text         xpath=//input[@id='nome']             ${NOME_PROD}
    Fill Text         css=input[data-testid="preco"]        201
    Fill Text         xpath=//textarea[@id='description']   ${DESCRIÇÃO}
    Fill Text         xpath=//input[@id='quantity']         505
    Upload File By Selector    xpath=//input[@id='imagem']    ${CAMINHO_IMAGEM}


Clicar no botão "Cadastrar"
    Click    xpath=//button[@type='submit']

Clicar na lista de produtos cadastrados
    Click    css=a[data-testid="listarProdutos"]

Verificar se existe o produto "${NOME_PROD}" na lista de Produtos
    ${elemento_produto}    Get Table Cell Element     css=table    "Descrição"     "${NOME_PROD}"
    ${Descrição}    Get Text  ${elemento_produto}      ==    DescriçãoDescriçãoDescriçãoDescriçãoDescrição
    Highlight Elements  ${elemento_produto}
    Take Screenshot   fullPage=${True}


Criar usuário via API
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}

    ${resposta}    Http    url=https://serverest.dev/usuarios
    ...                    method=POST
    ...                    body={ "nome": "Jessica Elisa", "email": "${EMAIL}", "password": "54321", "administrador": "true"}



Logar com o usuário cadastrado via API
     ${resposta}    Http    url=https://serverest.dev/login
     ...                    method=POST
     ...                    body={"email": "${EMAIL}","password": "54321"}
     LocalStorage Set Item    serverest/userEmail    ${EMAIL}
     LocalStorage Set Item    serverest/userToken     ${resposta["body"]["authorization"] }
     LocalStorage Set Item    serverest/userNome      Jessica Elisa  

    Go To    url=https://front.serverest.dev/admin/home
    Take Screenshot


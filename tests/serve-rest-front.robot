*** Settings ***
Resource    ../resources/serve-rest-front.resource
Suite Teardown    Close Browser  ALL

*** Test Cases ***

Login com sucesso Serve Rest front
    Abrir o navegador
    Ir para o site Serve Rest Front
    
Cadastrar novo usuário
    Abrir o navegador
    Ir para o site Serve Rest Front
    Criar usuário via API
    Logar com o usuário cadastrado via API
    Conferir usuário cadastrado com sucesso

Listar usuários
    Abrir o navegador
    Ir para o site Serve Rest Front
    Logar com usuário e senha
    Abrir a lista de usuários
    Verificar se existe o usuário "Jessica Elisa"
Cadastrar um produto 
    Abrir o navegador
    Ir para o site Serve Rest Front
    Logar com usuário e senha
    Clicar no botão "Cadastrar" para abrir a tela para o cadastro
    Preencher os dados do novo produto
    Clicar no botão "Cadastrar"

Conferir o produto cadastrado
    Abrir o navegador
    Ir para o site Serve Rest Front
    Logar com usuário e senha
    Clicar na lista de produtos cadastrados
    Verificar se existe o produto "Headset Gamer Havit" na lista de Produtos


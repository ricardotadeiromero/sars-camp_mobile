# SARsCamp - Mobile

## Visão Geral📚
Esta aplicação foi desenvolvida utilizando Dart com o framework Flutter(ferramenta) que tem como foco desenvolvimento de multiplataforma em dispositivos móveis. Possui como objetivo facilitar a vida dos estudantes do campus I(Cotil e FT) e campus II(FCA)

## Funcionalidades Principais🛠️
- Mostrar o cardápio dos campos, trazendo as informações do café da manhã, almoço e jantar comum e vegetariano, com os dados específicos do que será servido no dia.
- Mostrar o saldo do aluno.
- Mostrar os itens perdidos nos campos com a possibilidade de pesquisa.

# Informações para o Usuário 

## Pré-Requisitos para rodar o aplicativo no smartphone📲
- Ter sistema IOS ou Android.

## Instalação do apk no smartphone📥

Siga estes passos para instalar e configurar a aplicação:

1. Abra a Play Store ou Apple Store 
2. Pesquise SarsCamp
3. Aperte em instalar

## Uso🚀
Assim que o aplicativo for aberto, uma tela com três itens principais aparecerá: cardápio, Saldo do RU e Achados & Perdidos. Além disso, haverá itens de avaliação e informações sobre o aplicativo no topo. Para acessar os três principais, basta clicar no ícone correspondente, o que o direcionará para a respectiva página onde os dados disponíveis serão exibidos, sendo o mesmo para acessar os icones do topo.

# Informações Técnicas🛠️
Esta seção é destinada a desenvolvedores.

## Instalação do framework e suas depedências⚙️

- Acesse o site: https://docs.flutter.dev/get-started/install e escolha uma das plataformas disponíveis para baixar o framework. Verifique se sua máquina atende aos requisitos mínimos. Não instale no Program Files ou em um caminho que contenha caracteres especiais.
- Atualize o PATH.
- Execute "Flutter doctor".
- Em seguida, acesse o site: https://developer.android.com/studio, baixe o Android Studio e instale.
- No Android Studio, clique em "SDK Manager" e vá até o SDK tools.
- Selecione o Android SDK Command-line Tools(latest), Google USB Driver, Google Web Driver. Se o seu dispositivo for Intel, é recomendado instalar o Intel x86 Emulator Accelerator (HAXM installer) e instale todos os componentes.
- Adicione no PATH uma pasta com o nome "JAVA_HOME" que possua um caminho do JAVA que foi instalado com o Android Studio ou utilize um de sua escolha.
- Execute novamente o flutter doctor e em seguida flutter doctor --android-licenses e aceite todas as licenças dos pacotes.
- Instale a extensão flutter e dart no Visual Studio Code.

## Dependências para rodar o projeto📦
- url_launcher: ^6.1.10: Esta extensão permite abrir URLs em um navegador externo. A versão especificada é 6.1.10.
- shared_preferences: ^2.2.0: Esta é uma biblioteca que permite salvar e recuperar dados persistentes de forma simples. A versão 2.2.0 é a versão especificada.
- dio: ^5.3.3: O Dio é uma biblioteca HTTP eficiente para Dart e Flutter. A versão 5.3.3 é a versão que o projeto está configurado para utilizar.
- provider: ^6.0.5: O Provider é uma biblioteca que ajuda a gerenciar o estado da aplicação no Flutter. A versão 6.0.5 é a versão especificada.
- flutter_lints: ^2.0.0 é uma dependência que refere-se às configurações de linter (ferramenta de análise de código) específicas para projetos Flutter.

## Comandos úteis para a aplicação⚡
- flutter pub get
- flutter run
- flutter clean
- flutter update

## Versão atual do do SDK 🚀
SDK: >= 2.18.6 < 3.0.0

## Ferramentas da API🛠️
- [Node.js](https://nodejs.org/en/docs) - Software utilizado para produção da API
- [TypeScript](https://www.typescriptlang.org/docs/) - Linguagem utilizada para produção da API

## Autores✒️

* **Ricardo Tadei Romero** - *Gerente de Projeto* - [Ricardo Tadei Romero](https://github.com/ricardotadeiromero)
* **Gilmar da Silva** - *Desenvolvedor* - [Gilmar da Silva](https://github.com/Gil1513)
* **Matheus Figueiredo** - *Desenvolvedor* - [Matheus Figueiredo](https://github.com/Mat2302)
* **Raphael Parra** - *Desenvolvedor* - [Parrael](https://github.com/Parrael)

## Expressões de gratidão🎁
* Agradecemos aos professores do curso de Desenvolvimento de Sistemas do Colégio Técnico de Limeira - COTIL, pelas instruções e auxílios durante todo o período de desenvolvimento do projeto. Também agradecemos ao nosso colega de turma Pedro Augusto que nos auxiliou durante a produção da API do projeto.

##Licença 
  Esse projeto está sob a licença GNU General Public License v3.0
- [LICENSE.md]

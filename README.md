# Tractian Challenges Mobile Software Engineer

Este repositório contém a minha solução para o [desafio técnico da Tractian](https://github.com/tractian/challenges/blob/main/mobile/README.md).

## 📽️ Demonstração do App

Assista ao vídeo demonstrativo do app e suas funcionalidades no YouTube:
[🔗 Link para o vídeo](https://youtu.be/IolfGsGvjWE)

APK-profile para download:
[🔗 Link para apk](https://drive.google.com/file/d/1Utajk7hAp5s_OGauimbKDVj1PtkZJfQ0/view?usp=sharing)

## 📌 Sobre o Projeto

Este projeto é um aplicativo desenvolvido em Flutter que exibe unidades retornadas por uma API e permite visualizar e filtrar a árvore de assets de cada unidade.

## ✨ Funcionalidades Implementadas

- **Home Page**: Exibe as unidades retornadas pela API.
- **Asset Page**: Permite visualizar a árvore de assets de cada unidade.
- **Filtros**:
  - Filtro por texto (Pesquisa direta nos assets).
  - Filtro por tipo (Sensores de energia).
  - Filtro por estado (Estado crítico).

### 📷 Imagens do App

<div align="center">
  <img src="https://github.com/user-attachments/assets/bd844fd7-b9b8-4762-a750-f6d9a48f9b32", width="250px"/>
  <img src="https://github.com/user-attachments/assets/5210750d-e6cc-41a6-b441-393bbce2bdc0", width="250px"/>
  <img src="https://github.com/user-attachments/assets/9bcc3ec4-c98f-4e8a-a774-e60422516cef", width="250px"/>
  <img src="https://github.com/user-attachments/assets/1ec8a062-faf5-45fb-a893-f6d2a4767289", width="250px"/>
</div>

## ⚙️ Parte Técnica

### 📂 Arquitetura Utilizada

O projeto segue a **Clean Architecture** para garantir um código modular e escalável.

### 📦 Pacotes Utilizados

- `flutter_bloc`: Gerenciamento de estado.
- `dartz`: Utilização de monads como Either para tratamento de erros.
- `dio`: Cliente HTTP para chamadas à API.
- `equatable`: Facilita comparação de objetos imutáveis.
- `get_it`: Injeção de dependência.
- `go_router`: Navegação entre as telas.

### Versão do flutter
- `Flutter`: 3.24.3
- `Dart`: 3.5.3

## 🚀 Melhorias Futuras

Caso tivesse mais tempo para desenvolver, algumas melhorias que implementaria incluem:

### 🔹 Renderização sob demanda para nós profundos
- Atualmente, se a árvore de assets crescer muito, pode haver travamentos na renderização.
- **Solução**: Implementar um mecanismo para renderizar os filhos de um nó apenas quando visíveis na tela.

### 🔹 Mecanismo para ocultar/exibir todos os nós
- Se o usuário abrir muitas árvores, pode ser difícil navegar.
- **Solução**: Criar um botão para ocultar/exibir todos os nós rapidamente.

### 🔹 Melhorias na pesquisa
- Atualmente, a pesquisa retorna todos os nós e seus filhos.
- **Solução**: Exibir apenas os nós que correspondem à pesquisa, ocultando filhos irrelevantes para melhor desempenho.

## 🔗 Contato & Projetos Relacionados

- **Meu LinkedIn**: [🔗 linkedin.com](https://www.linkedin.com/in/althierfson/)
- **Meu github**: [🔗 github.com](https://github.com/Althierfson)
- **Outros Projetos Interessantes**:
  - [🔗 Meu Canal no Youtube](https://www.youtube.com/@cajucode)


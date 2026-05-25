# freepdfreader

Um visualizador de PDF simples, leve e moderno para Android, desenvolvido em Flutter. O aplicativo permite abrir arquivos PDF locais, navegar de forma contínua e compartilhar arquivos com facilidade. Além disso, ele é capaz de receber e visualizar PDFs compartilhados a partir de outros aplicativos do sistema.

## 🚀 Recursos

- **Visualização Suave**: Renderização de alta fidelidade e rolagem vertical contínua usando a biblioteca `pdfx`.
- **Integração com o Sistema (Sharing Intent)**: Abra arquivos PDF diretamente a partir de outros aplicativos utilizando a funcionalidade de compartilhar do Android.
- **Compartilhamento**: Envie/compartilhe o PDF atualmente visualizado para outros contatos ou aplicativos com um clique usando o `share_plus`.
- **Interface Limpa e Moderna**: Tema escuro personalizado com foco em leitura confortável.

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev) (Framework SDK)
- [pdfx](https://pub.dev/packages/pdfx) (Visualização e manipulação de arquivos PDF)
- [share_plus](https://pub.dev/packages/share_plus) (Compartilhamento de arquivos)
- [receive_sharing_intent](https://pub.dev/packages/receive_sharing_intent) (Recepção de arquivos compartilhados por outros apps)

## 📦 Como Executar

### Pré-requisitos
- SDK do Flutter configurado em sua máquina.
- Um emulador Android ou dispositivo físico conectado com o modo de depuração USB ativado.

### Passos para Rodar

1. Clone o repositório (após a publicação):
   ```bash
   git clone https://github.com/seu-usuario/freepdfreader.git
   cd freepdfreader
   ```

2. Obtenha as dependências do projeto:
   ```bash
   flutter pub get
   ```

3. Execute o aplicativo:
   ```bash
   flutter run
   ```

## 📝 Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter mais detalhes.

# Muralha Inteligente

Aplicativo mobile em Flutter para alertas de veículos suspeitos com base em localização. O app recebe notificações via Firebase Cloud Messaging, calcula a distância entre o usuário e o ponto informado no alerta e exibe detalhes do veículo em um mapa.

O projeto foi desenvolvido como protótipo acadêmico/mobile, integrando notificações push, geolocalização, mapa interativo e persistência local simples.

## Destaques

- App Flutter com suporte Android/iOS.
- Integração com Firebase Cloud Messaging.
- Notificações locais com `awesome_notifications`.
- Inscrição em tópico de notificação para receber alertas.
- Cálculo de distância usando geolocalização do dispositivo.
- Mapa com OpenStreetMap via `flutter_map`.
- Marcador da localização do usuário e do veículo alertado.
- Telas para listagem, cadastro e detalhes de veículos.

## Stack

- Flutter / Dart
- Firebase Core
- Firebase Messaging
- Awesome Notifications
- Geolocator
- Flutter Map / OpenStreetMap
- Shared Preferences
- HTTP

## Estrutura

| Caminho | Responsabilidade |
| --- | --- |
| `lib/main.dart` | Inicialização do Flutter, Firebase e notificações. |
| `lib/notifications/` | Tratamento de mensagens push e notificações locais. |
| `lib/controller/mapController.dart` | Mapa, permissão de localização e cálculo de distância. |
| `lib/screens/` | Telas principais do aplicativo. |
| `lib/models/` | Modelos usados pelas telas e controladores. |
| `android/` e `ios/` | Configurações nativas do projeto Flutter. |

## Como executar

Pré-requisitos:

- Flutter SDK compatível com Dart `>=2.12.0 <3.0.0`.
- Projeto Firebase configurado para Android/iOS.
- Permissões de localização habilitadas no dispositivo ou emulador.

Passos:

```bash
flutter pub get
flutter run
```

Para uma execução real com notificações, configure o Firebase do projeto e garanta que o app esteja inscrito no tópico usado pelo backend de envio.

## Observações de segurança

- Configurações mobile do Firebase podem existir no app, mas chaves devem estar restritas por pacote/bundle e regras do Firebase.
- Service accounts e chaves privadas de backend não devem ficar neste repositório.
- O backend de envio de notificações deve permanecer separado do app mobile.

## Status

Protótipo acadêmico finalizado. O repositório demonstra integração mobile com notificações, localização e mapas em Flutter.
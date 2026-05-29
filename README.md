# Muralha Inteligente

Aplicativo mobile em Flutter para alertas de veiculos suspeitos com base em localizacao. O app recebe notificacoes via Firebase Cloud Messaging, calcula a distancia entre o usuario e o ponto informado no alerta e exibe detalhes do veiculo em um mapa.

O projeto foi desenvolvido como prototipo academico/mobile, integrando notificacoes push, geolocalizacao, mapa interativo e persistencia local simples.

## Destaques

- App Flutter com suporte Android/iOS.
- Integracao com Firebase Cloud Messaging.
- Notificacoes locais com `awesome_notifications`.
- Inscricao em topico de notificacao para receber alertas.
- Calculo de distancia usando geolocalizacao do dispositivo.
- Mapa com OpenStreetMap via `flutter_map`.
- Marcador da localizacao do usuario e do veiculo alertado.
- Telas para listagem, cadastro e detalhes de veiculos.

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
| `lib/main.dart` | Inicializacao do Flutter, Firebase e notificacoes. |
| `lib/notifications/` | Tratamento de mensagens push e notificacoes locais. |
| `lib/controller/mapController.dart` | Mapa, permissao de localizacao e calculo de distancia. |
| `lib/screens/` | Telas principais do aplicativo. |
| `lib/models/` | Modelos usados pelas telas e controladores. |
| `android/` e `ios/` | Configuracoes nativas do projeto Flutter. |

## Como executar

Pre-requisitos:

- Flutter SDK compativel com Dart `>=2.12.0 <3.0.0`.
- Projeto Firebase configurado para Android/iOS.
- Permissoes de localizacao habilitadas no dispositivo ou emulador.

Passos:

```bash
flutter pub get
flutter run
```

Para uma execucao real com notificacoes, configure o Firebase do projeto e garanta que o app esteja inscrito no topico usado pelo backend de envio.

## Observacoes de seguranca

- Configuracoes mobile do Firebase podem existir no app, mas chaves devem estar restritas por pacote/bundle e regras do Firebase.
- Service accounts e chaves privadas de backend nao devem ficar neste repositorio.
- O backend de envio de notificacoes deve permanecer separado do app mobile.

## Status

Prototipo academico finalizado. O repositorio demonstra integracao mobile com notificacoes, localizacao e mapas em Flutter.
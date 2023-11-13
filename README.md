# Simulador de Processos e Memória

Requisito de avaliação da disciplina de Sistemas Operacionais MATA58 2023.2.

Feito por Gustavo de Oliveira Ferreira.

Código emm versões mais atualizadas disponível em https://github.com/gustoliveira/sistemas_operacionais_MATA58

## Setup

Make sure to have the **flutter 3.10.4** installed and **Java SDK** (not Java JRE) installed

- [Linux Installation Guide](https://docs.flutter.dev/get-started/install/linux) 

## Flutter Desktop Setup

**Additional Linux requirements** :penguin:

For Linux desktop development, you need the following in addition to the Flutter SDK:

- [Clang](https://clang.llvm.org/)
- [CMake](https://cmake.org/)
- [GTK development headers](https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html)
- [Ninja build](https://ninja-build.org/)
- [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
- [liblzma-dev](https://packages.debian.org/sid/liblzma-dev) This dependency may be required

```sh
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

```sh
flutter clean
flutter pub get
```

## Run

```
flutter run -d linux
```

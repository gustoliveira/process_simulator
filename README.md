# Simulador de Processos e Memória

Requisito de avaliação da disciplina de Sistemas Operacionais MATA58 2024.1.

Feito por Gustavo de Oliveira Ferreira.

Código em versões mais atualizadas disponível em https://github.com/gustoliveira/process_simulator

## Setup

Instale na versão **flutter 3.10.4** assim como **Java SDK** (não o Java JRE).

- [Guia de instalação Linux](https://docs.flutter.dev/get-started/install/linux) 

## Setup Flutter Desktop

**Linux Requirements** :penguin:

Para desenvolvimento em linux, será necessário instalar tais pacotes além do SDK do Flutter:

- [Clang](https://clang.llvm.org/)
- [CMake](https://cmake.org/)
- [GTK development headers](https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html)
- [Ninja build](https://ninja-build.org/)
- [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/)
- [liblzma-dev](https://packages.debian.org/sid/liblzma-dev)

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

# Minikube

## Installation

### Windows

Multiple options available:

- Binary Download
  - Download the [latest release](https://storage.googleapis.com/minikube/releases/latest/minikube-installer.exe) or run the following:

  ```powershell
  New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force

  Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing

  ```

  - Add `minikube.exe` to `PATH`:

  ```powershell
  $oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
  if ($oldPath.Split(';') -inotcontains 'C:\minikube'){
  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine)
  }
  ```

- Windows Package Manager

  ```powershell
  winget install Kubernetes.minikube
  ```

- Chocolatey Install

  ```powershelll
  choco install minikube
  ```

### Linux

```shell
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

```

### MacOS

```shell
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube
```

## Usage

## Basic Operations

- Start cluster with default configuration and docker driver: `minikube start`
- Stop cluster: `minikube stop`
- Delete cluster: `minikube delete`

### Additional Options

- Set Kubernetes Version: Append `--kubernetes-version=v<VERSION>`
- Set number of nodes: `--nodes=<number>` or `-n=<number>`
- Set driver (defaults to auto-detect and/or Docker): `--driver=<driver>` or `-d=<driver>`
  - Options include:
    - `docker`
    - `hyperv`
    - `virtualbox`
    - `podman`
- Resource quotas:
  - `--cpus=<number>`
  - `--memory=<number><unit>` e.g. `2048g` = `2Gb`
- Use a new minikube profile: add `-p <profile name>` to start command.
- Switch between clusters: `minikube profile <profile name>`

### Addons

- List available addons: `minikube addons list`
- Install an addon: `minikube addons enable`

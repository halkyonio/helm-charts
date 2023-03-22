Table of Contents
=================

* [Introduction](#introduction)
* [Charts repository](#repository)
  * [List of charts available](#list-of-charts-available)
  * [Usage](#usage)

# Introduction

This project aims to :
- Host the [Primaza Helm repository](http://halkyonio.github.io/primaza-helm/index.yaml) that contains [the Primaza App](https://github.com/halkyonio/primaza-poc) Helm charts,
- Usage section where users can learn about how installing Primaza using Helm.

# Repository

This repository uses GitHub Pages to publish the Helm charts index at this address: [http://halkyonio.github.io/primaza-helm](http://halkyonio.github.io/primaza-helm). To use it locally, you need to execute:

```console
$ helm repo add primaza http://halkyonio.github.io/primaza-helm
```

And confirm that the snowdrop repository is listed:

```console
$ helm repo list
NAME           	URL                               
primaza	    http://halkyonio.github.io/primaza-helm
```

## List of charts available

| Chart Name                                                             | Description | Source |
|------------------------------------------------------------------------|-------------| ------ |
| [spring-boot-example-app](#spring-boot-example-app)                    | Chart to be used to create a Spring Boot application | [repository/spring-boot-example-app](repository/spring-boot-example-app) |

## Usage

Requirements:
- Connected/logged to a Kubernetes/OpenShift cluster
- Have installed [the Helm command line](https://helm.sh/docs/intro/install/)
TODO
Table of Contents
=================

* [Introduction](#introduction)
* [Charts repository](#repository)
  * [List of charts available](#list-of-charts-available)
  * [Usage](#usage)

# Introduction

This project aims to :
- Host the [Primaza Helm repository](http://halkyonio.github.io/helm-charts/index.yaml) that contains [the Primaza App](https://github.com/halkyonio/primaza-poc) Helm charts,
- Usage section where users can learn about how installing Primaza using Helm.

# Repository

This repository uses GitHub Pages to publish the Helm charts index at this address: [http://halkyonio.github.io/helm-charts](http://halkyonio.github.io/helm-charts). To use it locally, you need to execute:

```console
$ helm repo add halkyonio http://halkyonio.github.io/helm-charts
```

And confirm that the snowdrop repository is listed:

```console
$ helm repo list
NAME           	URL                               
halkyonio	    http://halkyonio.github.io/helm-charts
```

## List of charts available

| Chart Name                                                             | Description | Source |
|------------------------------------------------------------------------|-------------| ------ |
| [primaza-app](#primaza-app)                    | Chart to start [the Primaza backend](https://github.com/halkyonio/primaza-poc) | [https://github.com/halkyonio/primaza-poc](https://github.com/halkyonio/primaza-poc) |

## Usage

Requirements:
- Connected/logged to a Kubernetes/OpenShift cluster
- Have installed [the Helm command line](https://helm.sh/docs/intro/install/)
- Have installed/updated [the Primaza Helm repository](#repository)

### primaza-app

This chart deploys and exposes the Primaza backend on Kubernetes including a Postgresql database.

To install it, you need to:
- Set the Primaza application image you want to use. You can see all the versions in [here](quay.io/halkyonio/primaza-app).
- Set the ingress host. Only if you want to publicly expose the application.

For example:

```console
$ helm install primaza-app halkyonio/primaza-app --devel --set app.image=quay.io/halkyonio/primaza-app:0.0.1-SNAPSHOT --set app.ingress.host=XXX
```
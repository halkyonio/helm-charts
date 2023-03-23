# Testing charts locally

1. Expose the repository locally using Docker and [ChartMuseum](https://chartmuseum.com/) (utility to serve Helm repositories locally):

```console
docker run --rm -u 0 -it -d -p 8080:8080 -e DEBUG=1 -e STORAGE=local -e STORAGE_LOCAL_ROOTDIR=/charts -v $(pwd)/charts:/charts chartmuseum/chartmuseum:latest
```

The helm repository should be now available at `http://localhost:8080`.

2. Add the local repository using `helm repo add local http://localhost:8080` or update using `helm repo update local`. Verify that the local chart is in the local repository `helm search repo local`.

Now, use the chart as stated in the [usage section](./README.md#usage).
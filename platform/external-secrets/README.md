# External-Secrets Notes

```shell
helm upgrade --install external-secrets external-secrets/external-secrets \
  --namespace external-secrets \
  --create-namespace
```

```shell
kubectl get pods -n external-secrets
```

In order to begin using ExternalSecrets, you will need to set up a SecretStore
or ClusterSecretStore resource (for example, by creating a 'vault' SecretStore).

More information on the different types of SecretStores and how to configure them
can be found in our [Github](https://github.com/external-secrets/external-secrets)

# Cert-Manager Notes

```shell
helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true
```

More information on the different types of issuers and how to configure them
can be found in our [documentation](https://cert-manager.io/docs/configuration/)

For information on how to configure cert-manager to automatically provision
Certificates for Ingress resources, take a look at the `ingress-shim`
[documentation](https://cert-manager.io/docs/usage/ingress/)

For information on how to configure cert-manager to automatically provision
Certificates for Gateway API resources, take a look at the `gateway resource`
[documentation](https://cert-manager.io/docs/usage/gateway/)

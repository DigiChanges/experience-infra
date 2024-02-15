
## Dockerfile

Change version in every build

```bash
docker build --tag "digichanges/nexp:latest" --tag "digichanges/nexp:1.3" .
```

```bash
docker push digichanges/nexp --all-tags
```
## Minikube

When the helm chart is run you can access the nexp-api service with the following command: 

```bash
minikube service nexp-api --url -n nexp-api
```

helm template mi-api-despliegue ./mi-api-chart

## Google Cloud Provider

The helm chart allows you to deploy the application on GCP with Cloudflare as the DNS provider.

### Primeros pasos

#### Create a New Project in GCP
1. Sign in to Google Cloud Console: Go to Google Cloud Console.
2. Create a New Project: Click the navigation menu in the upper-left corner, select "IAM & Admin" > "Manage Resources". Click "CREATE PROJECT".
3. Complete Project Details: Enter a name for your project and select an organization and location if necessary. Click "CREATE."

#### Create a Kubernetes Cluster
1. Enable the Kubernetes Engine API: In the GCP console, go to "Kubernetes Engine" and enable the API if it is not active.
2. Create a Cluster: In “Kubernetes Engine”, go to “Kubernetes Clusters” and click “Create Cluster”.
3. Configure your Cluster: Choose your cluster configuration according to your needs (zone, machine size, number of nodes, etc.) and click "Create".

#### Create a Secret in Secret Manager
1. Enable the Secret Manager API: Go to "API & Services" > "Dashboard" and enable the Secret Manager API if it is not active.
2. Create a Secret: In "Security" > "Secret Manager", click "CREATE SECRET".
3. Configure your Secret: Give your secret a name, add the secret value, and select the appropriate tags and permissions.

#### Create a Service Account with External Secrets Administrator Permissions
1. Create the Service Account: Go to "IAM & Admin" > "Service Accounts", and click on "CREATE SERVICE ACCOUNT".
2. Service Account Details: Enter a name, description and click "CREATE".
3. Assign Roles: In the roles section, assign the "External Secrets Administrator" role or the specific permissions you need.
4. Create the Service Account Key: Once created, click on the service account and go to "Keys". Click "ADD KEY" and choose the key format.

You need to add the e helm repository and then install cert-manager

First you need to install CustomResourceDefinitions

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.3/cert-manager.crds.yaml
```

Then you must add the helm chart.

```bash
helm repo add jetstack https://charts.jetstack.io
```

Finally you install it in the cluster.

```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
```

This way it can be installed in the default `cert-manager` namespace.

You also have to install the external-secret

```bash
helm repo add external-secrets https://charts.external-secrets.io
```

```bash
helm install external-secrets \
   external-secrets/external-secrets \
    -n external-secrets \
    --create-namespace
```

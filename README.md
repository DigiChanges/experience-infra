
## Dockerfile

```bash

```
## Minikube

Cuando se ejecute el helm chart se puede tener acceso al servicio de nexp-api con el siguiente comando: 

```bash
minikube service nexp-api --url -n nexp-api
```

helm template mi-api-despliegue ./mi-api-chart

## Google Cloud Provider

El helm chart te permite desplegar la aplicacion en GCP con Cloudflare como proveedor de DNS.

### Primeros pasos

#### Crear un Proyecto Nuevo en GCP
1. Inicia Sesión en Google Cloud Console: Ve a Google Cloud Console. 
2. Crear un Proyecto Nuevo: Haz clic en el menú de navegación en la esquina superior izquierda, selecciona "IAM & Admin" > "Manage Resources". Haz clic en "CREATE PROJECT". 
3. Completa los Detalles del Proyecto: Ingresa un nombre para tu proyecto y selecciona una organización y una ubicación si es necesario. Haz clic en "CREATE".


#### Crear un Clúster de Kubernetes
1. Habilita la API de Kubernetes Engine: En la consola de GCP, ve a "Kubernetes Engine" y habilita la API si no está activa. 
2. Crear un Clúster: En "Kubernetes Engine", ve a "Clústeres de Kubernetes" y haz clic en "Crear clúster". 
3. Configura tu Clúster: Elige la configuración de tu clúster según tus necesidades (zona, tamaño de máquina, número de nodos, etc.) y haz clic en "Crear".


#### Crear un Secret en Secret Manager
1. Habilita la API del Secret Manager: Ve a "API & Services" > "Dashboard" y habilita la API de Secret Manager si no está activa. 
2. Crear un Secret: En "Security" > "Secret Manager", haz clic en "CREATE SECRET". 
3. Configura tu Secret: Dale un nombre a tu secret, añade el valor del secret y selecciona las etiquetas y permisos adecuados. 

#### Crear una Service Account con Permisos de Administrador de External Secrets
1. Crear la Service Account: Ve a "IAM & Admin" > "Service Accounts", y haz clic en "CREATE SERVICE ACCOUNT". 
2. Detalles de la Service Account: Ingresa un nombre, una descripción y haz clic en "CREATE". 
3. Asignar Roles: En la sección de roles, asigna el rol de "Administrador de External Secrets" o los permisos específicos que necesites. 
4. Crear la Llave de la Service Account: Una vez creada, haz clic en la cuenta de servicio y ve a "Keys". Haz clic en "ADD KEY" y elige el formato de la llave.


Necesitas agregar el repositorio e helm y luego instalar cert-manager

Primero necesitas instalar CustomResourceDefinitions

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.3/cert-manager.crds.yaml
```

Luego debes agregar el chart de helm.

```bash
helm repo add jetstack https://charts.jetstack.io
```

Finalmente lo instalas en el cluster.

```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
```

De esta manera se puede instalar en el namespace por defecto de `cert-manager`.

Tambien se tiene que instalar el external-secret 

```bash
helm repo add external-secrets https://charts.external-secrets.io
```

```bash
helm install external-secrets \
   external-secrets/external-secrets \
    -n external-secrets \
    --create-namespace
```

# 1
- az login
Take the tenant id and put it in an environment: 
    "tenantId": ""

* TENANT_ID=tenantId

- az account list -o table
We are going to need a subscription id:
Name                      CloudName    SubscriptionId                        State    IsDefault
------------------------  -----------  ------------------------------------  -------  -----------
SubscriptionName           AzureCloud   SubscriptionId  Enabled  False

Also create an environment variable for subscriptionId
* SUBSCRIPTION=SubscriptionId

- az account set --subscription $SUBSCRIPTION
With that command we will use this subscription and we don't accidentally do anything to our production subscription.

- SERVICE PRINCIPLE
Environment variable for service principal

* az ad sp create-for-rbac --skip-assignment --name aks-poc-cluster -o json
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name aks-poc-cluster -o json)

        NOTE: Insufficient privileges to complete the operation.

We are going to need two parameters: appId and password

For appId and secret environment later use:
 * SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
 * SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')

Currently service principal that we created has no permission so we need to give it ``Contributor`` permissions to the infrastructure that we want to Terraform to manage.
So for that reason:

`````
    az role assignment create --assignee $SERVICE_PRINCIPAL --scope "/subscriptions/$SUBSCRIPTION --role Contributor
`````
# 2
## Terraform

* After defining the provider:
    - terraform init
    * terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPLE -var serviceprincipal_key="$SERVICE_PRINCIPAL_SECRET" -var tenant_id=TENANT_ID -var subscription_id=$SUBSCRIPTION

### Terraform Modules

* We create the modules folder in our provider folder. We will create the cluster folder in it and define the resources(load balancers,storage, etc..) related to AKS in the ``cluster.tf`` file.

To find out what versions are currently available for your subscription and region
- az aks get-versions --location westeurope --output table

# 3
### SSH-KEY Generate
````
    linux_profile {
        admin_username = var.linux_profile_admin_username
        ssh_key {
            key_data = var.linux_profile_ssh_key
        }
    }
```` 

* SSH-KEY: 
    - ssh-keygen -t rsa -b 4096 -N "<Sup3r.Str0n9.P@ssW0rD!!>" -C "<email@example.com>" -q -f ~/.ssh/id_rsa
    - SSH_KEY=$(cat ~/.ssh/id_rsa.pub)

* terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPLE -var serviceprincipal_key="$SERVICE_PRINCIPAL_SECRET" -var tenant_id=TENANT_ID -var subscription_id=$SUBSCRIPTION -var ssh_key="$SSH_KEY"


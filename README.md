# Azure Kubernetes Service with Terraform

#### Before we run our IaC code, we get some information we need on the Azure Cloud side with the following steps

---------------------------------------------------------

**Getting the required environments for later use.**

* ``az login``

We will use the tenantId for later purposes so we need to take the tenantId from the output ``az login`` command and put it in an environment: 
   
    "tenantId": "<tenant_id>"

* ``TENANT_ID=tenantId``

* ``az account list -o table``


We are going to need a subscriptionId. We'll get it from the ``az login`` command output.


| Name  | CloudName  |  SubscriptionId | State  |  IsDefault |
|---|---|---|---|---|
|  SubscriptionName |  AzureCloud | SubscriptionId |  Enabled |  False |



Also create an environment variable for subscriptionId:

* ``SUBSCRIPTION=SubscriptionId``

---------------------------------------------------------

* ``az account set --subscription $SUBSCRIPTION``

**Note: With above command we will use this subscription and we don't accidentally do anything to our production subscription.**

- Environment variable for service principal

* ``az ad sp create-for-rbac --skip-assignment --name aks-poc-cluster -o json``

``SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment --name aks-poc-cluster -o json)``

        NOTE: Insufficient privileges to complete the operation.
        If we get an output like this, the reason is user has no rights for this command.

We are going to need two parameters one is ``appId`` and the other one is ``password``

**For appId and secret environment run the below command:**

````
  SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
  SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
````

Currently service principal that we created has no permission so we need to give it **Contributor** permissions to the infrastructure that we want to Terraform to manage.
So for that reason:


* ``az role assignment create --assignee $SERVICE_PRINCIPAL --scope "/subscriptions/$SUBSCRIPTION --role Contributor``

## Terraform

#### After assigning the data such as tenantId, subscriptionId,etc.. which we obtained with Azure CLI, into environments, the following commands will be used on the Terraform side.

---------------------------------------------------------

After the provider is defined, we will run the following commands:

````
terraform init
terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPLE -var serviceprincipal_key="$SERVICE_PRINCIPAL_SECRET" -var tenant_id=TENANT_ID -var subscription_id=$SUBSCRIPTION
````

### Terraform Modules

**We create the modules folder in our provider folder. We will create the cluster folder in it and define the resources(load balancers,storage, etc..) related to AKS in the ``cluster.tf`` file.**

---------------------------------------------------------

To find out what versions are currently available for your subscription and region:

* ``az aks get-versions --location westeurope --output table``

---------------------------------------------------------

#### SSH-KEY Generate
````
    linux_profile {
        admin_username = var.linux_profile_admin_username
        ssh_key {
            key_data = var.linux_profile_ssh_key
        }
    }
```` 

**SSH-KEY:**

````
ssh-keygen -t rsa -b 4096 -N "<Sup3r.Str0n9.P@ssW0rD!!>" -C "<email@example.com>" -q -f ~/.ssh/id_rsa
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
````

````
terraform plan -var serviceprinciple_id=$SERVICE_PRINCIPLE -var serviceprincipal_key="$SERVICE_PRINCIPAL_SECRET" -var tenant_id=TENANT_ID -var subscription_id=$SUBSCRIPTION -var ssh_key="$SSH_KEY"
````


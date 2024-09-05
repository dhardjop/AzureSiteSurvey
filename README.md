# AzureSiteSurvey

## Background
The primary objective of this tool is to collect data on Azure resources and perform assessment on Azure tenant. This tool is utilising the Azure resource graph for querying Azure inventory.

## Requirements and Prerequisites
- Contributor role for the queried tenant
- Ability to execute script from Azure Cloud Shell

## Execution Instructions
1. On Azure Portal open the Azure Cloud Shell. If you are on Azure CLI, you need to switch to Powershell
2. Upload SiteSurvey.ps1 script to your storage account
3. Execute the SiteSurvey.ps1
   > ./SiteSurvey.ps1
4. Allow Installation of the Az.ResourceGraph module
5. After the execution of the script, a new CSV file will be created in the storage account which contain the resource breakdown of the queried Azure tenant
6. Download the SiteSurvey.csv file

## Disclaimer
The collected information does not contain any network sensitive information
The output of the query contain only the number of subscriptions, resource groups, type of services and workloads in each Azure region.

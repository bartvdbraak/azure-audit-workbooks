targetScope = 'subscription'

/*
  Environment specific values
*/

@allowed([
  'D' // Development
  'T' // Test
  'A' // Acceptance
  'P' // Production
])
@description('Environment identifier used within resource naming (e.g "P" for Production).')
param environment string

@description('The location of the resource group and other resources (e.g eastus).')
param location string

@allowed(['cus', 'ncus', 'eus', 'wus', 'ne', 'we', 'ea', 'sea', 'cus', 'eus2', 'bjb', 'sha', 'jpe', 'jpw', 'brs', 'ae', 'ase', 'ugi', 'ugv', 'inc', 'ins', 'cnc', 'cne', 'wcus', 'wus2', 'ukw', 'uks', 'ccy', 'ecy', 'gec', 'gne', 'krc', 'frc', 'frs', 'krs', 'ugt', 'uga', 'udc', 'ude', 'acl', 'acl2', 'bjb2', 'sha2', 'uac', 'uan', 'san', 'saw', 'rxe', 'rxw', 'exe', 'exw', 'inw', 'gwc', 'gn', 'szn', 'szw', 'nww', 'nwe', 'sdc', 'sds', 'bse', 'wus3', 'jic', 'jiw'])
@description('Geocode identifier based on location used within resource naming and tagging (e.g. eus).')
param geocode string

@description('Organization identifier used within resource naming and tagging (e.g. contoso).')
param organization string

@description('Project identifier used within resource naming and tagging (e.g. myapp).')
param project string

@description('Serialized JSON data that will be embedded in the workbook.')
param workbookData string

/*
  Resource naming 
*/

var nameFormat = toUpper('${organization}-${project}-${environment}-${geocode}-{0}-{1:N0}')

var tags = {
  environment: environment
  location: location
  project: project
  organization: organization
}

/*
  Resource Group
*/

resource ResourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: format(nameFormat, 'RG', 1)
  location: location
  tags: tags
}

/*
  Azure Workbook
*/

module Workbook 'modules/workbook.bicep' = {
  name: 'Workbook'
  scope: ResourceGroup
  params: {
    nameFormat: nameFormat
    tags: tags
    location: location
    workbookData: workbookData
  }
}

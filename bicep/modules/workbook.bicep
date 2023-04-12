param nameFormat string
param location string
param tags object

@description('GUID used as resource name for the workbook.')
param workbookName string = guid(format(nameFormat, 'WB', 1))

param workbookData string

/*
  Azure Workbook
*/

resource Workbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: workbookName
  tags: tags
  location: location
  kind: 'shared'
  properties: {
    category: 'workbook'
    description: 'Test'
    displayName: 'Test Workbook'
    serializedData: workbookData
    sourceId: 'azure monitor'
    version: 'Notebook/1.0'
  }
}

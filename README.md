<h1 align="center">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/3996360/231779606-e809ac76-6062-4003-81c6-c943850e5554.svg">
        <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/3996360/231779609-94fa2286-8687-4ea2-ac10-be0d9059b303.svg">
        <img src="https://user-images.githubusercontent.com/3996360/231779606-e809ac76-6062-4003-81c6-c943850e5554.svg" alt="Azure Audit Workbooks" width="336">
    </picture>
</h1>

<p align="center">
  <a href="https://github.com/bartvdbraak/azure-audit-workbooks/actions/workflows/build-deploy.yaml"><img src="https://github.com/bartvdbraak/azure-audit-workbooks/actions/workflows/build-deploy.yaml/badge.svg" alt="Build and Deploy to Azure" style="max-width: 100%;"></a>
</p>

## Usage
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbartvdbraak%2Fazure-audit-workbooks.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbartvdbraak%2Fazure-audit-workbooks?ref=badge_shield)


### Deploying the Workbook(s)

To deploy the Workbooks locally, you can use the provided Bicep templates located in the bicep directory. Before deploying, ensure that you have filled in the required parameters in `main.params.json`. You will also need to create a new `.env` file based on `.env.example` and fill in the required values.

To deploy the templates, run the following command:

```bash
cd scripts
./deploy.sh
```

For more information about the Bicep templates and how to customize them, please refer to the [Bicep documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/).

## Workflows

To ensure efficient and automated deployments, we have developed the following Github Action workflows:

### `build-deploy.yaml`

This workflow automates the deployment process for our Azure infrastructure. The workflow is triggered whenever there is a push to the main branch and checks if any changes were made to the Bicep template or workflow. If so, it checks out the code, logs in to Azure, validates the Bicep template, and deploys it.

```mermaid
graph TD;
    A[Changes detected in Bicep/Workbook?] -->|Yes| B[Serialize Workbook data];
    B --> C[Deploy Azure resources];
    C --> D[End];

    subgraph "Job: build-workbook-data"
    B
    end

    subgraph "Job: deploy-azure-resources"
    C
    end
```

In addition, we have implemented `dependabot` to suggest updating new versions of our Github Actions, ensuring that we always have the latest and most secure versions of our dependencies.

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](./LICENSE) file for details.


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbartvdbraak%2Fazure-audit-workbooks.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbartvdbraak%2Fazure-audit-workbooks?ref=badge_large)
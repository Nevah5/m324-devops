# M324 DevOps - Architecture Ref Card 03

## About this project

The Architecture Ref Card 03 application is from M347. It loads jokes from a database and displays it on an HTML page with Thymeleaf. The application is using the spring boot framework with different layers like controller, service, repository, and model. The application is using the H2 database to store the jokes. The application is using the spring boot framework with different layers like controller, service, repository, and model. The application is using the H2 database to store the jokes.

## Setting up the Repository

### Variables

#### Repository secrets

To use the AWS CLI, you will need to have the tokens for AWS stored as a secret.

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_SESSION_TOKEN`
- `GH_PAT` (used to push a tag)

You can find the AWS credentials in the learner lab here:

![AWS Credentials](./images/aws-credentials.png)

> [!IMPORTANT]
> The credentials will change every time you start the lab. So you will need to update the credentials in the GitHub secrets.

For the GitHub PAT (Personal Access Token), navigate into the settings and then create a new fine-grained token. Select the Repository and under `Repository permissions` set the `Contents` set it to `read and write`. After creating, copy the token and paste it into the created secret.

#### Repository variables

-none-

### Environments

Environments allow you to have environment specific variables for a job. You can define the environments in the GitHub repository settings under "Environments".

![GitHub Environments](./images/github-environments.png)

Because we are building a docker image, we want to store that in a repository. We could do that with GitHub (ghcr.io - GitHub Container Registry) or because we are deploying the application within AWS, with ECR (Elastic Container Registry). I created two ECRs. One for the development environment with mutable tags, so tags can be overwritten (snapshot registry). And another one for the production environment, where it is critical to not overwrite older versions to allow a rollback in an emergency (release registry). You can find the needed variables here:

![AWS ECR Variables](./images/aws-ecr-variables.png)

- `AWS_ECR_REGISTRY` (url)
- `AWS_ECR_REPOSITORY_NAME`

![GitHub Environment Variables](./images/github-environment-production.png)

It is also a good practice to define a deployment protection. As you can see in the screenshot under "Deployment branches and tags", I restricted the production environment to run on the `main` branch only.

In my case I setup the variables for the prod and devt environment like following:

| Variable                  | `production`                                 | `development`                                |
| ------------------------- | -------------------------------------------- | -------------------------------------------- |
| `AWS_ECR_REGISTRY`        | 676446025019.dkr.ecr.us-east-1.amazonaws.com | 676446025019.dkr.ecr.us-east-1.amazonaws.com |
| `AWS_ECR_REPOSITORY_NAME` | m324-devops-release                          | m324-devops-snapshot                         |

I haven't set any secrets, because we will define them in AWS for each environment that we deploy to.

### Branch protection

Setting up a branch protection, so that you need a pull request for the default branch and cannot delete the develop branch is a good practice.

![Branch Protection](./images/github-branchprotection.png)

## Setting up a GitHub runner

Under "Settings > Actions > Runners" you can find the link to "[Learn more about self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)".

In my case I will be setting up a runner on repository level.

> [!NOTE]
> TODO

## The pipeline

### Actions

A GitHub Action Action is a reusable step that can be used in a workflow. There are many actions available in the GitHub Marketplace. In my case I created my own to setup the AWS CLI.

#### `setup-aws` Action

Because the runner is a self-hosted runner, I can install the AWS CLI tool per default. This is also the case with many other [tools on the public runners](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2004-Readme.md).

So in my case, I only need to run the `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ECR_REGISTRY` command.

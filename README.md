# GitHub Action to build docusaurus site and Sync S3 Bucket

This is a customized version of the s3-sync-action that uses the [vanilla AWS CLI](https://docs.aws.amazon.com/cli/index.html) to sync a directory (either from your repository or generated during your workflow) with a remote S3 bucket. It also runs the command: yarn run build to build the docusaurs site for deployment.

## Usage

### `main.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: CI
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: turnerlabs/s3-docusaurus-sync-action@master
        env:
          AWS_DEFAULT_REGION: "us-east-1"
          AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          PROJECT_NAME: ${{ secrets.PROJECT_NAME }}
```

### Configuration

The following settings must be passed as environment variables as shown in the example. Sensitive information, especially `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) — otherwise, they'll be public to anyone browsing your repository's source code and CI logs.

| Key                   | Value                                                                                                                                                                                               | Suggested Type        | Required | Notes                                                                    |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- | -------- | ------------------------------------------------------------------------ |
| AWS_DEFAULT_REGION    | The region where you created your bucket. Set to [Full list of regions here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions) | `env`                 | Yes      |                                                                          |
| AWS_S3_BUCKET         | The bucket name you want to publish the site to                                                                                                                                                     | `env` or `secret env` | Yes      | This does not have to be in the secrets but it makes it easier to manage |
| AWS_ACCESS_KEY_ID     | Your AWS Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)                                                                                 | `secret env`          | Yes      |                                                                          |
| AWS_SECRET_ACCESS_KEY | Your AWS Secret Access Key. [More info here.](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)                                                                          | `secret env`          | Yes      |                                                                          |
| PROJECT_NAME          | The project name you set in `siteConfig.js`                                                                                                                                                         | `env` or `secret env` | Yes      | This does not have to be in the secrets but it makes it easier to manage |

# Terraform default template module

Terraform default template module is a useful starting point for those who frequently use Terraform for their projects. Its pre-written required files and format of code saves time and effort and provides a consistent structure for all Terraform projects.

Our organization sets the best practices for creating the terraform template module. The following are the standards that should be followed by the team members and contributors
## Best Practices
- use root folders `.tf` configuration files to create only resources or call sub- modules
- To use the pre-commit tests and other tests please follow the below installation and usages manual
- Terraform tests are created using `terratest` look into the terratest section for the more info
- `examples/complete` is the actual example implementation  where you test your terraform configurations

## Prerequisites

- Terraform version: `x.x.x`
- Provider: `provider_name`

## Getting Started

1. Clone the repository.
2. Move to the `examples/complete` directory.
3. Configure the `backend` for your state with inside `backend.tf`
3. Run `terraform init` to initialize the provider and modules.
4. Create a `dev.tfvars` file and fill in the required variables.
5. Run `terraform plan` to see the changes that will be made.
6. Run `terraform apply` to apply the changes.

## Project Structure

- `main.tf`:  This file is executed by Terraform to create, modify, or destroy the resources defined in it.
- `variables.tf`: Variables are used to provide [`Argument Reference`](https://developer.hashicorp.com/terraform/language/expressions/references)
- `versions.tf`: The versions file is used to manage the terraform providers version.
- `provider.tf`: The provider block is used to define the required providers.
- `outputs.tf`: Outputs are used to provide [`Attribute reference`](https://developer.hashicorp.com/terraform/language/expressions/references)
- `.gitignore`: List of files to ignore in version control.
- `.pre-commit-config.yaml`: Configuration file for pre-commit hooks.
- `_test.go`: Terraform infrastructure end to end test.


## Generate README.md file with .pre-commit-config.yaml configuration
### 1. Install dependencies

<!-- markdownlint-disable no-inline-html -->

* [`pre-commit`](https://pre-commit.com/#install)
* [`checkov`](https://github.com/bridgecrewio/checkov) required for `checkov` hook.
* [`terraform-docs`](https://github.com/terraform-docs/terraform-docs) required for `terraform_docs` hook.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.
* [`Trivy`](https://github.com/aquasecurity/trivy) required for `terraform_trivy` hook.
* [`infracost`](https://github.com/infracost/infracost) required for `infracost_breakdown` hook.
* [`jq`](https://github.com/stedolan/jq) required for `terraform_validate` with `--retry-once-with-cleanup` flag, and for `infracost_breakdown` hook.


<details><summary><b>MacOS/Linux</b></summary><br>

```bash
brew install pre-commit terraform-docs tflint trivy checkov infracost jq
```
</details>



<details><summary><b>Ubuntu 20.04</b></summary><br>

```bash
sudo apt update
sudo apt install -y unzip software-properties-common python3 python3-pip
python3 -m pip install --upgrade pip
pip3 install --no-cache-dir pre-commit
pip3 install --no-cache-dir checkov
curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > terraform-docs.tgz && tar -xzf terraform-docs.tgz terraform-docs && rm terraform-docs.tgz && chmod +x terraform-docs && sudo mv terraform-docs /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep -o -E -i -m 1 "https://.+?/trivy_.+?_Linux-64bit.tar.gz")" > trivy.tar.gz && tar -xzf trivy.tar.gz trivy && rm trivy.tar.gz && sudo mv trivy /usr/bin
sudo apt install -y jq && \
curl -L "$(curl -s https://api.github.com/repos/infracost/infracost/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > infracost.tgz && tar -xzf infracost.tgz && rm infracost.tgz && sudo mv infracost-linux-amd64 /usr/bin/infracost && infracost register
```

</details>

<details><summary><b>Windows 10/11</b></summary>

We highly recommend using [WSL/WSL2](https://docs.microsoft.com/en-us/windows/wsl/install) with Ubuntu and following the Ubuntu installation guide. Or use Docker.

> **Note**: We won't be able to help with issues that can't be reproduced in Linux/Mac.
> So, try to find a working solution and send PR before open an issue.

Otherwise, you can follow [this gist](https://gist.github.com/etiennejeanneaurevolve/1ed387dc73c5d4cb53ab313049587d09):

1. Install [`git`](https://git-scm.com/downloads) and [`gitbash`](https://gitforwindows.org/)
2. Install [Python 3](https://www.python.org/downloads/)
3. Install all prerequisites needed (see above)

Ensure your PATH environment variable looks for `bash.exe` in `C:\Program Files\Git\bin` (the one present in `C:\Windows\System32\bash.exe` does not work with `pre-commit.exe`)

For `checkov`, you may need to also set your `PYTHONPATH` environment variable with the path to your Python modules.
E.g. `C:\Users\USERNAME\AppData\Local\Programs\Python\Python39\Lib\site-packages`

</details>

<!-- markdownlint-enable no-inline-html -->

### 2. Install the pre-commit hook globally

> **Note**: not needed if you use the Docker image

```bash
DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}
```

### 3. Add configs and hooks

Step into the repository you want to have the pre-commit hooks installed and run:

```bash
git init
cat <<EOF > .pre-commit-config.yaml
repos:
- repo: https://github.com/antonbabenko/pre-commit-terraform
  rev: <VERSION> # Get the latest from: https://github.com/antonbabenko/pre-commit-terraform/releases
  hooks:
    - id: terraform_docs
    - id: terraform_fmt
    - id: terraform_checkov
EOF
```

### 4. Run

Execute this command to run `pre-commit` on all files in the repository (not only changed files):

```bash
pre-commit run -a
```

## Available Hooks

There are several [pre-commit](https://pre-commit.com/) hooks to keep Terraform configurations (both `*.tf` and `*.tfvars`) and Terragrunt configurations (`*.hcl`) in a good shape:

<!-- markdownlint-disable no-inline-html -->
| Hook name                                              | Description                                                                                                                                                                                                                                  | Dependencies<br><sup>[Install instructions here](#1-install-dependencies)</sup>      |
| ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `checkov` and `terraform_checkov`                      | [checkov](https://github.com/bridgecrewio/checkov) static analysis of terraform templates to spot potential security issues. [Hook notes](#checkov-deprecated-and-terraform_checkov)                                                         | `checkov`<br>Ubuntu deps: `python3`, `python3-pip`                                   |
| `infracost_breakdown`                                  | Check how much your infra costs with [infracost](https://github.com/infracost/infracost). [Hook notes](#infracost_breakdown)                                                                                                                 | `infracost`, `jq`, [Infracost API key](https://www.infracost.io/docs/#2-get-api-key) |
| `terraform_docs`                                       | Inserts input and output documentation into `README.md`. Recommended. [Hook notes](#terraform_docs)                                                                                                                                          | `terraform-docs`
| `terraform_fmt`                                        | Reformat all Terraform configuration files to a canonical format. [Hook notes](#terraform_fmt)                                                                                                                                               | -                                                                                    |
| `terraform_providers_lock`                             | Updates provider signatures in [dependency lock files](https://www.terraform.io/docs/cli/commands/providers/lock.html). [Hook notes](#terraform_providers_lock)                                                                              | -                                                                                    |
| `terraform_tflint`                                     | Validates all Terraform configuration files with [TFLint](https://github.com/terraform-linters/tflint). [Available TFLint rules](https://github.com/terraform-linters/tflint/tree/master/docs/rules#rules). [Hook notes](#terraform_tflint). | `tflint`                                                                             |
| `terraform_trivy`                                      | [Trivy](https://github.com/aquasecurity/trivy) static analysis of terraform templates to spot potential security issues. [Hook notes](#terraform_trivy)                                                                                      | `trivy`                                                                             |
| `terraform_validate`                                   | Validates all Terraform configuration files. [Hook notes](#terraform_validate)                                                                                                                                                               | `jq`, only for `--retry-once-with-cleanup` flag                                      |

<!-- markdownlint-enable no-inline-html -->

Check the [source file](https://github.com/antonbabenko/pre-commit-terraform/blob/master/.pre-commit-hooks.yaml) to know arguments used for each hook.

## Hooks usage notes and examples

### All hooks: Usage of environment variables in `--args`

You can use environment variables for the `--args` section.

> **Warning**: You _must_ use the `${ENV_VAR}` definition, `$ENV_VAR` will not expand.

Config example:

```yaml
- id: terraform_tflint
  args:
  - --args=--config=${CONFIG_NAME}.${CONFIG_EXT}
  - --args=--module
```

If for config above set up `export CONFIG_NAME=.tflint; export CONFIG_EXT=hcl` before `pre-commit run`, args will be expanded to `--config=.tflint.hcl --module`.

### All hooks: Set env vars inside hook at runtime

You can specify environment variables that will be passed to the hook at runtime.

Config example:

```yaml
- id: terraform_validate
  args:
    - --env-vars=AWS_DEFAULT_REGION="us-west-2"
    - --env-vars=AWS_ACCESS_KEY_ID="anaccesskey"
    - --env-vars=AWS_SECRET_ACCESS_KEY="asecretkey"
```

### Fetch remote template
> After fetching changes from remote base template you need to manually resolve the merge conflicts, and after resolving conflicts and staging you need to run following command:


```bash
git merge --continue

```
> After merging changes you need to add and commit your changes


### Terraform_fmt

1. `terraform_fmt` supports custom arguments so you can pass [supported flags](https://www.terraform.io/docs/cli/commands/fmt.html#usage). Eg:

    ```yaml
     - id: terraform_fmt
       args:
         - --args=-no-color
         - --args=-diff
         - --args=-write=false

### Terraform_providers_lock

1. The hook requires Terraform 0.14 or later.
2. The hook invokes two operations that can be really slow:
    * `terraform init` (in case `.terraform` directory is not initialized)
    * `terraform providers lock`

    Both operations require downloading data from remote Terraform registries, and not all of that downloaded data or meta-data is currently being cached by Terraform.

3. `terraform_providers_lock` supports custom arguments:

    ```yaml
     - id: terraform_providers_lock
       args:
          - --args=-platform=windows_amd64
          - --args=-platform=darwin_amd64
    ```

4. It may happen that Terraform working directory (`.terraform`) already exists but not in the best condition (eg, not initialized modules, wrong version of Terraform, etc.). To solve this problem, you can find and delete all `.terraform` directories in your repository:

    ```bash
    echo "
    function rm_terraform {
        find . \( -iname ".terraform*" ! -iname ".terraform-docs*" \) -print0 | xargs -0 rm -r
    }
    " >>~/.bashrc

    # Reload shell and use `rm_terraform` command in the repo root
    ```

    `terraform_providers_lock` hook will try to reinitialize directories before running the `terraform providers lock` command.

5. `terraform_providers_lock` support passing custom arguments to its `terraform init`:

    ```yaml
    - id: terraform_providers_lock
      args:
        - --tf-init-args=-upgrade

### TFlint

1. `terraform_tflint` supports custom arguments so you can enable module inspection, enable / disable rules, etc.

    Example:

    ```yaml
    - id: terraform_tflint
      args:
        - --args=--module
        - --args=--enable-rule=terraform_documented_variables
    ```

2. When you have multiple directories and want to run `tflint` in all of them and share a single config file, it is impractical to hard-code the path to the `.tflint.hcl` file. The solution is to use the `__GIT_WORKING_DIR__` placeholder which will be replaced by `terraform_tflint` hooks with Git working directory (repo root) at run time. For example:

    ```yaml
    - id: terraform_tflint
      args:
        - --args=--config=__GIT_WORKING_DIR__/.tflint.hcl
    ```

3. By default pre-commit-terraform performs directory switching into the terraform modules for you. If you want to delgate the directory changing to the binary - this will allow tflint to determine the full paths for error/warning messages, rather than just module relative paths. *Note: this requires `tflint>=0.44.0`.* For example:

    ```yaml
    - id: terraform_tflint
          args:
            - --hook-config=--delegate-chdir

### Terraform_trivy

1. `terraform_trivy` will consume modified files that pre-commit
    passes to it, so you can perform whitelisting of directories
    or files to run against via [files](https://pre-commit.com/#config-files)
    pre-commit flag

    Example:

    ```yaml
    - id: terraform_trivy
      files: ^prd-infra/
    ```

    The above will tell pre-commit to pass down files from the `prd-infra/` folder
    only such that the underlying `trivy` tool can run against changed files in this
    directory, ignoring any other folders at the root level

2. To ignore specific warnings, follow the convention from the
[documentation](https://aquasecurity.github.io/trivy/latest/docs/configuration/filtering/).

    Example:

    ```hcl
    #trivy:ignore:AVD-AWS-0107
    #trivy:ignore:AVD-AWS-0124
    resource "aws_security_group_rule" "my-rule" {
        type = "ingress"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ```

3. `terraform_trivy` supports custom arguments, so you can pass supported `--format` (output), `--skip-dirs` (exclude directories) and other flags:

    ```yaml
     - id: terraform_trivy
       args:
         - >
           --args=--format json
           --skip-dirs="**/.terragrunt-cache"
    ```

### Infracost_breakdown

`infracost_breakdown` executes `infracost breakdown` command and compare the estimated costs with those specified in the hook-config. `infracost breakdown` parses Terraform HCL code, and calls Infracost Cloud Pricing API (remote version or [self-hosted version](https://www.infracost.io/docs/cloud_pricing_api/self_hosted)).

Unlike most other hooks, this hook triggers once if there are any changed files in the repository.

1. `infracost_breakdown` supports all `infracost breakdown` arguments (run `infracost breakdown --help` to see them). The following example only shows costs:

    ```yaml
    - id: infracost_breakdown
      args:
        - --args=--path=./env/dev
      verbose: true # Always show costs
    ```
    <!-- markdownlint-disable-next-line no-inline-html -->
    <details><summary>Output</summary>

    ```bash
    Running in "env/dev"

    Summary: {
    "unsupportedResourceCounts": {
        "aws_sns_topic_subscription": 1
      }
    }

    Total Monthly Cost:        86.83 USD
    Total Monthly Cost (diff): 86.83 USD
    ```
    <!-- markdownlint-disable-next-line no-inline-html -->
    </details>

2. Note that spaces are not allowed in `--args`, so you need to split it, like this:

    ```yaml
    - id: infracost_breakdown
      args:
        - --args=--path=./env/dev
        - --args=--terraform-var-file="terraform.tfvars"
        - --args=--terraform-var-file="../terraform.tfvars"
    ```

### Terraform_docs

1. `terraform_docs` and `terraform_docs_without_aggregate_type_defaults` will insert/update documentation generated by [terraform-docs](https://github.com/terraform-docs/terraform-docs) framed by markers:

    ```txt
    <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

    <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
    ```

    if they are present in `README.md`. It is possible to pass additional arguments to shell scripts while running terraform_docs.

2. It is possible to automatically:
    * create a documentation file
    * extend existing documentation file by appending markers to the end of the file (see item 1 above)
    * use different filename for the documentation (default is `README.md`)

    ```yaml
    - id: terraform_lint
    - id: terraform_docs
      args:
        - --hook-config=--path-to-file=README.md        # Valid UNIX path. I.e. ../TFDOC.md or docs/README.md etc.
        - --hook-config=--add-to-existing-file=true     # Boolean. true or false
        - --hook-config=--create-file-if-not-exist=true # Boolean. true or false
    ```

4. You can provide [any configuration available in `terraform-docs`](https://terraform-docs.io/user-guide/configuration/) as an argument to `terraform_doc` hook, for example:

    ```yaml
    - id: terraform_docs
      args:
        - --args=--config=.terraform-docs.yml
    ```

    > **Warning**: Avoid use `recursive.enabled: true` in config file, that can cause unexpected behavior.

5. If you need some exotic settings, it can be done too. I.e. this one generates HCL files:

    ```yaml
    - id: terraform_docs
      args:
        - tfvars hcl --output-file terraform.tfvars.model.

## Testing is done with terratest in GOLANG
TEST: `/test/resource_name_test.go`
 > This code defines a test function to test a Terraform module using the Terratest library.
 The test function first constructs the Terraform options with default retryable errors to handle the most common retryable errors in Terraform testing.

1. Create test folder.
2. Create your terraform configuration inside `/examples/complete` folder
3. create you test file with name ending `_test.go`
4. To configure dependencies,
 ```bash
 run: |
  cd test
  go mod init "<_test.go>"
  go mod tidy
```
5. To run the tests:
```bash
 cd test
 go test -v -timeout 30m
 ```


> *warning*: The test function name should end with `_test.go`

# Github Actions Workflow for Terraform

This GitHub Actions workflow runs when changes are pushed or pulled to "main". The workflow has two jobs: `lint` and `plan_or_apply`.

## Lint Job

The `lint` job has several steps:

1. Check out the code.
2. Set up Terraform and run `terraform fmt --check`.
3. Installs `JQ` and sets up the `AWS credentials`
4. Set up the github repo credentials for the terraform modules
3. Initialize Terraform, perform a security scan with Checkov, and validate Terraform configurations with `terraform validate -no-color`.
4. Run `trivy` for a security scan.
7. Sets up `Sonarqube` Runs the `SonarQube scanning` and `Sonar quality gate check`
6. Runs the end to end `terratest`
5. Set up `infracost` generate the cost from the `/examples/complete` dirs and post the comments in the PR and Lso compares with the previously generated cost and update the cost if any
6. Generate an `Infracost` cost estimate alongside generating the `Infracost diff` on PR branch.
7. Post an Infracost comment if the Infracost diff outcome is 'success' and the event is pull_request.

## Plan_or_Apply Job

The `plan_or_apply` job has several steps:

1. Check out the code.
2. Set up git repo credentials for Terraform modules and set up Terraform.
3. Initialize Terraform and run `terraform plan`.
4. If the plan is successful, upload the plan file, show the plan, and post the plan to the GitHub PR for review.
5. If the plan fails, post the output to the GitHub PR.
6. If the apply is successful, post the apply output to the GitHub PR.
7. If the apply fails, post the apply output to the GitHub PR.

This workflow incorporates Terraform, Checkov, trivy, and Infracost to validate, scan, and estimate the cost of infrastructure changes before being merged.

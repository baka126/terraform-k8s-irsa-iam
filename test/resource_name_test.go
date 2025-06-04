package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func cleanup(t *testing.T, terraformOptions *terraform.Options, tempTestFolder string) {
	terraform.Destroy(t, terraformOptions)
	os.RemoveAll(tempTestFolder)
}

func TestTerraformExample(t *testing.T) {
	// t.Parallel()
	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformStateKey := os.Getenv("terraformS3Key")

	rootFolder := "../"
	terraformFolderRelativeToRoot := "./examples/complete"
	varFiles := []string{"dev.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Lock:     true,
		BackendConfig: map[string]interface{}{
			"bucket":         "adex-terraform-state",
			"key":            terraformStateKey,
			"region":         "us-east-1",
			"dynamodb_table": "adex-terraform-state",
			"acl":            "bucket-owner-full-control",
			"encrypt":        true,
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables and check they have the expected values.
	output := terraform.Output(t, terraformOptions, "id")
	assert.NotNil(t, output)
}

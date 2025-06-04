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



func TestTerraformIAMPolicyAttachment(t *testing.T) {
	terraformStateKey := os.Getenv("terraformS3Key")

	rootFolder := "../"
	terraformFolderRelativeToRoot := "./examples/complete"
	varFiles := []string{"dev.tfvars"}

	tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		VarFiles:     varFiles,
		Lock:         true,
		BackendConfig: map[string]interface{}{
			"bucket":         "example-terraform-state",
			"key":            terraformStateKey,
			"region":         "us-east-1",
			"dynamodb_table": "example-terraform-state",
			"acl":            "bucket-owner-full-control",
			"encrypt":        true,
		},
	})

	defer cleanup(t, terraformOptions, tempTestFolder)

	terraform.InitAndApply(t, terraformOptions)

	policyArn := terraform.Output(t, terraformOptions, "policy_arn")
	assert.NotNil(t, policyArn)
	assert.Contains(t, policyArn, "arn:aws:iam::")
}

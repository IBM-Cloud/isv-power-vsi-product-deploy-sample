# Description
This directory contains the sample Terraform code to create a Power virtual server instance image. 

# Prerequisites

  1. Create a Power Systems Virtual Server Instance. For more information, see [Getting started with IBM Power Systems Virtual Servers](https://cloud.ibm.com/docs/power-iaas?topic=power-iaas-getting-started.  
  2. Create a [SSH key](TODO: link needed).
   
# Verify your custom image to publicly available in all supported regions

  Verify that your custom image is publicly available in all supported regions (also known as a stock image).

  TODO: Need info here...
  
# Create your Terraform template

Before you begin, make sure that you have the following IBM Cloud Identity and Access Management (IAM) permissions:

 * Manager service access role for IBM Cloud Schematics
 * TODO: Need IAM Permissions for Power here...

For more details, see [Creating Terraform templates](https://cloud.ibm.com/docs/schematics?topic=schematics-create-tf-config).  

# Test your Terraform template

To test your template, run the following commands from the Terraform CLI: 

* `terraform init`
* `terraform validate`

For more information, see [Terraform and the IBM Cloud provider plug-in](https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-setup_cli).

# Upload your Terraform template to a GitHub release

Use the [latest isv-power-vsi-product-deploy-sample release](TODO: Link needed here) as an example of how to set up your release. 

**Tip**: Make sure to note the URL of your `.tgz` file.

# Onboard your Terraform template to the IBM Cloud catalog

The onboarding process includes importing your `.tgz` file that you created in the previous section to a private catalog, configuring the deployment values, and then validating the Terraform template. For more details, see [Onboarding a Power virtual server image](TODO: Need link here).

# Publishing a new version

To publish a new version of your image, complete the following steps: 

1. Import the new version as described in the previous Import your custom image to all supported regions section.
2. Edit the `variables.tf` file by updating the stock_image_name variable. 
3. Create an updated GitHub release to create a new `.tgz` file, and note the new URL as previously described in the Create GIT release for artifacts and .tgz section.
4. Onboard the new version in your private catalog as previously described in the Onboard your Terraform template section. 

This directory contains the sample Terraform code to create a Power virtual server instance image. 

## Before you begin

  Verify that your custom image is publicly available in all supported regions (also known as a stock image).

  Make sure that you have the following IBM Cloud Identity and Access Management (IAM) permissions:

   * Manager service access role for IBM Cloud Schematics
   * TODO: Need IAM Permissions for Power here...
  
  TODO: Need info here...

## Required resources

  * Create a Power Systems Virtual Server Instance. For more information, see [Getting started with IBM Power Systems Virtual Servers](https://cloud.ibm.com/docs/power-iaas?topic=power-iaas-getting-started).  
  * Create a [SSH key](TODO: link needed).   
  * Create a [Network](TODO: link needed).
  
## Installing the software

To install the software, select a Power Systems Virtual Server Instance, and then enter a name for the new instance being created, an SSH Key Name and a Network Name or ID for the selected server instance.  

If necessary, modify the optional configuration items related to memory, processors, processory type, and system type.

## Upgrading to a new version

TODO:  Need to verify this.  Can you upgrade these VSI related instances using terraform?

When a new version of an image is available, you're alerted in your Schematics workspace. To upgrade to a new version, complete the following steps:

1. Go to the **Menu** > **Schematics**.
2. Select your workspace name. 
3. Click **Settings**. In the Summary section, your version number is displayed. 
4. Click **Update**.
5. Select a version, and click **Update**.

## Uninstalling the software

Complete the following steps to uninstall a Helm Chart from your account. 

1. Go to the **Menu** > **Schematics**.
2. Select your workspace name. 
3. Click **Actions** > **Destroy resources**. All resources in your workspace are deleted.
4. Click **Update**.
5. To delete your workspace, click **Actions** > **Delete workspace**. 

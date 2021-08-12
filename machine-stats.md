# Machine Stats

## Let's get started

This guide will show you how to install and use Machine Stats for Unix-like
Systems.

Click the **Start** button to move to the next step.

## Project selection

You first need to select a project to host the resources created in this tutorial.

<walkthrough-project-setup></walkthrough-project-setup>

Let's set this project:

```bash
gcloud config set project {{project-id}}
```

## What is Machine Stats?

Before we jump in, let's briefly go over what Machine Stats can do.

Machine Stats is an application which provides a simple and effective way to
gather machine statistics (RAM, Storage, CPU) from a server environment.

Machine Stats for Unix-like Systems leverages
[Ansible](https://www.ansible.com/) to gather facts in a cross-platform way.

Continue on to the next step to install Machine Stats.

## Installation

Install Machine Stats:

```bash
python3 -m pip install machine-stats
```

Make sure that Machine Stats was installed successfully:

```bash
machine-stats --help
```

Next, you’ll create some VM instances.

## Creating VM instances

Let's use Google Cloud Deployment Manager to create a pool of VMs:

1.  Enable Cloud Deployment Manager API:
    ```bash
    gcloud services enable deploymentmanager.googleapis.com
    ```
2.  Enable Compute Engine API:
    ```bash
    gcloud services enable compute.googleapis.com
    ```
3.  Create the deployment:
    ```bash
    gcloud deployment-manager deployments create instance-pool --config deployment/instance-pool.yaml
    ```

Note: After the instances are created, your billing account will start being
charged according to the Compute Engine pricing. You will remove the instances
later to avoid extra charges.

Next, you’ll review the list of VM instances.

## Hosts

First of all let's have a look at the list of the running VMs:

```bash
gcloud compute instances list
```

Next, you'll make it possible to connect to those VMs via SSH.

## SSH connection

To make it possible for Machine Stats to connect to those hosts you need to
generate and provide SSH keys:

```bash
./generate-ssh-key
```

Under the hood it creates all the necessary SSH key files and updates all the VM
instances metadata.

Next, you'll create an inventory file.

## Inventory file

Let's write the list of IPs alongside with SSH key locations to the
`hosts` file:

```bash
./generate-hosts
```

Next, you'll run Machine Stats with the generated inventory file.

## The first run

Now, when you have the `hosts` file ready, let's try to get some information
about those hosts using Machine Stats:

```bash
machine_stats hosts
```

You should see the JSON output with your hosts details.

Next, you'll install Tidal Tools to load Machine Stats data to Tidal Migrations.

## Tidal Tools

Let's install Tidal Tools:

```bash
curl https://get.tidal.sh/unix | bash 
```

Make sure that Tidal Tools installed correctly:

```bash
tidal version
```

Login to your account:

```bash
tidal login
```

Next, you'll sync your servers.

## Syncing your servers

To sync your servers run the following command:

```bash
machine_stats hosts | tidal sync servers
```

Next, you'll learn how to sync your servers periodically.

## Sync servers periodically

Run the shell script as following:

```bash
./repeat-machine-stats
```

The script will run sync for five times with 30 seconds interval between runs.

Open your **Tidal Migrations Platform** and search for one of the hosts on the
**Assess/Servers** page.

## Clean up

To avoid incurring charges to your Google Cloud account for the resources used
in this tutorial, follow this steps.

```bash
gcloud deployment-manager deployments delete instance-pool
```

Type `y` at the prompt:

```terminal
The following deployments will be deleted:
- instance-pool

Do you want to continue (y/N)?
```

The deployment and the resources you created are permanently deleted.

Alternatively, you can delete your Cloud project to stop billing for all the
resources used within that project.

**Caution**: Deleting a project has the following effects:

-   **Everything in the project is deleted.** If you used an existing project
    for this tutorial, when you delete it, you also delete any other work you've
    done in the project. 

-   **Custom project IDs are lost.** When you created this project, you might have
    created a custom project ID that you want to use in the future. To preserve
    the URLs that use the project ID, such as an appspot.com URL, delete
    selected resources inside the project instead of deleting the whole project.

1.  In the Cloud Console, go to the [Manage resources][console-manage-resources]
    page.
2.  In the project list, select the project that you want to delete, and then
    click **Delete**.
3.  In the dialog, type the project ID, and then click **Shut down** to delete
    the project.

## Congratulations

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy> 

You're done!

Here's what you can do next:

* Visit Machine Stats for Unix-like Systems [GitHub page][machine-stats-github].

* Read [Gather Machine Stats][machine-stats-guide] guide.

* Go to [Tidal Tools][tidal-tools] site.

* Learn more about [Tidal Migrations][tidal-migrations].

[console-manage-resources]: https://console.cloud.google.com/iam-admin/projects
[machine-stats-github]: https://github.com/tidalmigrations/machine_stats/tree/master/unix
[machine-stats-guide]: https://guides.tidalmg.com/machine_stats.html
[tidal-tools]: https://get.tidal.sh
[tidal-migrations]: https://tidalmigrations.com

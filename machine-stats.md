# Machine Stats

## Let's get started

This guide will show you how to install and use Machine Stats for Unix-like
Systems.

Click the **Start** button to move to the next step.

## Project selection

You first need to select a project to host the resources created in this tutorial.

<walkthrough-project-setup></walkthrough-project-setup>

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

```bash
gcloud deployment-manager deployments create instance-pool --config deployment/instance-pool.yaml
```

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
gcloud compute instances list --format='value(networkInterfaces[].accessConfigs[0].natIP.notnull().list())' | \
awk '{print $0, "ansible_ssh_private_key_file=~/.ssh/google_compute_engine"}' > hosts
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

<walkthrough-footnote>
The better way to run Machine Stats and Tidal Tools periodically is to use
`cron` or systemd services and timers.
</walkthrough-footnote>

Open your **Tidal Migrations Platform** and search for one of the hosts on the
**Assess/Servers** page.

## Congratulations

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy> 

You're done!

Here's what you can do next:

* Visit Machine Stats for Unix-like Systems [GitHub page][machine-stats-github].

* Read [Gather Machine Stats][machine-stats-guide] guide.

* Go to [Tidal Tools][tidal-tools] site.

* Learn more about [Tidal Migrations][tidal-migrations].

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-create-instance]: walkthrough://spotlight-pointer?cssSelector=#_2rif_create
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[machine-stats-github]: https://github.com/tidalmigrations/machine_stats/tree/master/unix
[machine-stats-guide]: https://guides.tidalmg.com/machine_stats.html
[tidal-tools]: https://get.tidal.sh
[tidal-migrations]: https://tidalmigrations.com

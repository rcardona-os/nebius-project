# nebius-project

#### Prerequsites

- Setup your [billing account](https://docs.nebius.com/signup-billing/sign-up)

- To have [Nebius CLI](https://docs.nebius.com/cli/install) already installed 

Note: this procedure has been tested with CLI version *0.12.36*

```bash
$ nebius version
```
```text
0.12.36
```

#### Create profile
- check that there is an existing profile

```bash
$ nebius profile list
 ```
```text
Error: missing configuration: open /home/user/.nebius/config.yaml: no such file or directory
To configure nebius, run:
	$ nebius profile create
```

- creating [profile](https://docs.nebius.com/cli/reference/profile/create)

Notes: 
- Choose the defaults for this lab, and particularly choose "Federation" if setting up Nebius CLI for personal interactive use.
- An alias "nb" has been created, which points to the "nebius" command.

```bash
$ nb profile create sandbox
```
```text
Set api endpoint: api.eu.nebius.cloud
✔ federation
Set federation endpoint: auth.eu.nebius.com
profile "sandbox" configured and activated
```

- test (sandbox) profile
```bash
$ nb profile list
```
```text
sandbox [default]
```
- associate local profile with parent-id (a.k.a project id)
```bash
$ nb config set parent-id project-< .......... >
```

Where to find parent-id?

![Parent ID](media/profile-parent-id.png)

- check the profile configuration
```bash
$ nb config list
```

----

### Resource Manager to list specific resource types
#### List available hardware options for new VMs
```
$ nb compute platform list
```

#### List all disks
```
$ nb compute disk list
```

#### List GPU clusters
```
$ nb compute gpu-cluster list
```

#### List vpc pool
```
$ nb vpc pool list
```

#### List buckets (Object Storage)
```
$ nb storage bucket list
```

#### List vpc subnets
```bash
$ nb vpc subnet list
```

#### List network_id
```
$ nb vpc subnet list --format json| jq -r '.[].[].spec.network_id'
```

#### List kubernetes clusters
```
$ nb applications v1alpha1 k-8-s-release
```

# nebius-project

#### Prerequsites

- Setup your [billing account](https://docs.nebius.com/signup-billing/sign-up)

- To have Nebius [CLI already installed](https://docs.nebius.com/cli/install)

Note: this procedure has been tested with CLI version *0.12.36*

```bash
(base)  user@node : ~
 ➡ nb version
0.12.36
```

#### Create profile
- check that there is an existing profile

```bash
(base)  user@node : ~
 ➡ nebius profile list

Error: missing configuration: open /home/user/.nebius/config.yaml: no such file or directory
To configure nebius, run:
	$ nebius profile create
 ```

- creating [profile](https://docs.nebius.com/cli/reference/profile/create)

Note: Choose the defaults for this lab, and particulAarly choose "Federation" if setting up Nebius CLI for personal interactive use.

```bash
(base)  user@node : ~
 ➡ nb profile create
profile name: test
Set api endpoint: api.eu.nebius.cloud
✔ federation
Set federation endpoint: auth.eu.nebius.com
Switch to your browser to complete the authentication process. If it did not open automatically, use the following link: https://auth.eu.nebius.com/oauth2/authorize?client_id=nebius-cli&code_challenge=32jgsqo5xi00nsgtg75w4XMG674VCDHEPaQUnuD6OfU&code_challenge_method=S256&redirect_uri=http%3A%2F%2F127.0.0.1%3A64692&response_type=code&scope=openid&state=maeC~~Prty6x8.TTRlLdwewwqnm5qGyK_zPP~
profile "test" configured and activated
```

- test profile
```bash
(base)  user@node : ~
 ➡ nb profile list
test [default]
 ```

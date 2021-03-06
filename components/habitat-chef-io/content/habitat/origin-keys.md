+++
title = "Origin Keys"
description = "Using Origin Keys"

[menu]
  [menu.habitat]
    title = "Origin Keys"
    identifier = "habitat/builder/origin-keys"
    parent = "habitat/builder"
    weight = 20

+++

Creating an origin automatically generates an origin key pair.

Origin key cryptography is asymmetric: it has a public origin key that you can distribute freely, and a private origin key that you should distribute only to members of the origin.

Habitat Builder and Habitat Depot require access to at least the public origin key to verify artifacts uploaded to the origin.

Habitat uses the public origin key to verify the integrity of a downloaded Habitat artifact before installing it.

Habitat only installs artifacts for which it has the public origin key.

## Finding Origin Keys on Builder

You can find your origin keys on the Builder site by navigating to the relevant origin and selecting the **Keys** tab.

<img src="/images/screenshots/origin-keys.png">

## Finding Origin Keys Locally

You'll find your saved private and public origin keys at `~/.hab/cache/keys` on your host(local) machine and  at `/hab/cache/keys` inside the studio environment. To see your existing origin keys, from your host command line, run:

```bash
ls -la ~/.hab/cache/keys
```

```PS
Get-ChildItem C:\hab\cache\keys
```

From within Habitat Studio, run:

```bash
ls -la /hab/cache/keys
```

```PS
Get-ChildItem C:\hab\cache\keys
```

## Creating Origin Keys

Creating an origin key pair on the Habitat Builder site automatically generates two keys, a private origin key and a public origin key. Habitat will use the private origin key to sign your Habitat artifacts when they are created and the public origin key to verify the integrity of artifacts for the origin when they are installed.

You can create an origin key pair during your initial Habitat installation by following the instructions in the `hab cli setup` interaction.
If you've already installed Habitat, you can create keys for additional origins by running `hab origin key generate <ORIGIN>`, where <ORIGIN> is the name for your new Habitat origin, from either the host machine or from within the studio.

To create origin keys from your host machine, use:

```bash
hab origin key generate <ORIGIN>
```

Your keys will be stored in `~/.hab/cache/keys` on Linux systems.

```bash
ls ~/.hab/cache/keys

test-origin-20190416223046.pub
test-origin-20190416223046.sig.key
```

In this case, the origin is named "test-origin". The string of numbers, "20190416223046" show the date and time the key was created, in this case, 2019-04-16 22:30:46. The public key has the file extension `.pub` and the private key has `.sig.key`, since the private key is used for cryptographically signing Habitat artifacts.

## Download Origin Keys from Builder

To download your private or public origin key, select the download icon from the right end of the key details, under the "Actions" heading.

<img src="/images/screenshots/origin-key-download.png">

To get your public origin key from Builder from the command line, use the command:

```bash
hab origin key download <ORIGIN>
```

## Upload Origin Keys to Builder

When you create Habitat origin keys on your workstation or in the Studio with `hab origin key generate <ORIGIN>`, your origin key pairs are stored in that environment. Habitat Builder cannot access origin keys stored on your workstation or in the Studio, which means that you need to upload keys to Builder either to upload or download your Habitat origins.

At the very least, Builder requires the public origin key to verify the integrity of artifacts associated with the origin, so you'll need to upload it. Builder requires the public origin key to upload artifacts for that origin. You can also upload your private origin key to enable Builder to build new artifacts from packages whose plans are linked within the origin.

Upload origin keys through the Builder web interface, or by using the `hab origin key upload` command. Uploading origin keys uses the Habitat access token for authentication.

### Upload Command

The simplest method for uploading your keys is to use the commands:

```bash
hab origin key upload <ORIGIN>
hab origin key upload --secret <ORIGIN>
```

To upload both origin keys at the same time, use:

```bash
hab origin key upload  --secfile <PATH_TO_PRIVATE_KEY> --pubfile <PATH_TO_PUBLIC_KEY>
```

### Import Command

Use `hab origin key import` to read the key from a standard input stream:

```bash
hab origin key import <enter or paste key>
hab origin key import <PATH_TO_KEY>
curl <URL_THAT_RETURNS_KEY> | hab origin key import
```

On a MacOS, you may encounter an upload failure.
To remediate this failure:

 * Check that your `HAB_AUTH_TOKEN` is properly set and initialized
 * Add your `SSL_CERT_FILE` to the environment variables in your interactive shell configuration file, such as your `.bashrc`.

```bash
export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
```

Initialize the setting from the command line with:

```bash
 source ~/.bashrc
```

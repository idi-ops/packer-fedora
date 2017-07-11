
# Packer Templates for Fedora

### Overview

This repository contains templates for Fedora that can create Vagrant boxes
using Packer.

## Current Boxes

* [Fedora 26 (64-bit)](https://atlas.hashicorp.com/inclusivedesign/boxes/fedora26)
* [Fedora 24 (64-bit)](https://atlas.hashicorp.com/inclusivedesign/boxes/fedora24)

## Building the Vagrant Boxes

To build all the boxes, you will need Packer and VirtualBox installed.

A GNU Make `Makefile` drives the process via the following targets:

    make        # Build all the box types (VirtualBox, VMware & Parallels)
    make test   # Run tests against all the boxes
    make list   # Print out individual targets
    make clean  # Clean up build detritus
    
For IDI boxes the following target should be used:

    make virtualbox/fedora26

## Troubleshoot Build Issues

Part of the build process involves operating system installation. In this phase Packer is unable to retrieve logs from the installation tools being used by the operating system; if an error occurs here then the build will fail without meaningful errors. At this point a virtual display can be used to monitor the installation:

    HEADLESS=true make virtualbox/fedora26
    
### Create a New Release

When a new version of Fedora is released the following files will need to be created:

* Vagrantfiles/fedora<version>.Vagrantfile
* fedora<version>.json
* http/ks-fedora<version>.cfg

This ``README.md`` and the ``VERSION`` file will also need to be updated. Any Fedora releases that are [no longer supported upstream](https://fedoraproject.org/wiki/Releases#Current_Supported_Releases) should have their files pruned from this repository.

### Makefile.local Overrides

You can create a `Makefile.local` file alongside the `Makefile` to override
some of the default settings.  The variables can that can be currently
used are:

* CM
* CM_VERSION
* HEADLESS
* \<iso_path\>
* UPDATE

`Makefile.local` is most commonly used to override the default configuration
management tool, for example with Chef:

    # Makefile.local
    CM := chef

Changing the value of the `CM` variable changes the target suffixes for
the output of `make list` accordingly.

Possible values for the CM variable are:

* `nocm` - No configuration management tool (this should be used for IDI and GPII projects)
* `chef` - Install Chef
* `puppet` - Install Puppet
* `salt`  - Install Salt

You can also specify a variable `CM_VERSION`, if supported by the
configuration management tool, to override the default of `latest`.
The value of `CM_VERSION` should have the form `x.y` or `x.y.z`,
such as `CM_VERSION := 11.12.4`

The variable `UPDATE` can be used to perform OS patch management.  The
default is to not apply OS updates by default.  When `UPDATE := true`,
the latest OS updates will be applied.

The variable `HEADLESS` can be set to run Packer in headless mode.
Set `HEADLESS := true`, the default is false.

The variable `PACKER` can be used to set the path to the packer binary.
The default is `packer`.

The variable `ISO_PATH` can be used to set the path to a directory with
OS install images.  This override is commonly used to speed up Packer
builds by pointing at pre-downloaded ISOs instead of using the default
download Internet URLs.

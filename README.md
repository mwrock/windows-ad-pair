# windows_ad_pair

This cookook serves as an example, as illustrated in [this blog post](http://www.hurryupandwait.io/blog/orchestrating-multi-server-tests-in-test-kitchen), for using Test-Kitchen on windows to orchestrate multi node tests.

## Prerequisites

- A recent version of [vagrant](https://www.vagrantup.com/downloads.html) greater than 1.6 and I would strongly recommend even higher to account for various bug fixes and enhancements around windows.
- Either [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or Hyper-V hypervisor
- [git](http://git-scm.com/downloads)
- A ruby environment with [bundler](http://bundler.io/). If you dont have this, I strongly suggest installing the [chefdk](https://downloads.chef.io/chef-dk/).
- Enough local compute resources to run 2 windows VMs. I use a first generation lenovo X1 with an i7 processor, 8GB of ram, an SSD and build 10041 of the windows 10 technical preview. I have also run this on a second generation X1 running Ubuntu 14.04 with the same specs.

## Setup

- Install the vagrant-winrm plugin. Assuming vagrant is installed, this will download and install vagrant-winrm:

```
vagrant plugin install vagrant-winrm
```

- Clone this repo:

```
git clone https://github.com/mwrock/windows-ad-pair.git
```

- At the root of the repo, bundle install the necessary gems:

```
bundle install
```

### Using Hyper-V

To allow Test-Kitchen to use hyper-v you can either:

- Add the provider option to your .kitchen.yml:

```
  driver_config:
    box: mwrock/Windows2012R2Full
    communicator: winrm
    vm_hostname: false
    provider: hyperv
```

- Add an environment variable, `VAGRANT_DEFAULT_PROVIDER`, and assign it the value `hyperv`

### A possible vagrant/hyper-v bug

I've been seeing intermittent crashes in powershell during machine create on the box used in this `.kitchen.yml`. I have not dug into this but I have found that immediately reconverging after this crash consistently succeeds.

## Converge and verify

```
bundle exec rake windows_ad_pair:integration
```

See [this blog post](http://www.hurryupandwait.io/blog/orchestrating-multi-server-tests-in-test-kitchen) for more details.

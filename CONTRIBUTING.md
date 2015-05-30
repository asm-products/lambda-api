# Contributing

Here are some steps for getting setup & started with contributing to Lambda:

1. Go to https://assembly.com and sign up.

2. Introduce yourself on https://assembly.com/lambda/bounties/3. Congrats, you
are now an owner of Lambda!

3. Fork asm-products/lambda-api.

4. Get your development environment set up. Read the **Vagrant Setup** section
below for further instruction.
chat [here](https://assembly.com/chat/lambda)

5. Find an [interesting bounty](https://assembly.com/lambda/bounties) on
Assembly or suggest one in [chat](https://assembly.com/chat/lambda).

6. Complete the bounty on a branch off of the `develop` branch. Your branch should
reference the bounty number and include a short description. For example, if I
take on [this](https://assembly.com/lambda/bounties/5) bounty my branch might be
`5_add_contrib_guides`. No code will be merged without referencing a bounty
number - you should be rewarded for your work.

7. Run `rspec`. Everything should pass and you should have added tests
for your code. Will not be merged in otherwise. Adopt existing testing
precedents in most cases.

8. Run `rubocop`. There should be no errors. If you disagree with rubocop in a
particular instance, feel free to bring it up in your pull request.

9. Issue a PR with your work when it is ready for review. (Note: Only PRs from
those with valid Assembly account will be merged).

10. Once merged, your code will be deployed to http://int.playlambda.com! For
now, this process will be manual. In the future, we'll add CI via Semaphore.

## Vagrant

### Vagrant: setup

1. [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads). Pick the
version that matches your OS under the **VirtualBox platform packages** section.

2. [Install Vagrant](http://www.vagrantup.com/downloads). Pick the package
that matches your OS.

3. `cd` into the root of your lambda-api project directory.

4. Run `vagrant up`.

5. Go grab a coffee. This will provision you VM and take a while.

6. The VM is running an apache server - you can check out the site locally at
`http://192.168.60.66/`.

7. Start hacking!

### Vagrant: crash course

This is by no means intended to be a conprehensive guide to all things Vagrant.
If you want that, feel free to check out
[the docs](https://docs.vagrantup.com/v2/).

* `vagrant up` - This command creates and configures guest machines according
to your `Vagrantfile`.

* `vagrant ssh` - This will ssh you into the vagrant VM. Your project directory
will be kept in sync with the `/vagrant` directory in your vagrant VM. Any
changes you make in your project directory will be reflected in the vagrant VM
and vice versa.

* `vagrant halt` - This command shuts down the running machine Vagrant is
managing. You'll want to do this when ypu are not actively developing Lambda.

* `vagrant reload` - The equivalent of running a `vagrant halt` followed by a
`vagrant up`.

### Vagrant: recommended workflow

I like to do all of my regular development directly in my project directory. I
ssh into the vagrant box and cd into the `/vagrant` directory to run `rake`
tasks, `bundle install`, `rspec`, and `rubocop`.

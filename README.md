# Rails::Uninstaller::Tasks
Quick and dirty plugin to demonstrate restoring a Rails application to
a pristine state so that a different js option can be selected.

## Motivation

For background, see:
[Rails 7 will have three great answers to JavaScript in 2021+](https://world.hey.com/dhh/rails-7-will-have-three-great-answers-to-javascript-in-2021-8d68191b) and [Rails is omakase](https://dhh.dk/2012/rails-is-omakase.html).

Having played with it for a few weeks, I personally am very happy with
Rails without any js bundlers at all, and only sprockets for managing
my assets.  I feel it would be a darn shame if more people didn't give this
configuration a try because they *might* need more later.  Or worse,
people giving it a try and then finding that they have reached a dead end
where they can't addon esbuild later.

But first, backing up.  Here's a relevant excerpt from Rails is omakase:

> That doesn't mean patrons can't express exceptions. Substitutions are allowed, within reason. So you don't like test/unit? No problem, bring your own rspec. Don't care for CoffeeScript as a dessert? Delete a single line from your Gemfile.

To be clear, with Rails 7, you have options.  Built in are four options for JavaScript alone, and three for CSS (which is up to five in the unreleased main branch).

And with CSS, things are mostly fine.  Get started without any CSS framework and want to add tailwindcss?  No problem.  Follow the [two line installation instructions](https://github.com/rails/tailwindcss-rails#installation):

```
./bin/bundle add tailwindcss-rails
./bin/rails tailwindcss:install
```

... and you are up and running!

The problem is with JavaScript.  If you don't chose an JavaScript option when
creating a project, one will be chosen for you.  But if you decide later you
want to add esbuild and do a little googling, you will be lead to
[jsbunding-rails](https://github.com/rails/jsbundling-rails) and may be tempted to run the [installation instructions](https://github.com/rails/jsbundling-rails#installation) provided there.  Don't do it!

The first problem is that importmaps and jsbunding are mutually exclusive options, meaning that you need to uninstall import maps before you can safely install jsbunding-rails.  The second problem is that things like turbo, stimulus, and tailwindcss install differently when import maps is used than when jsbunding is used.

So, you have at this point a fine mess, and at the current time, precious little in the way of documentation or tooling describing how to proceed.

This quick and dirty plugin is a modest step towards addressing that need.  It was put together in less than a day, and hopefully follow-on work will extend this to support the uninstallation of other components and to higher level tasks that will detect what components are already installed, remove them in the correct order, and then reinstall them with a different js configuration.

Ideally, this will not remain as a separate plugin, but will rather migrate into each of the projects where the uninstallation instructions can be maintained in sync with the installation instructions.

## Demo

Following is a script that will 
  * clone rails main from github
  * build a new project with tailwind and importmaps
  * generate a model/view/controller using scaffolding as well as a stimulus controller
  * uninstall tailwindcss, stimulus, turbo, and import maps
  * install esbuild, stimulus, turbo, and import maps

```
rm -rf rutdemo

if [ -e rails ]; then
  cd rails
  git pull
  cd ..
else
  git clone git://github.com/rails/rails.git
fi

./rails/railties/exe/rails new rutdemo -css tailwind --dev
cd rutdemo
./bin/rails generate scaffold book title
./bin/rails generate stimulus check
./bin/rails db:migrate

bundle add rails-uninstaller-tasks --git "https://github.com/rubys/rails-uninstaller-tasks"

./bin/rails tailwindcss:uninstall
./bin/rails stimulus:uninstall
./bin/rails turbo:uninstall
./bin/rails importmap:uninstall

bundle remove tailwindcss-rails
bundle remove importmap-rails

bundle add jsbundling-rails
bundle add cssbundling-rails

./bin/rails javascript:install:esbuild
./bin/rails turbo:install
./bin/rails stimulus:install
./bin/rails css:install:tailwind

./bin/rails stimulus:manifest:update
yarn build
yarn build:css
```

## License
The plugin is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

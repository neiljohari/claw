# Claw

Welcome to Claw, a CLI for UofM teaching staff to help students more effectively.

Claw downloads a student's latest [Autograder](https://autograder.io) submission locally and then prompts the instructor to run all AG tests locally along with the option to sync to CAEN.

## Installation

Run `gem install claw` in your command line.

## Usage

### Obtaining a Token

> Log in to autograder.io in Chrome and open up the developer tools from the Chrome menu (View->Developer->Developer Tools on a Mac).
> Click on a course link.
> In the developer console, click on a request (e.g. my_roles/ or projects/). Under Request Headers, there is an Authorization entry that looks like "Token ".
> Copy the hex string and save it to the file .agtoken in your home directory.
> -- <cite>[autograder-contrib](https://github.com/eecs-autograder/autograder-contrib)</cite>

### Setting Up a Solution Repository

1. Clone a solution repository (like `eecs280staff/<solution repo>`) locally via `git clone`
2. Ensure the solution repo Makefile has an `autograde` target (all EECS280 project repos do)
3. Optionally add a `sync` target to the Makefile. This target should sync _the
   entire_ solution repo to CAEN. An example target would be:

```
# Copy files to CAEN Linux
sync :
	rsync \
  -rtv \
  --delete \
  --exclude '.git*' \
  --filter=':- .gitignore' \
  ./ \
	<your uniqname here>@login.engin.umich.edu:ia-280-p3
```

### Running Claw

In a solution repo, run `claw <project id> <student uniqname>`.

You can determine the project id by navigating to the project on `autograder.io` and looking at the URL.
For instance, in Fall 2020, EECS280's Euchre project was available at [https://autograder.io/web/project/721](https://autograder.io/web/project/721) which means the project id was `721`.

This will download a json file containing all groups of students who have submitted to the Autograder (including those working alone) and then download the given student's latest solution into a directory `./<uniqname>/`.
Subsequent runs will reuse the previously downloaded json file; you should delete this file periodically to keep your list of students up to date.

Claw will then prompt to run all private autograder tests from the repo. It assumes the Makefile has an `autograde` target, and will dump the output to a file called `autograder.io`.

Finally, Claw will prompt the user whether to upload to CAEN. It assumes the Makefile has a `sync` target.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/claw.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# basepolymerit-cli
Command line interface for [basepolymerit](https://github.com/haxpor/basepolymerit)

It will do the following works setting up project ready for NodeJS development that could be published on NPM.

* Grab the latest source files of [basepolymerit](https://github.com/haxpor/basepolymerit) from Github
* Unzip the downloaded .zip file and put all of its content files into current directory that executed script is operating.
* Replace all texts as appeared in basepolymerti for your specified argument of project name and class name (implicitly class name will be processed to use as file name too).
* Clean up un-needed files after processing
* Do `npm install` and `bower install`

# Pre-requisite

The scripts needs the following command line programs to be installed on your machine. Almost all of them are installed already on your machine especially for Linux, and macOS.

* curl
* unzip
* sed
* gsed
* find
* npm

# How to Use

* Execute `curl -s https://raw.githubusercontent.com/haxpor/basepolymerit-cli/master/basepolymerit-cli.sh | bash -s yourProjectName YourComponentClassName` then it will do all the work for you.
   * Note that `yourProjectName` is your project name to use for NPM package, and `YourComponentClassName` is your component class name. The latter one will be further processed and used as component file name in format of lower-case seprating with hyphen as such too i.e. `your-component-class-name`.
* Execute `npm test` to test the project set up. You should see all tests are passed.
* Start your project development.
* Modify `package.json` information as needed when you're ready to publish your component to NPM registry.

# More information?

If you need more information, see [basepolymerit](https://github.com/haxpor/basepolymerit) project for more information of what it can do and offer.

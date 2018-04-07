# Angular CLI
A Docker image for running [Angular CLI](https://github.com/angular/angular-cli)
in a container.
## Benefits
* Eliminate the need to manually confirm that you are running a version of
  Node.js/npm that is compatible with your version of Angular CLI.
* Ensure that all developers are running the same version of the build tools.
* Ensure that the build machine is running the same version of the build tools as the developers.
* Make switching between projects with different versions of the build tools transparent to the developers.
* Ensure that builds are reproducible.

## Usage
1. Create a new Angular CLI project:
    ```sh
    docker run -it --rm -v $(pwd):/code --entrypoint ng samherrmann/angular-cli new my-app
    ```

2. Copy the [npm.sh](npm.sh) script into your project's root directory.

3. Add the following configuration to `angular-cli.json` to make the app
   accessible from the browser on the host machine.
    ```json
      "defaults": {
        "serve": {
          "host": "0.0.0.0"
        }
      }
    ```

4. Use the script to execute Angular CLI commands:
    ```sh
    ./npm.sh run ng g m my-module
    ```
    ```sh
    ./npm.sh run ng g c my-module/my-component
    ```

    The script can also be used to execute `npm` commands:
    ```sh
    ./npm.sh install <my-new-lib>
    ```
    ```sh
    ./npm.sh start
    ```
    ```sh
    ./npm.sh run lint
    ```

### Testing
Add the following configuration to your `karma.conf.js` to be able to leverage
Google Chrome in the container for unit testing:

```js
browsers: ['customChrome'],
customLaunchers: {
  customChrome: {
    base: 'ChromeHeadless',
    flags: [
      '--no-sandbox'
    ]
  }
}
```
The Chrome sandbox needs to be disabled when running inside of a Docker
container because Chrome's sandbox requires more permissions than Docker allows
by default. If there is a need to run the Chrome sandbox, then the container
must be run with the `privileged` flag.

Now unit tests can be executed with the following command:
```sh
./npm.sh run test
```
Test progress and results can be viewed either in the terminal or in a browser
at `localhost:9876`, where `9876` is the port configured in `karma.conf.js`.

### Production Projects
For production projects, I recommend the following:

* Change the `latest` version tag inside the `npm.sh` script to the actual
  version of the image (Example: Replace `latest` with `1.6.2`).
* Check the `npm.sh` script into version control.

Following these recommendations ensures that the builds are reproducible by
always using the same version of the build tools for a given codebase version.

## Development
### Build Image
Run the `./build.sh` script to build an image.

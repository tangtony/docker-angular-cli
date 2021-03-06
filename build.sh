NG_CLI_VERSION="7.3.2"
CHROMIUM_VERSION="68.0.3440.75-r0"

docker build \
  --build-arg NG_CLI_VERSION=$NG_CLI_VERSION \
  --build-arg CHROMIUM_VERSION=$CHROMIUM_VERSION \
  -t samherrmann/angular-cli .

docker tag samherrmann/angular-cli samherrmann/angular-cli:$NG_CLI_VERSION

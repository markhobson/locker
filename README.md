# Locker

Locks Docker image references by digest.

Docker images are typically specified by their name and tag in `Dockerfile`s. Unfortunately tags are mutable which can cause non-deterministic behaviour at a later date. To avoid this, [digests](https://docs.docker.com/engine/reference/commandline/pull/#pull-an-image-by-digest-immutable-identifier) can be used to lock images to an immutable version.

For example, the image `openjdk:8` can be locked down to a specific version using
`openjdk:8@sha256:d2e5ce9a87c571481197229f618d573d183c6eca1fe3a90ab668ca1d625f0ff9`

## Installation

Install locally by running:

```bash
sudo curl -so /usr/local/bin/locker https://raw.githubusercontent.com/markhobson/locker/master/locker
sudo chmod +x /usr/local/bin/locker
```

## Usage

To lock image references in a `Dockerfile`:

```bash
locker Dockerfile
```

## Running tests

The test suite uses [Bats](https://github.com/bats-core/bats-core). To run the test suite:

1. Pull the used test images:
    * `docker pull openjdk`
    * `docker pull oracle/openjdk`
    * `docker pull openjdk:8`
1. Run the tests:

    ```
    npx bats test
    ```

## To do

* Use locally built images in tests to avoid having to pull them
* Ignore images that don't exist locally
* Discard digest to allow relocking files
* Recursive syntax to lock all supported files in a directory
* Unlock flag to revert from digest to tag
* Pull flag to pull newer images before locking
* Support `docker-compose.yml`
* Support AWS CloudFormation templates

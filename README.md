# docker-jib-cli: Jib-CLI container
Jib CLI as docker image for easy execution, for example in CI pipelines.

As Jib CLI from Google is currently only a preview, expect the unexpected.

By default this container uses user id 1000.

This image is provided for arm, arm64 and amd64 architectures.

More information on Jib CLI: https://github.com/GoogleContainerTools/jib/tree/master/jib-cli

## Jib CLI as container
Many build tools like GitLab CI or Drone CI use container to provide build tooling.
Since Jib does not require a docker daemon, it is beneficial to use Jib CLI to build container images.

The following example shows Drone CI with Jib CLI to create the OCI image of an Angular app that was build in a previous step:

```
  - name: publish
    image: trion/jib-cli
    resources:
      requests:
        cpu: 1
        memory: 64Mi
    commands:
      - jib build --build-file=jib/jib.yaml --target=registry.example.com/demo/frontend:${DRONE_COMMIT_SHA:0:7}
    volumes:
    - name: cache
      path: /tmp/.cache/google-cloud-tools-java/
```
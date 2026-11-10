# docker-jib-cli: Jib-CLI container

[Jib CLI](https://github.com/GoogleContainerTools/jib/tree/master/jib-cli) from Google as a docker image
for easy execution, for example in CI pipelines. Jib builds OCI/Docker images without a docker daemon.

Image: `trion/jib-cli` on Docker Hub. Architectures: `amd64`, `arm64`.

## Tags
- `latest`: rebuilt nightly (picks up base image updates)
- `<version>`, e.g. `0.13.0`: pinned Jib CLI version (preferred for reproducible builds)

## Image facts
- Base: `eclipse-temurin:21-jre`; Jib CLI installed in `/opt/jib`, `jib` is on `PATH`
- No `ENTRYPOINT`: run `jib ...` as the command (so CI systems can start a shell)
- Runs as user id `1000`, working directory `/app`, `HOME=/tmp`
- Jib's base-image cache lives in `$HOME/.cache/google-cloud-tools-java/`; mount a volume there to speed up builds
- Also installed: `curl`, `unzip`, `rsync`, `procps`, `ca-certificates`

## Usage
Show help:
```
docker run --rm trion/jib-cli jib --help
```

Build from a jib build file and push to a registry (credentials via `--to-username`/`--to-password`
or an existing docker config):
```
docker run --rm -v "$PWD":/app trion/jib-cli \
  jib build --build-file=jib/jib.yaml --target=registry.example.com/demo/app:1.0 \
  --to-username="$USER" --to-password="$PASS"
```

Other commands: `jib jar` (containerize a jar), `jib war` (containerize a war), `jib build` (from `jib.yaml`).
Use `--target=tar://image.tar` to write a tarball instead of pushing.

### Drone CI example
Jib CLI creating the OCI image of an Angular app built in a previous step:

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

## Maintenance
See [AGENTS.md](AGENTS.md).

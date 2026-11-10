# AGENTS.md

Docker image packaging the Jib CLI (`trion/jib-cli`). No application code.

## Layout
- `Dockerfile`: the only image definition; built for amd64 and arm64 via buildx + QEMU.
- `.github/workflows/build.yml`: builds on push/PR/nightly; pushes `latest` and `<jib version>` only from `master`.
- `.github/dependabot.yml`: updates GitHub Actions and the base image.
- `build.sh`: `VERSION=x.y.z ./build.sh` bumps `JIB_CLI_VERSION` in the Dockerfile, commits and pushes.

## Updating Jib CLI
1. Find the latest release tagged `vX.Y.Z-cli` at https://github.com/GoogleContainerTools/jib/releases.
2. Change `ARG JIB_CLI_VERSION=` in `Dockerfile` (the workflow reads the image tag from this line; keep its format).
3. Update the version mentioned in `README.md` tag examples if desired.
4. Test: `docker build -t jib-test . && docker run --rm jib-test jib --version`.

## Conventions
- Keep the image non-root (uid 1000) and without `ENTRYPOINT`.
- Secrets `DOCKER_USERNAME` / `DOCKER_PASSWORD` are GitHub repo secrets; never commit credentials.

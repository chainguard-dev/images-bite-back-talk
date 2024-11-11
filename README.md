# Images Bite Back

This repo contains the code for my Cloud Native Rejekts talk on Day 2 Build Issues.

It is intended to demonstrate how to:
 - do a multistage build with a distroless Chainguard images
 - push built images and artifacts to a registry
 - handle multi-arch builds
 - pin images and actions to digests
 - sign images with cosign

The repo contains the following:

 - A very simple Go application (nothing much to see here)
 - A [Dockerfile](./Dockerfile) for building the application
 - A [cross.Dockerfile](./cross.Dockerfile) showing how to cross compile
 - A [cross-xx.Dockerfile](./cross-xx.Dockerfile) showing how to leverage xx tools to help with cross compilation
 - [GitHub Actions](./.github/workflows) for building, pushing and signing the image
   - variants for compiling multistage builds with [QEMU](./.github/workflows/build-and-push-qemu.yaml), [cross-compilation](./.github/workflows/build-and-push-cross.yaml) and [dedicated runners](./.github/workflows/build-and-push-runners.yaml)

Both the Actions and Dockerfiles are intended to be a good starting point for creating your own.

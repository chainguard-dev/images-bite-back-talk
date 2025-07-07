# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:3d0406e73a2abf2d1972b2c70ef9efba7bcb6c103c5ae8e3fdd006aeeada25f4 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:092aad9f6448695b6e20333a8faa93fe3637bcf4e88aa804b8f01545eaf288bd
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:9c6b73d7d0f2b555e1dc3424152e0865fe95d9d3b7a3f25931ba99a728a77a83 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:95a45fc5fda9aa71dbdc645b20c6fb03f33aec8c1c2581ef7362b1e6e1d09dfb
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

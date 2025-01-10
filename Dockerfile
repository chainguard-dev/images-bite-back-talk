# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:88919362146ee54cea7aea132c256d2f0581aeeb0b1c2661337ecf99e9dc945b AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:7e1e8a0ed6ebd521f2acfb326a4ae61c2f9b91e5c209dcd0f0e4a5934418a5ec
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

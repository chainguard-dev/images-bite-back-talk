# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:5f80357ddeac4218a5da0d68fd0889cc797b20385cc30951bd86438c45787160 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:95a45fc5fda9aa71dbdc645b20c6fb03f33aec8c1c2581ef7362b1e6e1d09dfb
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

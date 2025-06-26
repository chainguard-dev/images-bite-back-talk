# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:6cdcb9b8f1258b0bef8a323df13353abcd5b5a256c9c02da5e4a3ff03fd47d1e AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:092aad9f6448695b6e20333a8faa93fe3637bcf4e88aa804b8f01545eaf288bd
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

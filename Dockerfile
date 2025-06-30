# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:65c00480d4613547b43f01ff64f27eb48d65478f116289dcdaa743369229c70a AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:092aad9f6448695b6e20333a8faa93fe3637bcf4e88aa804b8f01545eaf288bd
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

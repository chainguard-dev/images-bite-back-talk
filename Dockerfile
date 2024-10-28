# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
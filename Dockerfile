# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:2d2ab8d4be4ce798099b044d3ed11dfc3cbdc7c034d5c67c7a2856094a98f079 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:f5fe67ab41c65f55766d824a2d857a7f56c9058b8e077c43d4d809c467f28df8
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:43812ee0cf50279687a97d66c285fa2af31f1e2def112895c46f1045d2d428e8 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:c9635595e59e9f4a48da16842ce8dd8984298af3140dcbe5ed2ea4a02156db9c
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

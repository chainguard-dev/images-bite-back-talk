# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:1254bc165f6ba8486cdcb473452c1d46f81ae01687fd5436b2c84643cd75ca72 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:b2e1c3d3627093e54f6805823e73edd17ab93d6c7202e672988080c863e0412b
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

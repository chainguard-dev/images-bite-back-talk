# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:0f0612dae300fe06ed8ac945c93b6b84e10e3f099d4d33dfca09cff0887e3a21 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:5497b01f36ef14a5198c0165e50ae6a0006d0c7457d4566f1110257e1c0812ed
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

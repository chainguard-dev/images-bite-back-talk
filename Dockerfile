# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:fa9ef129b35dacc10c80f063f927df0cbb6336d38ef2131fb925048a720346cf AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:d44809cee093b550944c1f666ff13301f92484bfdd2e53ecaac82b5b6f89647d
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

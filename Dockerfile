# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:5e975512438c9de0779d6af9fa05ddb5d2951e95d6e5062efb2ab464153f4e47 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:d44809cee093b550944c1f666ff13301f92484bfdd2e53ecaac82b5b6f89647d
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

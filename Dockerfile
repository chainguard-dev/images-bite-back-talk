# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:8a7e93510143a3a9aab0a7065bd92224e85a378e90811fdc7a8be2b9c677ee4b AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:5ff428f8a48241b93a4174dbbc135a4ffb2381a9e10bdbbc5b9db145645886d5
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:51fcd6edf090b06323262c56ec2957a473db04696f43c3dfb318bf832e618b88 AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:1c785f2145250a80d2d71d2b026276f3358ef3543448500c72206d37ec4ece37
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

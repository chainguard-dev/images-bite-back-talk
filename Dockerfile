# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/go:latest-dev@sha256:cccbb640de21b68f5a5f593e84034c5391089a106bc610e2acc2f3fd0e3aea4e AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:5ff428f8a48241b93a4174dbbc135a4ffb2381a9e10bdbbc5b9db145645886d5
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]

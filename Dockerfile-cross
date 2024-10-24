FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/go:latest-dev AS builder
ARG TARGETOS
ARG TARGETARCH
WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

# See https://mt165.co.uk/blog/static-link-go/ for creating static binaries
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static
COPY --from=builder /work/hello /hello 

ENTRYPOINT ["/hello"]

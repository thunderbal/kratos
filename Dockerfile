FROM golang:latest AS build
ARG VERSION=v1.3.1
RUN useradd -Um build
USER build
WORKDIR /home/build/kratos
RUN git clone --branch ${VERSION} --single-branch --depth 1 https://github.com/ory/kratos.git $HOME/kratos
ENV CGO_ENABLED=0
RUN go mod download && go install -ldflags "-X github.com/ory/kratos/driver/config.Version=${VERSION} -X github.com/ory/kratos/driver/config.Date=`TZ=UTC date -u '+%Y-%m-%dT%H:%M:%SZ'` -X github.com/ory/kratos/driver/config.Commit=`git rev-parse HEAD`" . && strip /go/bin/kratos

FROM scratch
COPY --from=build /go/bin/kratos /bin/kratos
ENTRYPOINT ["/bin/kratos"]
CMD ["help"]
EXPOSE 4433/tcp 4434/tcp
USER 1000:1000
WORKDIR /home/kratos

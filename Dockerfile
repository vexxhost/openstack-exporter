FROM golang:1.18@sha256:50c889275d26f816b5314fc99f55425fa76b18fcaf16af255f5d57f09e1f48da AS build

WORKDIR /

COPY . .

RUN go mod download && go build -o /openstack-exporter .

FROM gcr.io/distroless/base:nonroot@sha256:e00da4d3bd422820880b080115b3bad24349bef37ed46d68ed0d13e150dc8d67 as openstack-exporter

LABEL maintainer="Jorge Niedbalski <j@bearmetal.xyz>"

COPY --from=build /openstack-exporter /bin/openstack-exporter

ENTRYPOINT [ "/bin/openstack-exporter" ]
EXPOSE 9180

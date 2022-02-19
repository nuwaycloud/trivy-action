FROM ghcr.io/cfy9/ubi-minimal:7.9-471

LABEL "com.cloudfy9.image.name"="ghcr.io/cfy9/trivy" \
      "com.cloudfy9.image.description"="Creates trivy docker image" \
      "com.cloudfy9.image.owner"="cloudfy9"

RUN microdnf install -y shadow-utils \
    && groupadd trivy \
    && useradd trivy -g trivy \
    && mkdir -p /apps/trivy \
    && chown -R trivy:trivy /apps/trivy

WORKDIR /apps/trivy

USER trivy

ENTRYPOINT ["./entrypoint.sh"]

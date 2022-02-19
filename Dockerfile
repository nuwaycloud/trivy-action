FROM ghcr.io/cfy9/ubi-minimal:7.9-471

LABEL "com.cloudfy9.image.name"="ghcr.io/cfy9/trivy" \
      "com.cloudfy9.image.description"="Creates trivy docker image" \
      "com.cloudfy9.image.owner"="cloudfy9"

RUN mkdir -p /apps/trivy

COPY "entrypoint.sh" "/apps/trivy/entrypoint.sh"

WORKDIR /apps/trivy

ENTRYPOINT ["/apps/trivy/entrypoint.sh"]

FROM ghcr.io/cfy9/trivy:0.23.0

LABEL "com.cloudfy9.image.name"="ghcr.io/cfy9/trivy:0.23.0" \
      "com.cloudfy9.image.description"="Creates trivy docker image" \
      "com.cloudfy9.image.owner"="cloudfy9"

RUN mkdir -p /apps/trivy

COPY "entrypoint.sh" "/apps/trivy/entrypoint.sh"

WORKDIR /apps/trivy

ENTRYPOINT ["/apps/trivy/entrypoint.sh"]

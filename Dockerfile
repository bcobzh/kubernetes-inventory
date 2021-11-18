FROM docker.io/library/python:3-slim@sha256:3aca24a9167b5bd0e06ed0e10924d34b0ab6d4d5f434bf4ff75c726af2d80ef4
# hadolint ignore=DL3008,DL3013
RUN pip install kubernetes --no-cache-dir invoke boto3 \
    && apt-get update \
    && apt-get install --no-install-recommends -y curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh \
    && rm get_helm.sh
COPY image-files/ /
CMD ["/lbn/inventory.sh"]

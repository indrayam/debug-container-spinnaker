#Download base image alpine
FROM alpine:3.8

# Update Software repository
RUN apk update && apk upgrade && apk add --no-cache git openssh-client curl less openssl tree less bash bash-completion ca-certificates jq coreutils binutils findutils grep vim ncurses redis

# Set the WORKDIR to /root
WORkDIR /root

# Download and Install k8s specific tools
ADD https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl bin/kubectl
ADD https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz src/
ADD https://dl.minio.io/client/mc/release/linux-amd64/mc bin/mc
ADD https://github.com/wercker/stern/releases/download/1.8.0/stern_linux_amd64 bin/stern
COPY spinnaker/kubectx .kubectx
COPY spinnaker/kube-ps1 .kube-ps1
COPY spinnaker/fzf .fzf
COPY spinnaker/.bash_profile .
COPY spinnaker/.bashrc .
COPY spinnaker/.om .
COPY spinnaker/config .kube/
COPY spinnaker/spinnaker.txt src/
COPY spinnaker/complete-setup.sh .

RUN set -x && \
    chmod +x bin/kubectl && \
    chmod +x bin/mc && \
    chmod +x bin/stern && \
    ln -sf ~/.kubectx/completion/kubens.bash /usr/share/bash-completion/completions/kubens && \
    ln -sf ~/.kubectx/completion/kubectx.bash /usr/share/bash-completion/completions/kubectx 



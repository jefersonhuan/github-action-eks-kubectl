FROM python:3.7-alpine

LABEL "com.github.actions.name"="kubectl-eks-cmd"
LABEL "com.github.actions.description"="kubectl for EKS"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="https://github.com/robatwave/github-action-eks-kubectl"
LABEL "homepage"="https://github.com/robatwave/github-action-eks-kubectl"
LABEL "maintainer"="Rob van Oostrum <rvanoostrum@waveapps.com>"

RUN apk add --update --no-cache --virtual .build-deps curl openssl \
    && curl -s -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && curl -s -o /tmp/aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator.sha256 \
    && openssl sha1 -sha256 /usr/local/bin/aws-iam-authenticator \
    && curl -s -o /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.22.6/2022-03-09/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del .build-deps

RUN pip3 install --upgrade awscli

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

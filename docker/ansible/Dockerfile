FROM alpine:3.11.6

LABEL maintainer "ferrari.marco@gmail.com"

RUN apk add --no-cache \
    build-base=0.5-r1 \
    git=2.24.3-r0 \
    libffi=3.2.1-r6 \
    libffi-dev=3.2.1-r6 \
    musl=1.1.24-r2 \
    openssh-client=8.1_p1-r0 \
    openssl=1.1.1g-r0 \
    openssl-dev=1.1.1g-r0 \
    python3=3.8.2-r0 \
    python-dev=3.8.2-r0 \
    sshpass=1.06-r0

# install and update pip
RUN python -m ensurepip \
    && pip install --no-cache-dir --upgrade \
    pip==20.1 \
    pyopenssl==19.1.0

# install Ansible
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
FROM python:3.12-slim

RUN useradd -m mitmproxy
WORKDIR /app

RUN pip install --no-cache-dir mitmproxy

COPY block.py /app/block.py

RUN mkdir -p /home/mitmproxy/.mitmproxy \
    && chown -R mitmproxy:mitmproxy /home/mitmproxy /app

USER mitmproxy

VOLUME ["/home/mitmproxy/.mitmproxy"]

EXPOSE 8080

CMD ["mitmdump", "-s", "/app/block.py", "--mode", "regular", "--listen-host", "0.0.0.0", "--listen-port", "8080"]

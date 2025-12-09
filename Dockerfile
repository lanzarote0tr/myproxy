FROM python:3.12-slim

# Create mitmproxy user with fixed UID 1000
RUN useradd -u 1000 -m mitmproxy

WORKDIR /app

RUN pip install --no-cache-dir mitmproxy

COPY block.py /app/block.py

RUN mkdir -p /home/mitmproxy/.mitmproxy \
    && chown -R 1000:1000 /home/mitmproxy /app

USER mitmproxy

VOLUME ["/home/mitmproxy/.mitmproxy"]

EXPOSE 8080

CMD ["mitmdump", "-s", "/app/block.py", "--mode", "regular", "--listen-host", "0.0.0.0", "--listen-port", "8080"]

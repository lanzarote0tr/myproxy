from mitmproxy import http

def request(flow: http.HTTPFlow):
    print(f"[REQ] {flow.request.method} {flow.request.pretty_url}")

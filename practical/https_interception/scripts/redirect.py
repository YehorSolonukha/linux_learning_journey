from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if "google.com" in flow.request.pretty_host:
        flow.response = http.Response.make(
                200,
                b"<html><body><h1>Hacked!</h1></body></html>",
                {"Content-Type": "text/html"}
        )

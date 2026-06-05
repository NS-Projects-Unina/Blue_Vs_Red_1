#!/usr/bin/env python3
"""
Server HTTP vulnerabile - uso esclusivamente didattico CTF
"""
import http.server
import subprocess
import os
import cgi

UPLOAD_DIR = "/var/www/uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


class VulnHandler(http.server.BaseHTTPRequestHandler):

    def do_GET(self):
        # Esegue un file .py caricato passando il comando via header X-CMD
        if self.path.startswith("/uploads/") and self.path.endswith(".py"):
            filepath = f"/var/www{self.path}"
            if os.path.exists(filepath):
                cmd = self.headers.get("X-CMD", "id")
                try:
                    out = subprocess.check_output(
                        ["python3", filepath, cmd],
                        stderr=subprocess.STDOUT,
                        timeout=5
                    )
                    self.send_response(200)
                    self.send_header("Content-Type", "text/plain")
                    self.end_headers()
                    self.wfile.write(out)
                except Exception as e:
                    self.send_response(500)
                    self.end_headers()
                    self.wfile.write(str(e).encode())
                return

        # Serve la pagina principale
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.send_header("Server", "InternalMgmt/1.0 Python/3.10")
        self.end_headers()
        try:
            with open("/var/www/html/index.html", "rb") as f:
                self.wfile.write(f.read())
        except Exception:
            self.wfile.write(b"<h1>Internal Server</h1>")

    def do_POST(self):
        # Upload senza nessuna validazione del tipo o del nome del file
        if self.path == "/upload":
            ctype, pdict = cgi.parse_header(
                self.headers.get("Content-Type", "")
            )
            if ctype == "multipart/form-data":
                pdict["boundary"] = bytes(pdict["boundary"], "utf-8")
                fields = cgi.parse_multipart(self.rfile, pdict)

                if "file" in fields and "filename" in fields:
                    filename = fields["filename"][0]
                    data = fields["file"][0]
                    dest = os.path.join(UPLOAD_DIR, filename)

                    with open(dest, "wb") as f:
                        if isinstance(data, str):
                            f.write(data.encode())
                        else:
                            f.write(data)

                    os.chmod(dest, 0o755)

                    self.send_response(200)
                    self.send_header("Content-Type", "text/plain")
                    self.end_headers()
                    self.wfile.write(
                        f"[+] Upload OK: /uploads/{filename}\n".encode()
                    )
                    return

        self.send_response(400)
        self.end_headers()
        self.wfile.write(b"Bad request\n")


if __name__ == "__main__":
    print("[*] Internal Management Server avviato su 0.0.0.0:8888")
    server = http.server.HTTPServer(("0.0.0.0", 8888), VulnHandler)
    server.serve_forever()

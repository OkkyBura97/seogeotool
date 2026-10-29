# bookworm: Playwright 1.49 --with-deps asks for font packages that Debian trixie (the new default) no longer has.
FROM python:3.12-slim-bookworm

WORKDIR /app

# Playwright's bundled Chromium with all system libraries it needs (Google Chrome has no Linux arm64 build).
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
 && playwright install --with-deps chromium \
 && rm -rf /var/lib/apt/lists/*

COPY server.py inputs.py index.html ./

# PORT is set by the host (SnapDeploy); 8000 is only the default.
ENV HOST=0.0.0.0 \
    BROWSER_CHANNEL=chromium \
    PORT=8000 \
    PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["python", "server.py"]

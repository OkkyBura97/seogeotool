# bookworm: Playwright 1.49 --with-deps asks for font packages that Debian trixie (the new default) no longer has.
FROM python:3.12-slim-bookworm

WORKDIR /app

# Playwright + Google Chrome (stable, from Google's package) with all system libraries it needs.
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt \
 && playwright install --with-deps chrome \
 && rm -rf /var/lib/apt/lists/*

COPY server.py inputs.py index.html ./

# PORT is set by the host (SnapDeploy); 8000 is only the default.
ENV HOST=0.0.0.0 \
    PORT=8000 \
    PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["python", "server.py"]

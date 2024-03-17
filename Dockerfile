FROM prefecthq/prefect:2-python3.10

USER root

WORKDIR /app/etl

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN pip install -e .

ENTRYPOINT ["/bin/bash", "/app/etl/infra/start-etl-worker.sh"]
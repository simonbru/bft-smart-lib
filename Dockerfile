FROM openjdk:10-jre-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		dumb-init \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

ENTRYPOINT ["dumb-init", "--"]
CMD ["./runscripts/smartrun.sh"]

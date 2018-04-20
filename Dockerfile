FROM openjdk:10-jdk-slim

COPY . /app
WORKDIR /app
# RUN rm -f config/currentView
CMD ["./runscripts/smartrun.sh"]

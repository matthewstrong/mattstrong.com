FROM jojomi/hugo AS build1
ARG baseurl
COPY home /src
WORKDIR /src
RUN hugo -d /tmp/ --baseURL=https://$baseurl/

FROM jojomi/hugo AS build2
ARG baseurl
COPY resume /src
WORKDIR /src
RUN hugo -d /tmp/ --baseURL=https://$baseurl/resume/

FROM nginx:latest
COPY --from=build1 /tmp /usr/share/nginx/html/
COPY --from=build2 /tmp /usr/share/nginx/html/resume/

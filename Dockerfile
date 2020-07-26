FROM jojomi/hugo AS build1
COPY home /src
WORKDIR /src
RUN hugo -d /tmp/ --baseURL=https://localhost/

FROM jojomi/hugo AS build2
COPY resume /src
WORKDIR /src
RUN hugo -d /tmp/ --baseURL=https://localhost/resume/

FROM nginx:latest
COPY --from=build1 /tmp /usr/share/nginx/html/
COPY --from=build2 /tmp /usr/share/nginx/html/resume/

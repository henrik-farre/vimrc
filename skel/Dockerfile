# https://rock-it.pl/how-to-write-excellent-dockerfiles/
# https://hynek.me/articles/docker-signals/
# 1. Write .dockerignore
# 2. Container should do one thing
# 3. Merge multiple RUN commands into one
# 4. Remove unneeded files after each RUN step
# 5. Use proper base image
# 6. Set WORKDIR and CMD
# 7. Use ENTRYPOINT (optional)
# 7.1 Use entrypoint format: ENTRYPOINT ["/app/bin/your-app", "arg1", "arg2"]
# 8. Use "exec" inside entrypoint script
# 8.1 Don’t pipe your application’s output. (else it will spawn in a subshell)
# 9. Prefer COPY over ADD
# 10. Optimize COPY and RUN
# 11. Specify default environment variables, ports and volumes

FROM alpine:latest
MAINTAINER hfar@tv2.dk

# ARG VCS_REF="local"
# LABEL org.label-schema.vcs-ref=$VCS_REF \
#       org.label-schema.vcs-url="https://github.com/something/repo.git"

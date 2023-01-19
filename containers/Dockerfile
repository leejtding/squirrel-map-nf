## base container
FROM rocker/tidyverse as base_container
USER root
RUN apt-get update \
    && apt-get install --yes rename tini procps curl \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


ENTRYPOINT ["tini", "--"]
CMD ["/bin/bash"]

## main container
FROM base_container
# adding opencontainer labels to link registry to github repository
LABEL org.opencontainers.image.title="squirrel-map-nf"
LABEL org.opencontainers.image.description="bst 270 course exercise"
LABEL org.opencontainers.image.url="https://github.com/violafanfani/squirrel-map-nf"
LABEL org.opencontainers.image.documentation="https://github.com/violafanfani/squirrel-map-nf"
LABEL org.opencontainers.image.source="https://github.com/violafanfani/squirrel-map-nf"
LABEL org.opencontainers.image.vendor="violafanfani"
LABEL org.opencontainers.image.authors="Viola Fanfani"
LABEL org.opencontainers.image.revision="v0.0.3"


## install R spatial packages && cleanup 
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "install.packages('ggmap')"
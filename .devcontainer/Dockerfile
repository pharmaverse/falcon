ARG VARIANT="latest"

FROM rocker/r-ver:${VARIANT}

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install curl \
                       gdebi-core \
                       git \
                       pandoc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
# install quarto
ENV QUARTO_VERSION="1.2.262"
ENV FILE="quarto.deb"
RUN curl -o $FILE -L "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
RUN gdebi -n $FILE
RUN rm $FILE


RUN install2.r languageserver \
    devtools \
    && rm -rf /tmp/downloaded_packages

CMD ["R"]
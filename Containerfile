FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN apt update -qq && \
    apt install libgdal-dev libproj-dev libgeos-dev libudunits2-dev libnode-dev libcairo2-dev libnetcdf-dev -y && \
    apt install libglu1-mesa-dev freeglut3-dev mesa-common-dev -y && \
    apt-get clean

#Just install painful things with mamba. 
RUN mamba install -y -c conda-forge r-ncdf4 r-anytime r-berryFunctions r-broom r-devtools r-fixest r-ggplot2 r-ggrepel r-ggthemes r-gt r-gt r-haven r-here r-httr r-janitor r-kableextra r-knitr r-lmtest r-lubridate r-maps r-modelsummary r-nycflights13 r-pacman r-pillar r-png r-polite r-proftools r-quantmod r-readxl r-rvest r-sandwich r-scales r-stargazer r-tidyverse r-titanic r-usethis r-viridis && \
    mamba clean --all

RUN R -e "install.packages(c('freshr'), repos = 'http://cran.us.r-project.org', Ncpus = parallel::detectCores())"

# Copy in homebrewed packages and install them. 
COPY ./*.tar.gz ./
RUN R -e "install.packages(c('recessionShadingPackage2023.tar.gz', 'UCSB.ECON.145.tar.gz'), repos = NULL, type='source')"

USER $NB_USER


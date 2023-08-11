FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN apt update -qq && \
    apt install libgdal-dev libproj-dev libgeos-dev libudunits2-dev libnode-dev libcairo2-dev libnetcdf-dev -y && \
    apt install libglu1-mesa-dev freeglut3-dev mesa-common-dev -y && \
    apt-get clean

#Just install painful things with mamba. 
RUN mamba install -y -c conda-forge --freeze-installed r-ncdf4 && \
    mamba clean --all

RUN R -e "install.packages(c('anytime', 'berryFunctions', 'broom', 'devtools', 'fixest', 'freshr', 'ggplot2', 'ggrepel', 'ggthemes', 'gt', 'haven', 'here', 'httr', 'janitor', 'jasonlite', 'kableExtra', 'knitr', 'lmtest', 'lubridate', 'lucid', 'magritter', 'maps', 'modelsummary', 'Ncmisc', 'nycflights13', 'pacman', 'pfdftools', 'png', 'polite', 'proftools', 'quantmod', 'readxl', 'rvest', 'sandwich', 'scales', 'stargazer', 'tabulizer', 'tidyverse', 'titanic', 'usethis', 'viridis'), repos = 'http://cran.us.r-project.org', Ncpus = parallel::detectCores())"



# Copy in homebrewed packages and install them. 
COPY ./*.tar.gz ./
RUN R -e "install.packages(c('recessionShadingPackage2023.tar.gz', 'UCSB.ECON.145.tar.gz'), repos = NULL, type='source')"

USER $NB_USER


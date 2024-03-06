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

RUN R -e "install.packages(c('anytime', 'berryFunctions', 'broom', 'devtools', 'fixest', 'freshr', 'ggplot2', 'ggrepel', 'ggthemes', 'gt', 'haven', 'here', 'httr', 'janitor', 'kableExtra', 'knitr', 'lmtest', 'lubridate', 'lucid', 'maps', 'modelsummary', 'nycflights13', 'pacman', 'png', 'polite', 'proftools', 'quantmod', 'readxl', 'rvest', 'sandwich', 'scales', 'stargazer', 'tidyverse', 'titanic', 'usethis', 'viridis'), repos = 'https://cran.us.r-project.org', Ncpus = parallel::detectCores())"



# Copy in homebrewed packages and install them. 
COPY ./*.tar.gz ./
RUN R -e "install.packages(c('recessionShadingPackage2023.tar.gz', 'UCSB.ECON.145.tar.gz'), repos = NULL, type='source')"

USER $NB_USER


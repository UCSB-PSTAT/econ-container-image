FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

RUN apt update -qq && \
    apt install libnetcdf-dev -y && \
    apt install lib32gcc-10-dev -y && \
    apt-get clean

# Removing some packages that are probably duplicated
RUN R -e "install.packages(c('anytime', 'berryFunctions', 'broom', 'devtools', 'fixest', 'freshr', 'ggplot2', 'ggrepel', 'ggthemes', 'gt', 'haven', 'here', 'httr', 'janitor', 'jasonlite', 'kableExtra', 'knitr', 'lmtest', 'lubridate', 'lucid', 'magritter', 'maps', 'modelsummary', 'ncdf4', 'Ncmisc', 'nycflights13', 'pacman', 'pfdftools', 'png', 'polite', 'proftools', 'quantmod', 'readxl', 'rvest', 'sandwich', 'scales', 'stargazer', 'tabulizer', 'tidyverse', 'titanic', 'usethis', 'viridis'), repos = 'http://cran.us.r-project.org', Ncpus = parallel::detectCores())"

# Copy in homebrewed packages and install them. 
COPY ./*.tar.gz ./
RUN R -e "install.packages(c('recessionShadingPackage2023.tar.gz', 'UCSB.ECON.145.tar.gz'), repos = NULL, type='source')"

USER $NB_USER


FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

# Removing some packages that are probably duplicated
RUN R -e "install.packages(c('anytime', 'berryFunctions', 'broom', 'devtools', 'fixest', 'ggplot2', 'ggrepel', 'ggthemes', 'haven', 'here', 'httr', 'janitor', 'jasonlite', 'kableExtra', 'knitr', 'lmtest', 'lubridate', 'lucid', 'magritter', 'maps', 'modelsummary', 'ncdf4', 'Ncmisc', 'nycflights13', 'pacman', 'pfdftools', 'png', 'polite', 'proftools', 'quantmod', 'readxl', 'recessionShadingPackage', 'rvest', 'sandwich', 'scales', 'stargazer', 'tabulizer', 'tidyverse', 'titanic','usethis', 'viridis'), repos = 'http://cran.us.r-project.org', Ncpus = parallel::detectCores())"

USER $NB_USER


## To pull this image from the GitHub Container Repo, just do:
##
##   sudo docker pull ghcr.io/joshobrien/docker-r2u-spatial
##
## Build it with:
##
##   docker build . -t r2u-spatial:latest

FROM eddelbuettel/r2u:jammy

RUN apt-get update \
    && sudo apt-get install emacs -y \
    && sudo apt-get install tmux -y \
    ## Provision with spatial and other R packages
    ## (1) This in https://hub.docker.com/r/rocker/geospatial
    && install2.r RColorBrewer RNetCDF classInt deldir gstat \
    ## && install2.r geoR RandomFields \ ## ARCHIVED
    && install2.r hdf5r lidR mapdata maptools mapview ncdf4 proj4 \
    && install2.r raster rgdal rgeos sf sp spacetime spatstat spatialreg \
    && install2.r spdep stars tmap geosphere \
    ## (2) My CRAN additions
    && install2.r fs data.table drat ggplot2 RColorBrewer zip \
    && install2.r ggspatial ctmm amt tlocoh gdalUtilities \
    && install2.r rasterDT rasterVis sfheaders \
    && install2.r move gpclib pbapply \
    ## (3) My drat additions
    ## && echo 'drat::addRepo("JoshOBrien")' >> ${R_HOME}/etc/Rprofile.site \
    && echo 'drat::addRepo("JoshOBrien")' >> /usr/lib/R/etc/Rprofile.site \
    && Rscript -e 'install.packages("tlocoh", dependencies=TRUE, repos=c("http://R-Forge.R-project.org", "http://cran.cnr.berkeley.edu"))' \
    ## && r -e 'install.packages("chhrTools", repos="https://JoshOBrien.github.io/drat")' \
    && install2.r chhrTools spatialToolsJOB BHSdataWinecup 

CMD ["bash"]

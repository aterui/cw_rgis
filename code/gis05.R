if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               terra,
               tidyterra,
               mapview,
               stars,
               here)


# crop --------------------------------------------------------------------

## us-wide precipitation layer
(spr_prec <- rast("data/spr_prec_us.tif"))

## visualization
# ggplot() +
#   geom_spatraster(data = spr_prec)

## ext returns the extent of the layer
ext(spr_prec)

## crop function, direct entry of lat/lon
## order matters: c(xmin, xmax, ymin, ymax)
spr_prec_crop <- crop(x = spr_prec,
                      y = c(-80, -75, 34, 37))

ext(spr_prec_crop)

## check coverage visually
sf_nc_county <- readRDS("data/sf_nc_county.rds")

ggplot() +
  geom_spatraster(data = spr_prec_crop) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

## use vector layer as a mask layer
## no need to enter raw lat/lon values directly
## crop function extracts the extent from the vector layer
spr_prec_nc <- crop(x = spr_prec,
                    y = sf_nc_county)

ggplot() +
  geom_spatraster(data = spr_prec_nc) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)


# merge -------------------------------------------------------------------

spr_nw <- rast("data/spr_prec_ncnw.tif") # Northwest NC
spr_ne <- rast("data/spr_prec_ncne.tif") # Northeast NC
spr_sw <- rast("data/spr_prec_ncsw.tif") # Southwest NC
spr_se <- rast("data/spr_prec_ncse.tif") # Southeast NC

## visualize northwest
ggplot() +
  geom_spatraster(data = spr_nw) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

## use merge() function
spr_n <- merge(spr_nw, spr_ne)

ggplot() +
  geom_spatraster(data = spr_n) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

## compare extent between spr_nw and spr_n
ext(spr_nw)
ext(spr_n)

## merge multiple raster layers
## 1st step: create a list of raster layers
list_spr <- list(spr_ne,
                 spr_nw,
                 spr_se,
                 spr_sw)

spr_col <- sprc(list_spr)
spr_merge <- merge(spr_col)

## check output after merging
ggplot() +
  geom_spatraster(data = spr_merge) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25)

writeRaster(spr_merge, 
            filename = "data/spr_prec_nc.tif",
            overwrite = TRUE)


# stack -------------------------------------------------------------------

spr_prec_nc <- rast("data/spr_prec_nc.tif")
spr_tmp_nc <- rast("data/spr_tmp_nc.tif")

spr_pt_nc <- c(spr_prec_nc,
               spr_tmp_nc)

print(spr_pt_nc)

## access each layer separately
spr_pt_nc$precipitation
spr_pt_nc$temperature


# reprojection ------------------------------------------------------------

print(spr_prec_nc)

## reprojection for raster
spr_prec_nc_proj <- project(x = spr_prec_nc,
                            y = "EPSG:32617",
                            method = "bilinear")


# exercise ----------------------------------------------------------------

## merge raster files
spr_tmp1 <- rast("data/spr_tmp_ncnw.tif")
spr_tmp2 <- rast("data/spr_tmp_ncne.tif")
spr_tmp3 <- rast("data/spr_tmp_ncsw.tif")
spr_tmp4 <- rast("data/spr_tmp_ncse.tif")

list_tmp <- list(spr_tmp1,
                 spr_tmp2,
                 spr_tmp3,
                 spr_tmp4)

spr_tmp_col <- sprc(list_tmp)
spr_merge <- merge(spr_tmp_col)

ggplot() + 
  geom_spatraster(data = spr_merge) +
  geom_sf(data = sf_nc_county,
          alpha = 0.2)

## crop raster
sf_camden <- sf_nc_county %>% 
  filter(county == "camden")

spr_tmp_camden <- crop(x = spr_merge,
                       y = sf_camden)

ggplot() +
  geom_spatraster(data = spr_tmp_camden) +
  geom_sf(data = sf_nc_county,
          alpha = 0.25) +
  theme_bw()

## reprojection
project(x = spr_tmp_camden,
        y = "EPSG:32618")

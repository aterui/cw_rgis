#' Coordinate Reference System
if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)

# get fish site data
df_fish <- read_csv("data/data_finsync_nc.csv")
print(df_fish)

# remove duplicates in the data
sf_site <- df_fish %>% 
  distinct(site_id, lon, lat) %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs = 4326)

# mapping
mapview(sf_site)

# export
saveRDS(sf_site, "data/sf_finsync_nc.rds")




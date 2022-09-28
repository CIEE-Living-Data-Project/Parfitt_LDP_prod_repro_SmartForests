# Ian Parfitt 2022-09-26
# Weather data exploration

# import libraries using groundhog

library(groundhog)
groundhog.library(tidyverse, date = "2022-04-20") # 'date' must be at least two days ago. Using a previous R version
groundhog.library(lubridate, date = "2022-04-20")



### Import files ###

## what files are in the data folder?
myfiles <- list.files(path = "./data", pattern = "*.csv", full.names = TRUE)
myfiles

# import all tables as separate data frames, remove file path and file extensions (.csv)
list2env(
  lapply(
    setNames(myfiles, 
             make.names(gsub(".*dev_", "", 
                             tools::file_path_sans_ext(myfiles)))), 
    read.csv), 
  envir = .GlobalEnv)

mean(site_info$site_elevation)
range(site_info$site_elevation)
boxplot(site_info$site_elevation)

# ggplot(aes())
select(site_info, site_id, site_name, site_elevation) %>%
  # left_join(select(weather_data0, site_id, temperature), by = "site_id") %>%
  group_by(site_id, site_name) %>%
  # summarize(mean_temperature = mean(temperature)) %>%
  summarize(mean_elevation = mean(site_elevation)) %>%
  ggplot(aes(x=site_name, y=mean_elevation)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

select(site_info, site_id, site_name, site_elevation) %>%
  # create new column for Location using tidyr::seperate
  separate(col = site_name,
           into = c("location", "station"),
           sep = "_", remove = FALSE) %>%
  # left_join(select(abundance, bromeliad_id, bwg_name), by = "bromeliad_id") %>%
  group_by(location, site_elevation) %>%
  summarize(mean_elevation = mean(site_elevation)) %>%
  # count(bromeliad_id) %>%
  # rename(invert_richness = n) %>%
  ggplot(aes(x=location, y=mean_elevation)) +
  geom_boxplot()

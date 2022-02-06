#### Preamble ####
# Purpose: Load data from Open Data Toronto Portal and some Data Exploration
# Author: Ka Chun Mo 1004764873
# Data: 6 Febuary 2021
# Contact: franco.mo@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Install the packages in the Workspace Setup section below

#### Workspace Setup ####
library(haven)
library(tidyverse)
library(opendatatoronto)
library(dplyr)

#### Load Data ####
# Get package
package <- show_package("247788f6-ca20-42e8-b00f-894ac43053e5")
package

# Get all resources for this package
resources <- list_package_resources("247788f6-ca20-42e8-b00f-894ac43053e5")

# Load the resources
data <- filter(resources, row_number()==1) %>% get_resource()
data

#### Data Exploration ####

# Count crime by year 
count_crime_by_year <- data |> 
  mutate(year = format(reportedda, "%Y")) |>
  group_by(year) |>
  count()

count_crime_by_year_ordered <- 
  count_crime_by_year[with(count_crime_by_year, order(year)), ]

# Count crime by year and month
count_crime_by_year_month <- data |> 
  mutate(month = format(reportedda, "%m"), year = format(reportedda, "%Y")) |>
  group_by(month, year) |>
  count()  |>
  st_drop_geometry()

count_crime_by_year_month_ordered <- 
  count_crime_by_year_month[with(count_crime_by_year_month, order(year, month)), ]
  

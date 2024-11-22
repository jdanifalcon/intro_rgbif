# Instalación de paquetes si no los tienes
if (!require(rgbif)) install.packages("rgbif")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(maps)) install.packages("maps")
if (!require(dplyr)) install.packages("dplyr")
if (!require(mapdata)) install.packages("mapdata")

if (!require(sf)) install.packages("sf")
if (!require(rnaturalearth)) install.packages("rnaturalearth")
if (!require(rnaturalearthdata)) install.packages("rnaturalearthdata")

# Carga de las bibliotecas
library(rgbif)
library(ggplot2)
library(maps)
library(dplyr)
library(mapdata)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Búsqueda de datos de colibríes (Trochilidae) con coordenadas en México
hummingbird_data <- occ_search(
  scientificName = "Trochilidae",
  country = "MX", # Filtro para México
  limit = 2000,   # Puedes ajustar el límite
  hasCoordinate = TRUE
)

# Extracción de los datos de interés
data <- hummingbird_data$data %>%
  select(decimalLatitude, decimalLongitude, species)

# Carga de los datos del mapa de México
mexico_map <- map_data("world", region = "Mexico")

# Visualización de la distribución en un mapa de México
ggplot() +
  geom_polygon(data = mexico_map, aes(x = long, y = lat, group = group), fill = "lightgrey", color = "white") +
  geom_point(data = data, aes(x = decimalLongitude, y = decimalLatitude, color = species), alpha = 0.5) +
  scale_color_viridis_d() +
  coord_fixed(1.3) + # Ajusta la proporción para que se vea mejor
  theme_minimal() +
  labs(
    title = "Distribución de Colibríes en México (Familia Trochilidae)",
    x = "Longitud",
    y = "Latitud",
    color = "Especie"
  )

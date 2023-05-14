library(ggmap)
library(ggplot2)
library(ggrepel)

milestones.coords = data.frame(
  lat = c(28.53551, 21.1458, 30.73331, 12.06239, 10.16315),
  lon = c(77.39102, 79.08815, 76.77941, 78.58567, 76.64127),
  city = c(
    "Noida",
    "Nagpur",
    "Chandigarh",
    "Katpadi",
    "Kerala"
  ),
  remark = c(
    "Fastest adoption of Paytm by small vendors",
    "Fastest adoption of Paytm by small vendors",
    "ATMs per capita frontrunner",
    "Fastest growth of digital payments",
    "Winner of three Digital India awards"
  )
)

# Organize cities in the key by latitude (decreasing)
milestones.coords$city = factor(milestones.coords$city, levels = milestones.coords[order(-milestones.coords$lat), "city"])

# Call register_google() with Maps API key
map = get_map(location = "India", zoom = 5)
map = ggmap(map)
map = map +
  geom_point(data = milestones.coords,
             aes(x = lon, y = lat, color = city),
             size = 5) +
  geom_label_repel(
    data = milestones.coords,
    aes(x = lon, y = lat, label = remark),
    box.padding = 1,
    segment.size = 1
  ) +
  labs(
    x = "Longitude",
    y = "Latitude",
    title = "State of Digital Payments in India",
    subtitle = "A variety of Indian states have seen rapid growth in digital financial infrastructure.",
    color = "Location"
  ) +
  theme(legend.position = "bottom")
ggsave("plots/milestones.png", map)

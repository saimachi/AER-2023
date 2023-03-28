require("ggplot2")
require("scales")

banknotes.denominations = data.frame(
  year = c(rep("2016", 7), rep("2018", 8)),
  denomination = c(
    c("2 & 5", "10", "20", "50", "100", "500", "1000"),
    c("2 & 5", "10", "20", "50", "100", "200", "500", "2000")
  ),
  pct_volume = c(
    c(12.9, 35.5, 5.4, 4.3, 17.5, 17.4, 7),
    c(11.2, 29.9, 9.8, 7.2, 21.7, 1.8, 15.1, 3.3)
  ) / 100
)
banknotes.denominations$denomination = factor(
  banknotes.denominations$denomination,
  levels = c("2 & 5", "10", "20", "50", "100", "200", "500", "1000", "2000")
)
banknotes.plot = ggplot(banknotes.denominations) +
  aes(x = year, y = pct_volume, fill = denomination) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_y_continuous(labels = percent) +
  scale_fill_discrete(name = "Denomination") +
  labs(
    x = "Year",
    y = "% of Banknotes in Circulation (Vol.)",
    title = "Composition of Banknotes in Circulation",
    subtitle = "Data Compiled by RBI in Mar. 2016 & Mar. 2018"
  )
ggsave("./plots/banknotes.png", banknotes.plot)

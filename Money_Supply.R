require("ggplot2")
require("scales")

money_supply.public = data.frame(year = c("2011", "2016", "2021"),
                                 percentage = c(13.6, 6.5, 14) / 100)
money_supply.plot = ggplot(money_supply.public) +
  aes(x = year,
      y = percentage,
      label = percent(percentage)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(vjust = -0.5) +
  scale_x_discrete(name = "Year", limits = money_supply.public$year) +
  scale_y_continuous(labels = percent) +
  labs(y = "% of M3 Money Supply Held By the Public",
       title = "India's M3 Money Supply Held as Currency with the Public\nPre- and post-Demonetization")
ggsave("./plots/money_supply.png", money_supply.plot)

require("ggplot2")

# The Informal Economy in India
# Data sourced from Tables 2 & 3 of https://www.imf.org/-/media/Files/Conferences/2019/7th-statistics-forum/session-ii-murthy.ashx

labor.data = data.frame(
  time=c(rep("2011-12", 3), rep("2017-18", 3)),
  metric=rep(c("Informal Economy Size (% of GVA)", 
               "Employment in the Informal Economy (% of labor market)", 
               "Informal Workers (% of labor market)"), 2),
  data=c(45.5, 83, 92.4, 43.1, 86.8, 90.7)
)

labor.plot = ggplot(labor.data) +
  aes(x=time, y=data, fill=metric) +
  geom_bar(stat="identity", position="dodge") +
  labs(x="Time Period", 
       y="Percentage",
       fill="Metric",
       title="(Plot 1) The Persistence of India's Informal Economy")
ggsave("./plots/informal_economy.png", labor.plot)

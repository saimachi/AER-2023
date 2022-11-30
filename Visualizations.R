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

# Digital Banking - National Electronic Fund Transfer
# 14 data points pulled from January 2009 to January 2022
# https://rbi.org.in/Scripts/NEFTView.aspx
# Plotted data is for outward debits
# The volume of outward debit transactions & inward credit transactions is roughly the same
# One lakh is 100,000 (10^5)

neft.transaction_volume = data.frame(
  year=2009:2021,
  volume=c(3198764, 6176882, 12960745, 20630753, 38364041, 65911714, 80224999, 118973141, 164187826, 170214005, 205.1 * 10^6, 2605.6 * 10^5, 2874.9 * 10^5),
  population=c(1217726217, 1234281163, 1250287939, 1265780243, 1280842119, 1295600768, 1310152392, 1324517250, 1338676779, 1352642283, 1366417756, 1380004385, 1393409033)
)

# 2009 is the baseline (1)
neft.transaction_volume["normalized_volume"] = neft.transaction_volume[,"volume"] / 3198764
neft.transaction_volume["normalized_population"] = neft.transaction_volume[,"population"] / 1217726217

# Plot
neft.plot = ggplot(neft.transaction_volume, aes(x=year)) +
  geom_line(aes(y=normalized_volume)) +
# geom_line(aes(y=normalized_population)) +
  labs(x="Year",
       y="Transaction Volume",
       title="NEFT Transaction Volume",
       subtitle="Transaction volume is measured as multiples of the baseline (2009 = 1)")
ggsave("./plots/neft_transaction_volume.png", neft.plot)

# Mobile, NEFT

neft.mobile_comparison = data.frame(
  year=rep(2012:2021, 2),
  volume=c(
    c(2844938, 5554327,  9519166, 18071922, 42799697, 106127679, 215009305, 710897776, 1440269630, 2594322708),
    neft.transaction_volume[4:nrow(neft.transaction_volume),2]),
  type=c(rep("Mobile", 10), rep("NEFT", 10))
)

neft.mobile_comparison.plot = ggplot(neft.mobile_comparison, aes(x=year, y=volume, linetype=factor(type))) + 
  geom_line() +
  labs(x="Year",
       y="Transaction Volume",
       title="NEFT v. Mobile Transaction Volume") +
  scale_linetype_manual(values = c("NEFT" = "solid", "Mobile" = "dashed"))
ggsave("./plots/neft_mobile_volume_comparison.png", neft.mobile_comparison.plot)

# ATM/WLA/CRM Distribution Data from December 2022
# Census data from 2011
library("readxl")
library("dplyr")

atm.data = read_excel("C:\\AER\\Data\\ATM.xlsx", 
                      sheet="Statewise DEC 2022")
census.data = read_excel("C:\\AER\\Data\\States.xlsx",
                         sheet="T_1")
atm.data.states = as.character(atm.data[2,2:37])
atm.data.deployments = as.numeric(atm.data[234,2:37])
atm.total_atm_deployments = data.frame(
  state=atm.data.states,
  deployments=atm.data.deployments
)
census.data.states = as.character(unlist(census.data[3:37,1]))
# Capitalize all names
census.data.states = toupper(census.data.states)
# Replace "AND" with "&"
# Just intercepts one space before and after "AND"
census.data.states = gsub("\\sAND\\s", " & ", census.data.states)
# Replace "DELHI" with "NCT OF DELHI"
census.data.states[census.data.states == "DELHI"] = "NCT OF DELHI"
census.data.population = as.numeric(unlist(census.data[3:37,8]))
census.population_2011 = data.frame(
  state=census.data.states,
  population=census.data.population
)
# Add "DADRA & NAGAR HAVELI" and "DAMAN & DIU" to equal "DADRA AND NAGAR HAVELI AND DAMAN AND DIU"
dadra_nagar = census.population_2011[census.population_2011['state'] == 'DADRA & NAGAR HAVELI', 2]
daman_diu = census.population_2011[census.population_2011['state'] == 'DAMAN & DIU', 2]
combined = data.frame(state='DADRA AND NAGAR HAVELI AND DAMAN AND DIU', population=dadra_nagar + daman_diu)
census.population_2011 = rbind(census.population_2011, combined)

# (Inner) Join DataFrames and plot
atm.plot.data = merge(atm.total_atm_deployments, census.population_2011, by = "state")
atm.plot.data['per_capita'] = atm.plot.data['deployments'] / atm.plot.data['population']
plot = ggplot(atm.plot.data) +
  aes(x=per_capita) +
  labs(
    title="Per-capita Distribution of ATMs in Indian States",
    x="ATMs per 1,000 Indians"
  ) +
  theme(axis.text.y=element_blank(), axis.ticks=element_blank()) +
  geom_boxplot()
ggsave("plots/atm_distribution.png")

# Leaders?
atm.plot.data[atm.plot.data['per_capita'] > 0.7,]

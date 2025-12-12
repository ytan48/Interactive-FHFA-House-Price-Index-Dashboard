library(tidyverse)

hpi_raw = read_csv("data/hpi_master.csv")
msa_hpi_clean = hpi_raw %>%
  filter(
    level == "MSA",
    frequency == "quarterly",
    hpi_flavor == "all-transactions",
    !is.na(index_nsa)
  ) %>%
  filter(yr >= 2000) %>%
  mutate(
    state = sub(".*,\\s*([A-Z]{2}).*", "\\1", place_name)
  ) %>%
  mutate(
    year = yr,
    quarter = period,
    month_day = case_when(
      quarter == 1 ~ "03-31",
      quarter == 2 ~ "06-30",
      quarter == 3 ~ "09-30",
      quarter == 4 ~ "12-31",
      TRUE ~ "12-31"
    ),
    date_char = paste0(year, "-", month_day),
    date = as.Date(date_char)
  ) %>%
  transmute(
    msa_id = place_id,
    msa_name = place_name,
    state,
    year,
    quarter,
    date,
    hpi_index = index_nsa
  )

write_csv(msa_hpi_clean, "data/msa_hpi_clean.csv")




example_state = "IL"

example_msa = msa_hpi_clean %>%
  filter(state == example_state) %>%
  distinct(msa_name) %>%
  arrange(msa_name) %>%
  slice(2) %>%
  pull(msa_name)

example_data = msa_hpi_clean %>%
  filter(state == example_state, msa_name == example_msa) %>%
  arrange(date)

ggplot(example_data, aes(x = date, y = hpi_index)) +
  geom_line() +
  labs(
    title = paste("Example HPI series for", example_msa),
    x = "Date",
    y = "House Price Index (NSA, all-transactions)"
  )


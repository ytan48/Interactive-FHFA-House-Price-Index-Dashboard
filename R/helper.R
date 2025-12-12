library(dplyr)

filter_msa_data = function(data, state_choice, area_type, msa_choice, year_range) {
  df = data %>%
    filter(
      state == state_choice,
      year  >= year_range[1],
      year  <= year_range[2]
    )

  if (area_type == "Single MSA" && !is.null(msa_choice) && !is.na(msa_choice)) {
      df = df %>%
        filter(msa_name == msa_choice)
    }
  df
}

## Author

- Name: Yujian Tan  
- Email: <ytan48@illinois.edu>

## Purpose

This application is designed to help users explore how house prices have changed 
over time in U.S. metropolitan statistical areas (MSAs). By selecting a state, 
choosing either a single MSA or all MSAs in that state, and adjusting a year 
range, users can view quarterly trends in the Federal Housing Finance Agency 
House Price Index (HPI). The app is intended as an exploratory dashboard for 
students, analysts, and home buyers who want to understand local housing market 
dynamics, compare different metro areas within a state, and see how quickly 
prices have risen or fallen over the past two decades.

## Data Source:

The app uses the FHFA House Price Indexes, a set of official statistics produced 
by the **Federal Housing Finance Agency**. The HPI is a repeat-sales house price 
index that tracks average changes in single-family home values over time. The 
master file provides multiple series, including different geographic levels 
(national, census division, state, and MSA), different frequencies (monthly and
quarterly), and different index flavors (such as purchase-only and all-transactions).

For this application, the data have been restricted and transformed as
follows:

- **Time period:** The app uses data from **2000 Q1 onward** to keep the plots 
focused on the modern housing market while maintaining a long enough history to 
see major cycles (such as the 2000s housing boom, the 2008–2009 downturn, and 
the post-2020 price run-up).
- **Key variables:**

    | Variable Name | Description  |
    | :-----------  | :----------- |
    |msa_name       | FHFA’s metropolitan area name (for example, "Chicago-Naperville-Elgin, IL-IN-WI").|
    |msa_id         | FHFA’s unique identifier for each MSA. |
    |state          | A two-letter state abbreviation assigned as the **primary state** for the MSA. For MSAs spanning multiple states, the primary state is defined as the first state code that appears after the comma in the MSA name (e.g. "Chicago-Naperville-Elgin, IL-IN-WI" is treated as an "IL" MSA).|  
    |year           | Calendar year. |
    |quarter        | Quarter number (1–4). |
    |date           | A representative quarter-end date constructed from `year` and `quarter`. |
    |hpi_index      | The non-seasonally-adjusted, all-transactions HPI value for that MSA and quarter. Higher values indicate higher average house prices. |
    
- For **`date`**:  
  - Q1 = March 31 
  - Q2 = June 30 
  - Q3 = September 30
  - Q4 = December 31

The raw data were originally stored in `hpi_master.csv`, and a separate pre-processing 
script (`setup.R`) filters and transforms that file into a smaller, app-ready 
dataset saved as `data/msa_hpi_clean.csv`. All filtering, creation of the `state` 
and `date` variables, and restriction to recent years are performed in this 
pre-processing step so that the Shiny app can load a clean dataset efficiently.

## References
Dataset Source Link [ [Master HPI Data (Appends Quarterly and Monthly Data)](https://www.fhfa.gov/data/hpi/datasets) ]
- Federal Housing Finance Agency (FHFA). "FHFA House Price Index® Datasets." Accessed Dec 12/8/2025


## Author

- Name: Yujian Tan  
- Email: <ytan48@illinois.edu>

## Purpose

This application is designed to help users explore how house prices have changed 
over time in U.S. metropolitan statistical areas (MSAs). By selecting a state, 
choosing either a single MSA or all MSAs in that state, and adjusting a year 
range, users can view quarterly trends in the Federal Housing Finance Agency 
House Price Index (HPI). The app is intended as an exploratory dashboard for 
students, analysts, and home buyers who want to understand local housing market 
dynamics, compare different metro areas within a state, and see how quickly 
prices have risen or fallen over the past two decades.

## Data Source:

The app uses the FHFA House Price Indexes, a set of official statistics produced 
by the **Federal Housing Finance Agency**. The HPI is a repeat-sales house price 
index that tracks average changes in single-family home values over time. The 
master file provides multiple series, including different geographic levels 
(national, census division, state, and MSA), different frequencies (monthly and
quarterly), and different index flavors (such as purchase-only and all-transactions).

For this application, the data have been restricted and transformed as
follows:

- **Time period:** The app uses data from **2000 Q1 onward** to keep the plots 
focused on the modern housing market while maintaining a long enough history to 
see major cycles (such as the 2000s housing boom, the 2008–2009 downturn, and 
the post-2020 price run-up).
- **Key variables:**

    | Variable Name | Description  |
    | :-----------  | :----------- |
    |msa_name       | FHFA’s metropolitan area name (for example, "Chicago-Naperville-Elgin, IL-IN-WI").|
    |msa_id         | FHFA’s unique identifier for each MSA. |
    |state          | A two-letter state abbreviation assigned as the **primary state** for the MSA. For MSAs spanning multiple states, the primary state is defined as the first state code that appears after the comma in the MSA name (e.g. "Chicago-Naperville-Elgin, IL-IN-WI" is treated as an "IL" MSA).|  
    |year           | Calendar year. |
    |quarter        | Quarter number (1–4). |
    |date           | A representative quarter-end date constructed from `year` and `quarter`. |
    |hpi_index      | The non-seasonally-adjusted, all-transactions HPI value for that MSA and quarter. Higher values indicate higher average house prices. |
    
- For **`date`**:  
  - Q1 = March 31 
  - Q2 = June 30 
  - Q3 = September 30
  - Q4 = December 31

The raw data were originally stored in `hpi_master.csv`, and a separate pre-processing 
script (`setup.R`) filters and transforms that file into a smaller, app-ready 
dataset saved as `data/msa_hpi_clean.csv`. All filtering, creation of the `state` 
and `date` variables, and restriction to recent years are performed in this 
pre-processing step so that the Shiny app can load a clean dataset efficiently.

## References
Dataset Source Link [ [Master HPI Data (Appends Quarterly and Monthly Data)](https://www.fhfa.gov/data/hpi/datasets) ]
- Federal Housing Finance Agency (FHFA). "FHFA House Price Index® Datasets." Accessed Dec 12/8/2025

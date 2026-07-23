# Check if the GBIF occurrence data has the required columns

**\[experimental\]**

## Usage

``` r
check_occurrence_data_required_cols(occurrence_data)
```

## Arguments

- occurrence_data:

  a dataframe of GBIF occurrence data

## Value

returns invsibily if all required columns are present. If not, an error
is raised.

## Details

An internal helper to check if the GBIF occurrence data has the required
columns

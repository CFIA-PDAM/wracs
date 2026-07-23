# Add quality control flags to each GBIF occurrence record

**\[experimental\]**

## Usage

``` r
add_quality_control_flags(occurrence_data)
```

## Arguments

- occurrence_data:

  a data frame of occurrence data extracted from GBIF

## Value

a data frame with eight additional columns corresponding to the
different quality control flags

## Details

Check each GBIF occurrence record (i.e. row) for common quality control
concerns and assign records that exhibit a particular quality concern
`TRUE` for the given column, else `FALSE`.

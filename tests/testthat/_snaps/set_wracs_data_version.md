# setting an impossible data version results in an error

    Code
      wracs::set_wracs_data_version(999)
    Condition
      Error in `wracs::set_wracs_data_version()`:
      ! Version 999 of wracs_data does not exist
      i Available versions: 1


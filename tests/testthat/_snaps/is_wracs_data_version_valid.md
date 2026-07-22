# setting an impossible data version results in an error

    Code
      wracs::set_wracs_data_version(-1)
    Condition
      Error in `wracs::set_wracs_data_version()`:
      ! Version -1 of wracs_data does not exist
      i Available versions: 1

---

    Code
      wracs::set_wracs_data_version(999)
    Condition
      Error in `wracs::set_wracs_data_version()`:
      ! Version 999 of wracs_data does not exist
      i Available versions: 1

# setting the version as a character throws an error

    Code
      wracs::set_wracs_data_version("1")
    Condition
      Error in `is_wracs_data_version_valid()`:
      ! `wracs_data_version` must be a positive integer of length 1, not a string


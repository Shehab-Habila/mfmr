# mfmr

**mfmr** is an R package designed to simplify the manipulation of multiple files. With a focus on efficient searching, matching, and cleaning of data across various datasets, this package provides an intuitive interface for handling complex data tasks.

Stands for: Multiple File Manipulator.r

------------------------

## Installation

You can install the `mfmr` package from GitHub using the `devtools` package. If you don't have `devtools` installed, you can install it using:

```r
install.packages("devtools")
```

Once `devtools` is installed, you can install `mfmr` with:

```r
devtools::install_github("Shehab-Habila/mfmr")
```

------------------------

## Features

- **Smart Search and Match**: Perform fuzzy matching and exact matching between datasets to find and unify data entries.
- **Data Cleaning**: Standardize column names, values, and handle minor misspellings to ensure data consistency.
- **Data Manipulation**: Unite variations of data within columns to streamline your datasets.
- **Integration**: Seamlessly integrate and manipulate multiple datasets for comprehensive data analysis.

------------------------

## Functions
- `split_and_remove_special()`
- `match_string_to_string()`
- `smart_search()`
- `match_two_tables()`
- `match_tables()`
- `standardize()`
- `standardize_vector()`
- `standardize_col_names()`
- `first_match()`
- `find_value()`
- `find_column()`
- `unite_within_columns()`
- `unite_values_in_table()`
- `make_unity_table()`
- `apply_unity_table()`
- `auto_unite_column()`

Full documentation for each function is available

------------------------

## Major Functions


### `match_tables`

Perform fuzzy matching and exact matching between multiple tables to find and unify data entries. This function simplifies the process of merging data from different sources.

```r
df1 <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
df2 <- data.frame(Name = c("Carol", "David", "Allice"), Salary = c(40000, 50000, 60000))
get_from_list <- list(df1, df2)
add_to_df <- data.frame(Name = c("Alice", "Bob", "Carol", "David"))
match_tables(get_from_list, add_to_df, c("Age", "Salary"), "Name", fuzzy = TRUE)
```

### `find_column`

Searches for a specified column name within a list of dataframes.

```r
df3 <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
df4 <- data.frame(Name = c("Carol", "David"), Salary = c(50000, 60000))
search_list2 <- list(df3, df4)
find_column(search_list2, "name")
find_column(search_list2, "salary", fuzzy = TRUE)
```

### `standardize_col_names`

Standardize the column names of a given table for consistency across functions. This ensures that all column names follow a consistent format, making it easier to work with the data.

```r
df <- data.frame("First Name." = c("Alice", "Bob"), "Age" = c(25, 30))
standardize_col_names(df, lowercase = TRUE)
```

### `unite_values_in_table`

Unite given variations of a string within a table, handling minor misspellings and variations. This function ensures that similar values are unified under a single standard value.

```r
# Sample dataframe
df <- data.frame(Name = c("Jonh Doe", "John Doe", "Jon Doe", "Jane Doe"))

# Unite variations of "John Doe" into a single form
df_united <- unite_values_in_table(df, c("Jonh Doe"), "John Doe", fuzzy = TRUE)
```

### `unite_within_columns`

Unite variations of a string within specified columns of a table. This function is useful for cleaning up specific columns in a dataset by unifying similar values.

```r
# Sample dataframe
df <- data.frame(Name = c("Jonh Doe", "John Doe", "Jon Doe", "Jane Doe"),
                  Address = c("123 Main St", "124 Main St", "123 Main Steet", "125 Main St"))

# Unite variations of "John Doe" and "Main Steet" into standardized forms
df_united <- unite_within_columns(df,
                                    columns_names = c("Name", "Address"),
                                    target_values = c("Jonh Doe", "John Doe", "Jon Doe"),
                                    unite_to = "John Doe",
                                    fuzzy = TRUE)
```

### `auto_unite_column`

Automatically identifies and unites variations of values within a specified column in a data frame. It uses `make_unity_table` to create a unity table and `apply_unity_table` to standardize the column based on the unity table.

```R
df <- data.frame(ID = 1:6, Status = c("single", "Single", "SINGLE", "married", "Married", "MARRIED"))
df_standardized <- auto_unite_column(df, "Status")
print(df_standardized)
```

------------------------

## Examples

### Matching Product IDs in a Bill from External Datasets

```r
library(mfmr)
matched_data <- match_tables(list(match_vegetables, match_fruits, match_missings), match_bill, get_columns = c("Product Name", "Cost"), according_to = "Product ID", fuzzy = FALSE)

# These datasets are already imported to the package and ready to go. Just run the code.
```

------------------------

## Documentation

Full documentation for each function is available with:

```r
# For example:
?smart_match_tables
```

------------------------

## Contributing

Contributions to `mfmr` are welcome! Please submit issues and pull requests on the [GitHub repository] (https://github.com/Shehab-Habila/mfmr).

------------------------

## License

This package is licensed under the MIT License.

------------------------

## Contact

For any questions or feedback, please contact:

- **Shehab Habila** (Author) - (https://linkedin.com/in/shehab-habila-b919441a5)

------------------------

Feel free to adjust the details to match your specific project and preferences.

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

### `match_tables`

Perform fuzzy matching and exact matching between multiple tables to find and unify data entries. This function simplifies the process of merging data from different sources.

```r
df1 <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
df2 <- data.frame(Name = c("Carol", "David", "Allice"), Salary = c(40000, 50000, 60000))
get_from_list <- list(df1, df2)
add_to_df <- data.frame(Name = c("Alice", "Bob", "Carol", "David"))
match_tables(get_from_list, add_to_df, c("Age", "Salary"), "Name", fuzzy = TRUE)
```

### `standardize_col_names`

Standardize the column names of a given table for consistency across functions. This ensures that all column names follow a consistent format, making it easier to work with the data.

```r
df <- data.frame("First Name." = c("Alice", "Bob"), "Age" = c(25, 30))
standardize_col_names(df, lowercase = TRUE)
```

### `standardize_vector`

Standardize values within a vector, converting them to a consistent format. This function is useful for ensuring that all values in a vector follow the same conventions.

```r
values <- c("Hello", "World", "FOO", "Bar Chart")
standardize_vector(values, lowercase = TRUE)
```

### `standardize`

Convert a string to a standardized version, removing unwanted characters and optionally converting to lowercase. This helps in cleaning up text data for further processing.

```r
standardize("Hello, World!")
standardize("Special @# Characters!", lowercase = FALSE)
```

### `unite_values_in_table`

Unite variations of a string within a table, handling minor misspellings and variations. This function ensures that similar values are unified under a single standard value.

```r
cleaned_table <- unite_values_in_table(my_table, target_values = c("var1", "var2"), unite_to = "unified_value")

# These Variables Need be Declared First
```

### `unite_within_columns`

Unite variations of a string within specified columns of a table. This function is useful for cleaning up specific columns in a dataset by unifying similar values.

```r
cleaned_table <- unite_within_columns(my_table, columns_names = c("col1", "col2"), target_values = c("var1", "var2"), unite_to = "unified_value")

# These Variables Need be Declared First
```

------------------------

## Examples

### Matching Product IDs in a Bill from External Datasets

```r
library(mfmr)
matched_data <- match_tables(list(match_vegetables, match_fruits, match_missings), match_bill, get_columns = c("Product Name", "Cost"), according_to = "Product ID", fuzzy = FALSE)
```

------------------------

## Documentation

Full documentation for each function documentation is available with:

```r
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

- **Shehab Habila** (Author) - linkedin.com/in/shehab-habila-b919441a5

------------------------

Feel free to adjust the details to match your specific project and preferences.

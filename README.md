# Module 9: Introduction to Data Frames

In this module, we'll begin working with data frame objects, which are a major data storage type used in R. In many ways, data frames are similar to a two-dimensional row/column layouts that you should be familiar with from spreadsheet programs like Microsoft Excel. This module will cover various ways of creating, describing, and accessing Data frames, as well as how they are related to other data types in R.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**

- [Resources](#resources)
- [Data Frames](#data-frames)
  - [Creating Data Frames](#creating-data-frames)
  - [Describing Structure of Data Frames](#describing-structure-of-data-frames)
  - [Accessing Data in Data Frames](#accessing-data-in-data-frames)
- [Working with CSV Data](#working-with-csv-data)
  - [Working Directory](#working-directory)
- [Factor Variables](#factor-variables)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Resources
- [R Tutorial: Data Frames](http://www.r-tutor.com/r-introduction/data-frame)
- [R Tutorial: Data Frame Indexing](http://www.r-tutor.com/r-introduction/data-frame/data-frame-row-slice)
- [Quick-R: Missing Values](http://www.statmethods.net/input/missingdata.html)
- [Factor Variables (UCLA)](http://www.ats.ucla.edu/stat/r/modules/factor_variables.htm)


## Data Frames
At a practical level, **Data Frames** act like _tables_, where data is organized into rows and columns. For example, consider the following table of names, weights, and heights:

![table of weight and height](img/table-example.png)

In this table, each _row_ represents a **record** or **observation**: an instance of a single thing being measured (e.g., a person). Each _column_ represents a **feature**: a particular property or aspect of the thing being measured (e.g., the person's height or weight). This structure is used to organize lots of different _related_ data points for easier analysis.

In R, we can use **data frames** to represent these kinds of tables. Data frames are really just **lists** (see Module 8) in which each element is a **vector of the same length**. Each vector represents a **column, not a row**. The elements at corresponding indices in the vectors are considered part of the same record (row).

- This makes sense because each row may have different types of data (e.g., a person's `name` (string) and `height` (number)), and vector elements must all be of the same time.

For example, you can think of the above table as a _list_ of three _vectors_: `name`, `height` and `weight`. The name, height, and weight of the first person measured are represented by the first elements of the `name`, `height` and `weight` vectors respectively.

You can work with data frames as if they were lists, but they include additional properties as well that make them particularly well suited for handling tables of data.


### Creating Data Frames
Typically we will _load_ data sets from some external source (see below), rather than writing out the data by hand. However, it is important to understand that you can construct a data frame by combining multiple vectors. To accomplish this, you can use the `data.frame()` function, which accepts **vectors** as _arguments_, and creates a table with a column for each vector. For example:

```r
# vector of names
name <- c('Ada','Bob','Chris','Diya','Emma')

# Vector of heights
height <- 58:62

# Vector of weights
weight <- c(115, 117, 120, 123, 126)

# Combine the vectors into a data.frame
# Note the names of the variables become the names of the columns!
my.data <- data.frame(name, height, weight, stringsAsFactors=FALSE)
```

- (The last argument to the `data.frame()` is because one of our vectors contains strings; it tells R to treat that vector as a _vector_ not as a **factor**. This is usually what we'll want to do. See below for details about factors).

Because data frame elements are lists, we can access the values from `my.data` using the same **dollar notation** and **double-bracket notation** as lists:

```r
# Using the same weights/heights as above:
my.data <- data.frame(height, weight)

# Retrieve weights (the `weight` element of the list: a vector!)
my.weights <- my.data$weight

# Retrieve heights (the whole column: a vector!)
my.heights <- my.data[['height']]
```


### Describing Structure of Data Frames
While you can interact with data frames as list, they also offer a number of capabilities and functions. For example, here are a few ways you can _inspect_ the structure of a data frame:

| Function | Description |
| --- | --- |
| `nrow(my.data.frame)` | Number of rows in the data frame |
| `ncol(my.data.frame)` | Number of columns in the data frame |
| `dim(my.data.frame)` | Dimensions (rows, columns) in the data frame |
| `colnames(my.data.frame)` | Names of the columns of the data frame |
| `rownames(my.data.frame)` | Names of the row of the data frame |
| `head(my.data.frame)` | Extracts the first few rows of the data frame (as a new data frame) |
| `tail(my.data.frame)` | Extracts the last few rows of the data frame (as a new data frame) |
| `View(my.data.frame)` | Opens the data frame in as spreadsheet-like viewer (only in RStudio)|

Note that many of these description functions can also be used to _modify_ the structure of data frame. For example, you can use the `colnames` functions to assign a new set of column names to a data frame:

```r
# Using the same weights/heights as above:
my.data <- data.frame(name, height, weight)

# vector of new column names
new.col.names <- c('First.Name','How.Tall','How.Heavy')

# assign that vector to be the vector of column names
colnames(my.data) <- new.col.names
```

### Accessing Data in Data Frames
As stated above, since data frames _are_ lists, it's possible to use **dollar notation** (`my.data.frame$column.name`) or **double-bracket notation** (`my.data.frame[['column.name']]`) to access entire columns. However, R also uses a variation of **single-bracket notation** which allows you to access individual data elements (cells) in the table. In this synax, you put _two_ values inside the brackets separated by a comma (`,`), the first for which row and the second for which column you wish you extract:

| Syntax | Description | Example |
| --- | --- | --- |
| `my.data.frame[row.num, col.num]` | Element by row and column indices | `my.frame[2,3]` (element in the second row, third column) |
| `my.data.frame[row.name, col.name]` | Element by row and column names | `my.frame['Ada','height']` (element in row _named_ `Ada` and column _named_ `height`; the `height` of `Ada`) |
| `my.data.frame[row, col]` | Element by row and col; can mix indices and names | `my.frame[2,'height']` (second element in the `height` column) |
| `my.data.frame[row, ]` | All elements (columns) in row index or name |  `my.frame[2,]` (all columns in the second row) |
| `my.data.frame[, col]`| All elements (rows) in a col index or name | `my.frame[,'height']`  (all rows in the `height` column; equivalent to list notations) |

Take special note of the 4th's syntax (for retrieving rows): we still include the comma (`,`), but because we leave which column blank, we get all of them!

```r
# extract the second row
my.data[2, ]  # comma

# extract the second column AS A VECTOR
my.data[, 2]  # comma

# extract the second column AS A DATA FRAME (filtering)
my.data[2]  # no comma
```

(Extracting from more than one column will produce a _sub-data frame_; extracting from just one column will return a vector).

And of course, because _everything is a vector_, you're actually specifying vectors of indicies to extract. This allows you to get multiple rows or columns:

```r
# Get the second through fourth rows
my.data[2:4, ]

# Get the `height` and `weight` columns
my.data[, c('height', 'weight')]

# Perform filtering
my.data[my.data$height > 60, ] # rows for which `height` is greater than 60
```

For practice retrieving information and manipulating data frames, see [exercise-1](exercise-1) and [exercise-2](exercise-2).


## Working with CSV Data
So far we've been constructing our own data frames by "hard-coding" the data values. But it's much more common to load that data from somewhere else, such as a separate file on yur computer or by downloading it off the internet. While R is able to ingest data from a variety of sources, in this module we'll focus on reading tabular data in **comma separated value** (CSV) format, usually stored in a `.csv` file. In this format, each line of the file represents a record (_row_) of data, while each feature (_column_) of that record is separated by a comma:

```
Ada, 58, 115
Bob, 59, 117
Chris, 60, 120
Diya, 61, 123
Emma, 62, 126
```

Most spreadsheet programs like Microsoft Excel, Numbers, or Google Sheets are simply interfaces for formatting and interacting with data that is saved in this format. These programs easily import and export `.csv` files; however `.csv` files are unable to save the formatting done in those programs&mdash;the files only store the data!

We can load the data from a `.csv` file into R by using the `read.csv()` function:

```r
# Read data from the file `my_file.csv` into a data frame `my.data`
my.data <- read.csv('my_file.csv', stringsAsFactors=FALSE)
```

Again, we're using the `stringsAsFactors` argument to make sure string data is stored as a _vector_ rather than as a _factor_ (see below). This will return a data frame, just like we've used previously!

**Important Note**: If for whatever reason an element is missing from a data frame (which is very common with real world data!), R will fill that cell with the logical value `NA` (distinct from the string `"NA"`), meaning "**N**ot **A**vailable". There are multiple ways to handle this in an analysis; see [this link](http://www.statmethods.net/input/missingdata.html) among others for details.


### Working Directory
The biggest complication when loading `.csv` files is that the `read.csv()` function takes as an argument a **path** to the file. Because we want this script to work on any computer (easy collaboration&mdash;also grading), we want to make sure we use a **relative path** to the file. The question is: relative to what?

Like the command-line, the R interpreter (running along with R Studio) has a **current working directory** from which all file paths are relative. The trick is that ___the working directory is not the directory of the current script!___.

- This makes sense if you think about it: you can run R commands through the console without having a script, and you can have multiple script files open from separate folders that are all interacting with the same environment.

Just as we can view the current working directory when on the commandline (using `pwd`), we can use an R function to view the current working directory when in R:

```r
# get the absolute path to the current working directory
getwd()
```

You often will want to change the working directory to be your "project" directory (wherever your scripts and data files happen to be). It is possible to change the current working directory using the `setwd()` function. However, this function would also take an absolute path, so doesn't fix the problem. You could use it from the console, but would not want to include it in your script.

A somewhat better solution is to use R Studio itself to change the working directory. This is reasonable because the working directory is a property of the current running environment, which is what R Studio makes accessible! To do this, use the **`Files`** tab inside the lower-right "misc" panel: navigate in this file browser to the folder you want to be your working directory, then select the **`More`** option and then **`Set As Working Directory`** to set the working directory to that folder.

![setwd() through R Studio](img/setwd-rstudio.png)

You should do this whenever you hit a "path" problem when loading external files. If you want to do this repeatedly by calling `setwd()` from your script to an absolute path, be sure and keep it commented out (`# setwd(...)`) so it doesn't cause problems for others.

For practice reading and working with data, see [exercise-3](exercise-3) and [exercise-4](exercise-4).

## Factor Variables
**Factors** are a way of _optimizing_ variables that consist of a finite set of categories (i.e., they are **categorical (nominal) variables**).

For example, imagine that you had a vector of shirt sizes which could only take on the values `small`, `medium`, or `large`. If you were working with a large dataset (thousands of shirts!), it would end up taking up a lot of memory to store the character strings for each one of those variables.

A **factor** on the other hand would instead store a _number_ (called a **level**) for each of these character strings: for example, `1` for `small`, `2` for `medium`, or `3` for large (though the order or specific numbers will vary). R will remember the relationship between the integers and their **labels** (the strings), allowing it to keep much more information in memory. For example:

```r
# Start with a character vector of shirt sizes
shirt.sizes <- c('small', 'medium', 'small', 'large', 'medium', 'large')

# Convert to a vector of factor data
shirt.sizes.factor <- as.factor(shirt.sizes)

# View the factor and its levels
print(shirt.sizes.factor)

# The length of the factor is still the length of the vector, not the number of levels
length(shirt.sizes.factor)  # 6
```

When you print out the `shirt.sizes.factor` variable, R still (intelligently) prints out the **labels** that you are presumably interested in. It also indicates the **levels**, which are the _only_ possible values that elements can take on.

It is worth re-stating: **factors are not vectors**. This means that most all the operations and functions you want to use on vectors _will not work_:

```r
# create a factor of numbers (factors need not be strings)
num.factors <- as.factor(c(10,10,20,20,30,30,40,40))

# print the factor to see its levels
print(num.factors)

# multiply the numbers by 2
num.factors * 2  # Error: * not meaningful
                 # returns vector of NA instead

# changing entry to a level is fine
num.factors[1] <- 40

# change entry to a value that ISN'T a level fails
num.factors[1] <- 50  # Error: invalid factor level
                      # num.factors[1] is now NA
```

If you create a data frame with a string vector as a column (as what happens with `read.csv()`), it will automatically be treated as a factor unless you explicitly tell it not to.

```r
# vector of shirt sizes
shirt.size <- c('small', 'medium', 'small', 'large', 'medium', 'large')

# vector of costs (in dollars)
cost <- c(15.5, 17, 17, 14, 12, 23)

# data frame of inventory (with factors)
shirts.factor <- data.frame(shirt.size, cost)

# the shirt.size column is a factor
is.factor(shirts.factor$shirt.size)  # TRUE

# can treat this as a vector; but better to fix how the data is loaded
as.vector(shirts.factor$shirt.size)  # a vector

# data frame of orders (without factoring)
shirts <- data.frame(shirt.size, cost, stringsAsFactors=FALSE)

# the shirt.size column is NOT a factor
is.factor(shirts$shirt.size)  # FALSE
```

This is not to say that factors can't be useful (beyond just saving memory)! They offer easy ways to group and process data using specialized functions:

```r
shirt.size <- c('small', 'medium', 'small', 'large', 'medium', 'large')
cost <- c(15.5, 17, 17, 14, 12, 23)

# data frame of inventory (with factors)
shirts.factor <- data.frame(shirt.size, cost)

# produce a list of data frames, one for each factor level
# first argument is the data frame to split, second is the factor to split by
split(shirts.factor, shirts.factor$shirt.size)

# apply a function (mean) to each factor level
#   first argument is the vector to apply the function to,
#   second argument is the factor to split by
#   third argument is the name of the function
tapply(shirts$cost, shirts$shirt.size, mean)
```

However, in general for our purposes we're more interested in working with data as vectors, thus you should always use `stringsAsFactors=FALSE` when creating data frames or loading `.csv` files.

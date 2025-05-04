# Data Summary Report
Generated on: 2025-05-04 13:44:41 

---

## Overview
This report provides summaries for CSV datasets found in the subdirectory: `Data`
(Full path: `D:\work\Semester4\AdvStats\pakistan-inflation-forecast\Data`) relative to the script location `D:\work\Semester4\AdvStats\pakistan-inflation-forecast`.
Metadata was sourced from `datasets_info.md` located in `D:\work\Semester4\AdvStats\pakistan-inflation-forecast` (if found).
For datasets with more than 150 columns, a random sample of 150 columns is shown in the 'Data Sample' section.

---


## Analysis for: `borrow_loans.csv` (in `Data` directory)

*	No specific metadata found for `borrow_loans.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (8680, 10) (rows, columns)
* **Total Cells:** 86800
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 8680 entries, 0 to 8679
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                8680 non-null   object 
 1   Observation Date            8680 non-null   object 
 2   Series Key                  8680 non-null   object 
 3   Series Display Name         8680 non-null   object 
 4   Observation Value           8680 non-null   float64
 5   Unit                        8680 non-null   object 
 6   Observation Status          8680 non-null   object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                8680 non-null   int64  
 9   Series name                 8680 non-null   object 
dtypes: float64(2), int64(1), object(7)
memory usage: 678.3+ KB

```

### Missing Values Summary

Total missing values: 8680
Columns with missing values:
```
Observation Status Comment    8680
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                     1
Observation Date                70
Series Key                     124
Series Display Name            124
Observation Value             8653
Unit                             1
Observation Status               1
Observation Status Comment       0
Sequence No.                   124
Series name                    124
```

### Descriptive Statistics

```markdown
|        | Dataset Name                           | Observation Date   | Series Key                       | Series Display Name                 |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                       |
|:-------|:---------------------------------------|:-------------------|:---------------------------------|:------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:--------------------------------------------------|
| count  | 8680                                   | 8680               | 8680                             | 8680                                |      8680           | 8680        | 8680                 |                            0 |       8680     | 8680                                              |
| unique | 1                                      | 70                 | 124                              | 124                                 |       nan           | 1           | 1                    |                          nan |        nan     | 124                                               |
| top    | Credit / Loans Classified by Borrowers | 31-Mar-2025        | TS_GP_BAM_CRLONBOR_M.CLB00011000 | 1 Credit to Government sector (A+B) |       nan           | Million PKR | Normal               |                          nan |        nan     | SBP & Scheduled Banks Credit to Government sector |
| freq   | 8680                                   | 124                | 70                               | 70                                  |       nan           | 8680        | 8680                 |                          nan |        nan     | 70                                                |
| mean   | nan                                    | nan                | nan                              | nan                                 |         1.06662e+06 | nan         | nan                  |                          nan |        625     | nan                                               |
| std    | nan                                    | nan                | nan                              | nan                                 |         4.0006e+06  | nan         | nan                  |                          nan |        357.966 | nan                                               |
| min    | nan                                    | nan                | nan                              | nan                                 |         0           | nan         | nan                  |                          nan |         10     | nan                                               |
| 25%    | nan                                    | nan                | nan                              | nan                                 |      3103.23        | nan         | nan                  |                          nan |        317.5   | nan                                               |
| 50%    | nan                                    | nan                | nan                              | nan                                 |     35385.8         | nan         | nan                  |                          nan |        625     | nan                                               |
| 75%    | nan                                    | nan                | nan                              | nan                                 |    194342           | nan         | nan                  |                          nan |        932.5   | nan                                               |
| max    | nan                                    | nan                | nan                              | nan                                 |         4.62231e+07 | nan         | nan                  |                          nan |       1240     | nan                                               |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                           | Observation Date   | Series Key                       | Series Display Name                                        |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                           |
|:---------------------------------------|:-------------------|:---------------------------------|:-----------------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:------------------------------------------------------|
| Credit / Loans Classified by Borrowers | 31-Mar-2025        | TS_GP_BAM_CRLONBOR_M.CLB00011000 | 1 Credit to Government sector (A+B)                        |         3.31733e+07 | Million PKR | Normal               |                          nan |             10 | SBP & Scheduled Banks Credit to Government sector     |
| Credit / Loans Classified by Borrowers | 31-Mar-2025        | TS_GP_BAM_CRLONBOR_M.CLB00012000 | ......A. SBP Credit to Government sector (Net)             |         4.20084e+06 | Million PKR | Normal               |                          nan |             20 | SBP Credit to Government Sector                       |
| Credit / Loans Classified by Borrowers | 31-Mar-2025        | TS_GP_BAM_CRLONBOR_M.CLB00013000 | ......B. Scheduled Banks Credit to Government sector (Net) |         2.89725e+07 | Million PKR | Normal               |                          nan |             30 | Scheduled Banks Credit to Government sector           |
| Credit / Loans Classified by Borrowers | 31-Mar-2025        | TS_GP_BAM_CRLONBOR_M.CLB00014000 | 2 Credit to Non Governmnet sector (A+B)                    |         1.30498e+07 | Million PKR | Normal               |                          nan |             40 | SBP & Scheduled Banks Credit to Non-Government sector |
| Credit / Loans Classified by Borrowers | 31-Mar-2025        | TS_GP_BAM_CRLONBOR_M.CLB00015000 | ......A. SBP Credit to Non Govt. sector                    |     75988.5         | Million PKR | Normal               |                          nan |             50 | SBP Credit to Non-Government sector                   |
```


---


## Analysis for: `country_wise_remittance.csv` (in `Data` directory)

*	No specific metadata found for `country_wise_remittance.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (21651, 10) (rows, columns)
* **Total Cells:** 216510
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 21651 entries, 0 to 21650
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                21651 non-null  object 
 1   Observation Date            21651 non-null  object 
 2   Series Key                  21651 non-null  object 
 3   Series Display Name         21651 non-null  object 
 4   Observation Value           21099 non-null  float64
 5   Unit                        21651 non-null  object 
 6   Observation Status          21651 non-null  object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                21651 non-null  int64  
 9   Series name                 21651 non-null  object 
dtypes: float64(2), int64(1), object(7)
memory usage: 1.7+ MB

```

### Missing Values Summary

Total missing values: 22203
Columns with missing values:
```
Observation Value               552
Observation Status Comment    21651
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                     1
Observation Date               633
Series Key                      36
Series Display Name             36
Observation Value             4655
Unit                             1
Observation Status               2
Observation Status Comment       0
Sequence No.                    36
Series name                     36
```

### Descriptive Statistics

```markdown
|        | Dataset Name                      | Observation Date   | Series Key            | Series Display Name   |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                      |
|:-------|:----------------------------------|:-------------------|:----------------------|:----------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-----------------------------------------------------------------|
| count  | 21651                             | 21651              | 21651                 | 21651                 |          21099      | 21651       | 21651                |                            0 |     21651      | 21651                                                            |
| unique | 1                                 | 633                | 36                    | 36                    |            nan      | 1           | 2                    |                          nan |       nan      | 36                                                               |
| top    | Country-wise Workers' Remittances | 31-Jan-2019        | TS_GP_BOP_WR_M.WR0010 | I. Cash Flow          |            nan      | Million USD | Normal               |                          nan |       nan      | Total Cash inflow of Workers' remittances in Pakistan in a month |
| freq   | 21651                             | 36                 | 633                   | 633                   |            nan      | 21651       | 21099                |                          nan |       nan      | 633                                                              |
| mean   | nan                               | nan                | nan                   | nan                   |             66.2779 | nan         | nan                  |                          nan |       175.785  | nan                                                              |
| std    | nan                               | nan                | nan                   | nan                   |            260.108  | nan         | nan                  |                          nan |        98.3376 | nan                                                              |
| min    | nan                               | nan                | nan                   | nan                   |              0      | nan         | nan                  |                          nan |        10      | nan                                                              |
| 25%    | nan                               | nan                | nan                   | nan                   |              0.3    | nan         | nan                  |                          nan |        90      | nan                                                              |
| 50%    | nan                               | nan                | nan                   | nan                   |              3.5    | nan         | nan                  |                          nan |       180      | nan                                                              |
| 75%    | nan                               | nan                | nan                   | nan                   |             23.95   | nan         | nan                  |                          nan |       260      | nan                                                              |
| max    | nan                               | nan                | nan                   | nan                   |           4055.33   | nan         | nan                  |                          nan |       340      | nan                                                              |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                      | Observation Date   | Series Key            | Series Display Name   |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                      |
|:----------------------------------|:-------------------|:----------------------|:----------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-----------------------------------------------------------------|
| Country-wise Workers' Remittances | 31-Mar-2025        | TS_GP_BOP_WR_M.WR0010 | I. Cash Flow          |            4055.33  | Million USD | Normal               |                          nan |             10 | Total Cash inflow of Workers' remittances in Pakistan in a month |
| Country-wise Workers' Remittances | 31-Mar-2025        | TS_GP_BOP_WR_M.WR0020 | ......1 USA           |             419.454 | Million USD | Normal               |                          nan |             20 | Workers' remittances received from U.S.A.                        |
| Country-wise Workers' Remittances | 31-Mar-2025        | TS_GP_BOP_WR_M.WR0030 | ......2 U.K.          |             683.887 | Million USD | Normal               |                          nan |             30 | Workers' remittances received from U.K.                          |
| Country-wise Workers' Remittances | 31-Mar-2025        | TS_GP_BOP_WR_M.WR0040 | ......3 Saudi Arabia  |             987.297 | Million USD | Normal               |                          nan |             40 | Workers' remittances received from Saudi Arabia                  |
| Country-wise Workers' Remittances | 31-Mar-2025        | TS_GP_BOP_WR_M.WR0050 | ......4 U.A.E.        |             842.14  | Million USD | Normal               |                          nan |             50 | Workers' remittances received from U.A.E.                        |
```


---


## Analysis for: `exchange_rate.csv` (in `Data` directory)

*	No specific metadata found for `exchange_rate.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (66332, 10) (rows, columns)
* **Total Cells:** 663320
* **Data Type Counts:** {dtype('O'): 8, dtype('float64'): 1, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 66332 entries, 0 to 66331
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                66332 non-null  object 
 1   Observation Date            66332 non-null  object 
 2   Series Key                  66332 non-null  object 
 3   Series Display Name         66332 non-null  object 
 4   Observation Value           66332 non-null  float64
 5   Unit                        66332 non-null  object 
 6   Observation Status          66332 non-null  object 
 7   Observation Status Comment  29 non-null     object 
 8   Sequence No.                66332 non-null  int64  
 9   Series name                 66332 non-null  object 
dtypes: float64(1), int64(1), object(8)
memory usage: 5.1+ MB

```

### Missing Values Summary

Total missing values: 66303
Columns with missing values:
```
Observation Status Comment    66303
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                      1
Observation Date               2884
Series Key                       23
Series Display Name              23
Observation Value             65822
Unit                              1
Observation Status                1
Observation Status Comment        1
Sequence No.                     23
Series name                      23
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                                           | Observation Date   | Series Key                     | Series Display Name                                               |   Observation Value | Unit   | Observation Status   | Observation Status Comment                           |   Sequence No. | Series name                                                     |
|:-------|:-----------------------------------------------------------------------|:-------------------|:-------------------------------|:------------------------------------------------------------------|--------------------:|:-------|:---------------------|:-----------------------------------------------------|---------------:|:----------------------------------------------------------------|
| count  | 66332                                                                  | 66332              | 66332                          | 66332                                                             |        66332        | 66332  | 66332                | 29                                                   |      66332     | 66332                                                           |
| unique | 1                                                                      | 2884               | 23                             | 23                                                                |          nan        | 1      | 1                    | 1                                                    |        nan     | 23                                                              |
| top    | Bank Floating Daily Average Exchange Rates (PKR per National Currency) | 28-Mar-2025        | TS_GP_ES_FADERPKR_M.XRDAVG0010 | 1 Daily Average Exchange rate of PAK Rupees per Australian Dollar |          nan        | PKR    | Normal               | Iraqi invasion of Kuwait from Aug-1990 till Sep-1991 |        nan     | Daily Average Exchange rate of PAK Rupees per Australian Dollar |
| freq   | 66332                                                                  | 23                 | 2884                           | 2884                                                              |          nan        | 66332  | 66332                | 29                                                   |        nan     | 2884                                                            |
| mean   | nan                                                                    | nan                | nan                            | nan                                                               |          125.102    | nan    | nan                  | nan                                                  |        120     | nan                                                             |
| std    | nan                                                                    | nan                | nan                            | nan                                                               |          162.964    | nan    | nan                  | nan                                                  |         66.333 | nan                                                             |
| min    | nan                                                                    | nan                | nan                            | nan                                                               |            0.813082 | nan    | nan                  | nan                                                  |         10     | nan                                                             |
| 25%    | nan                                                                    | nan                | nan                            | nan                                                               |           22.213    | nan    | nan                  | nan                                                  |         60     | nan                                                             |
| 50%    | nan                                                                    | nan                | nan                            | nan                                                               |           70.0186   | nan    | nan                  | nan                                                  |        120     | nan                                                             |
| 75%    | nan                                                                    | nan                | nan                            | nan                                                               |          161.491    | nan    | nan                  | nan                                                  |        180     | nan                                                             |
| max    | nan                                                                    | nan                | nan                            | nan                                                               |          995.365    | nan    | nan                  | nan                                                  |        230     | nan                                                             |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                                           | Observation Date   | Series Key                     | Series Display Name                                               |   Observation Value | Unit   | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                     |
|:-----------------------------------------------------------------------|:-------------------|:-------------------------------|:------------------------------------------------------------------|--------------------:|:-------|:---------------------|-----------------------------:|---------------:|:----------------------------------------------------------------|
| Bank Floating Daily Average Exchange Rates (PKR per National Currency) | 28-Mar-2025        | TS_GP_ES_FADERPKR_M.XRDAVG0010 | 1 Daily Average Exchange rate of PAK Rupees per Australian Dollar |            175.97   | PKR    | Normal               |                          nan |             10 | Daily Average Exchange rate of PAK Rupees per Australian Dollar |
| Bank Floating Daily Average Exchange Rates (PKR per National Currency) | 28-Mar-2025        | TS_GP_ES_FADERPKR_M.XRDAVG0020 | 2 Daily Average Exchange rate of PAK Rupees per Bahraini Dinar    |            743.114  | PKR    | Normal               |                          nan |             20 | Daily Average Exchange rate of PAK Rupees per Bahraini Dinar    |
| Bank Floating Daily Average Exchange Rates (PKR per National Currency) | 28-Mar-2025        | TS_GP_ES_FADERPKR_M.XRDAVG0030 | 3 Daily Average Exchange rate of PAK Rupees per Canadian Dollar   |            195.666  | PKR    | Normal               |                          nan |             30 | Daily Average Exchange rate of PAK Rupees per Canadian Dollar   |
| Bank Floating Daily Average Exchange Rates (PKR per National Currency) | 28-Mar-2025        | TS_GP_ES_FADERPKR_M.XRDAVG0040 | 4 Daily Average Exchange rate of PAK Rupees per Chinese Yuan      |             38.5688 | PKR    | Normal               |                          nan |             40 | Daily Average Exchange rate of PAK Rupees per Chinese Yuan      |
| Bank Floating Daily Average Exchange Rates (PKR per National Currency) | 28-Mar-2025        | TS_GP_ES_FADERPKR_M.XRDAVG0050 | 5 Daily Average Exchange rate of PAK Rupees per Danish Krone      |             40.5188 | PKR    | Normal               |                          nan |             50 | Daily Average Exchange rate of PAK Rupees per Danish Krone      |
```


---


## Analysis for: `foreign_invest_countires.csv` (in `Data` directory)

*	No specific metadata found for `foreign_invest_countires.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (44523, 10) (rows, columns)
* **Total Cells:** 445230
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 44523 entries, 0 to 44522
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                44523 non-null  object 
 1   Observation Date            44523 non-null  object 
 2   Series Key                  44523 non-null  object 
 3   Series Display Name         44523 non-null  object 
 4   Observation Value           44523 non-null  float64
 5   Unit                        44523 non-null  object 
 6   Observation Status          44523 non-null  object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                44523 non-null  int64  
 9   Series name                 44523 non-null  object 
dtypes: float64(2), int64(1), object(7)
memory usage: 3.4+ MB

```

### Missing Values Summary

Total missing values: 44523
Columns with missing values:
```
Observation Status Comment    44523
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                      1
Observation Date                153
Series Key                      291
Series Display Name             291
Observation Value             14456
Unit                              1
Observation Status                1
Observation Status Comment        0
Sequence No.                    291
Series name                     291
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                | Observation Date   | Series Key                   | Series Display Name                                              |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                |
|:-------|:--------------------------------------------|:-------------------|:-----------------------------|:-----------------------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-----------------------------------------------------------|
| count  | 44523                                       | 44523              | 44523                        | 44523                                                            |        44523        | 44523       | 44523                |                            0 |      44523     | 44523                                                      |
| unique | 1                                           | 153                | 291                          | 291                                                              |          nan        | 1           | 1                    |                          nan |        nan     | 291                                                        |
| top    | Foreign Investment in Pakistan by Countries | 31-Mar-2025        | TS_GP_FI_FIPKBYCOU_M.FIC0010 | 1 Net Cash Flow on Foreign Investment in Pakistan during a month |          nan        | Million USD | Normal               |                          nan |        nan     | Net Foreign Investment received in Pakistan from the World |
| freq   | 44523                                       | 291                | 153                          | 153                                                              |          nan        | 44523       | 44523                |                          nan |        nan     | 153                                                        |
| mean   | nan                                         | nan                | nan                          | nan                                                              |            4.78586  | nan         | nan                  |                          nan |       1460     | nan                                                        |
| std    | nan                                         | nan                | nan                          | nan                                                              |           49.1108   | nan         | nan                  |                          nan |        840.049 | nan                                                        |
| min    | nan                                         | nan                | nan                          | nan                                                              |        -1830.06     | nan         | nan                  |                          nan |         10     | nan                                                        |
| 25%    | nan                                         | nan                | nan                          | nan                                                              |            0        | nan         | nan                  |                          nan |        730     | nan                                                        |
| 50%    | nan                                         | nan                | nan                          | nan                                                              |            0        | nan         | nan                  |                          nan |       1460     | nan                                                        |
| 75%    | nan                                         | nan                | nan                          | nan                                                              |            0.998587 | nan         | nan                  |                          nan |       2190     | nan                                                        |
| max    | nan                                         | nan                | nan                          | nan                                                              |         2662.49     | nan         | nan                  |                          nan |       2910     | nan                                                        |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                | Observation Date   | Series Key                   | Series Display Name                                                           |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                          |
|:--------------------------------------------|:-------------------|:-----------------------------|:------------------------------------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:---------------------------------------------------------------------|
| Foreign Investment in Pakistan by Countries | 31-Mar-2025        | TS_GP_FI_FIPKBYCOU_M.FIC0010 | 1 Net Cash Flow on Foreign Investment in Pakistan during a month              |           -105.652  | Million USD | Normal               |                          nan |             10 | Net Foreign Investment received in Pakistan from the World           |
| Foreign Investment in Pakistan by Countries | 31-Mar-2025        | TS_GP_FI_FIPKBYCOU_M.FIC0020 | ......I Net Cash Flow on Foreign Direct Investment in Pakistan during a month |             25.7486 | Million USD | Normal               |                          nan |             20 | Net Foreign Direct Investment received in Pakistan from the World    |
| Foreign Investment in Pakistan by Countries | 31-Mar-2025        | TS_GP_FI_FIPKBYCOU_M.FIC0030 | ............i Foreign Direct Investment inflows in Pakistan from the World    |            176.55   | Million USD | Normal               |                          nan |             30 | Foreign Direct Investment inflows in Pakistan from the World         |
| Foreign Investment in Pakistan by Countries | 31-Mar-2025        | TS_GP_FI_FIPKBYCOU_M.FIC0040 | ............ii Foreign Direct Investment outflows from Pakistan to the World  |            150.801  | Million USD | Normal               |                          nan |             40 | Foreign Direct Investment outflows from Pakistan to the world        |
| Foreign Investment in Pakistan by Countries | 31-Mar-2025        | TS_GP_FI_FIPKBYCOU_M.FIC0050 | ......II Net Foreign Portfolio Investment received in Pakistan from the World |            -15.3182 | Million USD | Normal               |                          nan |             50 | Net Foreign Portfolio Investment received in Pakistan from the World |
```


---


## Analysis for: `foreign_invest_sectors.csv` (in `Data` directory)

*	No specific metadata found for `foreign_invest_sectors.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (23409, 10) (rows, columns)
* **Total Cells:** 234090
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 23409 entries, 0 to 23408
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                23409 non-null  object 
 1   Observation Date            23409 non-null  object 
 2   Series Key                  23409 non-null  object 
 3   Series Display Name         23409 non-null  object 
 4   Observation Value           23409 non-null  float64
 5   Unit                        23409 non-null  object 
 6   Observation Status          23409 non-null  object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                23409 non-null  int64  
 9   Series name                 23409 non-null  object 
dtypes: float64(2), int64(1), object(7)
memory usage: 1.8+ MB

```

### Missing Values Summary

Total missing values: 23409
Columns with missing values:
```
Observation Status Comment    23409
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                      1
Observation Date                153
Series Key                      153
Series Display Name             153
Observation Value             10738
Unit                              1
Observation Status                1
Observation Status Comment        0
Sequence No.                    153
Series name                     153
```

### Descriptive Statistics

```markdown
|        | Dataset Name                              | Observation Date   | Series Key              | Series Display Name                         |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                               |
|:-------|:------------------------------------------|:-------------------|:------------------------|:--------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:------------------------------------------|
| count  | 23409                                     | 23409              | 23409                   | 23409                                       |        23409        | 23409       | 23409                |                            0 |      23409     | 23409                                     |
| unique | 1                                         | 153                | 153                     | 153                                         |          nan        | 1           | 1                    |                          nan |        nan     | 153                                       |
| top    | Foreign Investment in Pakistan by Sectors | 31-Mar-2025        | TS_GP_FI_FIPK_M.FIS0010 | 1 Net Foreign Direct Investment in Pakistan |          nan        | Million USD | Normal               |                          nan |        nan     | Net Foreign Direct Investment in Pakistan |
| freq   | 23409                                     | 153                | 153                     | 153                                         |          nan        | 23409       | 23409                |                          nan |        nan     | 153                                       |
| mean   | nan                                       | nan                | nan                     | nan                                         |            8.00548  | nan         | nan                  |                          nan |        770     | nan                                       |
| std    | nan                                       | nan                | nan                     | nan                                         |           36.3831   | nan         | nan                  |                          nan |        441.673 | nan                                       |
| min    | nan                                       | nan                | nan                     | nan                                         |         -532.902    | nan         | nan                  |                          nan |         10     | nan                                       |
| 25%    | nan                                       | nan                | nan                     | nan                                         |            0        | nan         | nan                  |                          nan |        390     | nan                                       |
| 50%    | nan                                       | nan                | nan                     | nan                                         |            0.364902 | nan         | nan                  |                          nan |        770     | nan                                       |
| 75%    | nan                                       | nan                | nan                     | nan                                         |            3.43413  | nan         | nan                  |                          nan |       1150     | nan                                       |
| max    | nan                                       | nan                | nan                     | nan                                         |          973.533    | nan         | nan                  |                          nan |       1530     | nan                                       |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                              | Observation Date   | Series Key              | Series Display Name                         |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                               |
|:------------------------------------------|:-------------------|:------------------------|:--------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:------------------------------------------|
| Foreign Investment in Pakistan by Sectors | 31-Mar-2025        | TS_GP_FI_FIPK_M.FIS0010 | 1 Net Foreign Direct Investment in Pakistan |            25.7486  | Million USD | Normal               |                          nan |             10 | Net Foreign Direct Investment in Pakistan |
| Foreign Investment in Pakistan by Sectors | 31-Mar-2025        | TS_GP_FI_FIPK_M.FIS0020 | ......i Foreign Direct Investment inflows   |           176.55    | Million USD | Normal               |                          nan |             20 | Foreign Direct Investment inflows         |
| Foreign Investment in Pakistan by Sectors | 31-Mar-2025        | TS_GP_FI_FIPK_M.FIS0030 | ......ii Foreign Direct Investment outflows |           150.801   | Million USD | Normal               |                          nan |             30 | Foreign Direct Investment outflows        |
| Foreign Investment in Pakistan by Sectors | 31-Mar-2025        | TS_GP_FI_FIPK_M.FIS0040 | 2 Net FDI in Food Sector                    |             3.70762 | Million USD | Normal               |                          nan |             40 | Net FDI in Food Sector                    |
| Foreign Investment in Pakistan by Sectors | 31-Mar-2025        | TS_GP_FI_FIPK_M.FIS0050 | ......i FDI inflows in  Food Sector         |             3.8856  | Million USD | Normal               |                          nan |             50 | FDI inflows in  Food Sector               |
```


---


## Analysis for: `gdp_domestic_2005.csv` (in `Data` directory)

*	No specific metadata found for `gdp_domestic_2005.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (132, 10) (rows, columns)
* **Total Cells:** 1320
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 132 entries, 0 to 131
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                132 non-null    object 
 1   Observation Date            132 non-null    object 
 2   Series Key                  132 non-null    object 
 3   Series Display Name         132 non-null    object 
 4   Observation Value           131 non-null    float64
 5   Unit                        132 non-null    object 
 6   Observation Status          132 non-null    object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                132 non-null    int64  
 9   Series name                 132 non-null    object 
dtypes: float64(2), int64(1), object(7)
memory usage: 10.4+ KB

```

### Missing Values Summary

Total missing values: 133
Columns with missing values:
```
Observation Value               1
Observation Status Comment    132
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                    1
Observation Date               22
Series Key                      6
Series Display Name             6
Observation Value             131
Unit                            2
Observation Status              2
Observation Status Comment      0
Sequence No.                    6
Series name                     6
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                                           | Observation Date   | Series Key                       | Series Display Name                           |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                |
|:-------|:-----------------------------------------------------------------------|:-------------------|:---------------------------------|:----------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-------------------------------------------|
| count  | 132                                                                    | 132                | 132                              | 132                                           |       131           | 132         | 132                  |                            0 |        132     | 132                                        |
| unique | 1                                                                      | 22                 | 6                                | 6                                             |       nan           | 2           | 2                    |                          nan |        nan     | 6                                          |
| top    | Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | 30-Jun-2021        | TS_GP_GA_FISPAKGDP_Y.GDP00060000 | A. Growth Rate of Real Gross Domestic Product |       nan           | Million PKR | Normal               |                          nan |        nan     | Growth Rate of Real Gross Domestic Product |
| freq   | 132                                                                    | 6                  | 22                               | 22                                            |       nan           | 110         | 131                  |                          nan |        nan     | 22                                         |
| mean   | nan                                                                    | nan                | nan                              | nan                                           |         3.73597e+06 | nan         | nan                  |                          nan |        350     | nan                                        |
| std    | nan                                                                    | nan                | nan                              | nan                                           |         3.20741e+06 | nan         | nan                  |                          nan |        171.433 | nan                                        |
| min    | nan                                                                    | nan                | nan                              | nan                                           |        -0.47        | nan         | nan                  |                          nan |        100     | nan                                        |
| 25%    | nan                                                                    | nan                | nan                              | nan                                           |         1.68954e+06 | nan         | nan                  |                          nan |        200     | nan                                        |
| 50%    | nan                                                                    | nan                | nan                              | nan                                           |         2.61231e+06 | nan         | nan                  |                          nan |        350     | nan                                        |
| 75%    | nan                                                                    | nan                | nan                              | nan                                           |         5.10942e+06 | nan         | nan                  |                          nan |        500     | nan                                        |
| max    | nan                                                                    | nan                | nan                              | nan                                           |         1.30364e+07 | nan         | nan                  |                          nan |        600     | nan                                        |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                                           | Observation Date   | Series Key                       | Series Display Name                                                                                |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                                              |
|:-----------------------------------------------------------------------|:-------------------|:---------------------------------|:---------------------------------------------------------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-----------------------------------------------------------------------------------------|
| Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | 30-Jun-2021        | TS_GP_GA_FISPAKGDP_Y.GDP00060000 | A. Growth Rate of Real Gross Domestic Product                                                      |         3.94        | Percent     | Normal               |                          nan |            100 | Growth Rate of Real Gross Domestic Product                                               |
| Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | 30-Jun-2021        | TS_GP_GA_FISPAKGDP_Y.GDP00050000 | B. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2005-06)): (1+2) |         1.30364e+07 | Million PKR | Normal               |                          nan |            200 | Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2005-06)) |
| Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | 30-Jun-2021        | TS_GP_GA_FISPAKGDP_Y.GDP00010000 | ......1. Commodity Producing Sector (a+b)                                                          |         4.99521e+06 | Million PKR | Normal               |                          nan |            300 | Commodity Producing Sector                                                               |
| Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | 30-Jun-2021        | TS_GP_GA_FISPAKGDP_Y.GDP00020000 | ............a. Agricultural Sector                                                                 |         2.50218e+06 | Million PKR | Normal               |                          nan |            400 | Agricultural Sector                                                                      |
| Gross Domestic Product of Pakistan at constant basic prices of 2005-06 | 30-Jun-2021        | TS_GP_GA_FISPAKGDP_Y.GDP00030000 | ............b. Industrial Sector                                                                   |         2.49303e+06 | Million PKR | Normal               |                          nan |            500 | Industrial Sector                                                                        |
```


---


## Analysis for: `gold_foreign_exchange_reserves.csv` (in `Data` directory)

*	No specific metadata found for `gold_foreign_exchange_reserves.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (6808, 10) (rows, columns)
* **Total Cells:** 68080
* **Data Type Counts:** {dtype('O'): 8, dtype('float64'): 1, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 6808 entries, 0 to 6807
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                6808 non-null   object 
 1   Observation Date            6808 non-null   object 
 2   Series Key                  6808 non-null   object 
 3   Series Display Name         6808 non-null   object 
 4   Observation Value           6808 non-null   float64
 5   Unit                        6808 non-null   object 
 6   Observation Status          6808 non-null   object 
 7   Observation Status Comment  288 non-null    object 
 8   Sequence No.                6808 non-null   int64  
 9   Series name                 6808 non-null   object 
dtypes: float64(1), int64(1), object(8)
memory usage: 532.0+ KB

```

### Missing Values Summary

Total missing values: 6520
Columns with missing values:
```
Observation Status Comment    6520
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                     1
Observation Date               669
Series Key                      19
Series Display Name             19
Observation Value             4392
Unit                             1
Observation Status               1
Observation Status Comment       2
Sequence No.                    19
Series name                     19
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                   | Observation Date   | Series Key                | Series Display Name   |   Observation Value | Unit        | Observation Status   | Observation Status Comment   |   Sequence No. | Series name   |
|:-------|:-----------------------------------------------|:-------------------|:--------------------------|:----------------------|--------------------:|:------------|:---------------------|:-----------------------------|---------------:|:--------------|
| count  | 6808                                           | 6808               | 6808                      | 6808                  |             6808    | 6808        | 6808                 | 288                          |     6808       | 6808          |
| unique | 1                                              | 669                | 19                        | 19                    |              nan    | 1           | 1                    | 2                            |      nan       | 19            |
| top    | Gold and Foreign Exchange Reserves of Pakistan | 30-Jun-2020        | TS_GP_EXT_PAKRES_M.Z00010 | . Gold (1)            |              nan    | Million USD | Normal               | .......                      |      nan       | Gold reserves |
| freq   | 6808                                           | 18                 | 669                       | 669                   |              nan    | 6808        | 6808                 | 198                          |      nan       | 669           |
| mean   | nan                                            | nan                | nan                       | nan                   |             3127.31 | nan         | nan                  | nan                          |        9.19962 | nan           |
| std    | nan                                            | nan                | nan                       | nan                   |             4989.08 | nan         | nan                  | nan                          |        5.83936 | nan           |
| min    | nan                                            | nan                | nan                       | nan                   |             -846    | nan         | nan                  | nan                          |        1       | nan           |
| 25%    | nan                                            | nan                | nan                       | nan                   |               84.15 | nan         | nan                  | nan                          |        4       | nan           |
| 50%    | nan                                            | nan                | nan                       | nan                   |              725    | nan         | nan                  | nan                          |       10       | nan           |
| 75%    | nan                                            | nan                | nan                       | nan                   |             3409.75 | nan         | nan                  | nan                          |       14       | nan           |
| max    | nan                                            | nan                | nan                       | nan                   |            27067.7  | nan         | nan                  | nan                          |       19       | nan           |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                   | Observation Date   | Series Key                | Series Display Name                  |   Observation Value | Unit        | Observation Status   | Observation Status Comment   |   Sequence No. | Series name                     |
|:-----------------------------------------------|:-------------------|:--------------------------|:-------------------------------------|--------------------:|:------------|:---------------------|:-----------------------------|---------------:|:--------------------------------|
| Gold and Foreign Exchange Reserves of Pakistan | 31-Mar-2025        | TS_GP_EXT_PAKRES_M.Z00010 | . Gold (1)                           |           6484.78   | Million USD | Normal               | .                            |              1 | Gold reserves                   |
| Gold and Foreign Exchange Reserves of Pakistan | 31-Mar-2025        | TS_GP_EXT_PAKRES_M.Z00030 | . Net Reserves with SBP (2=4+5-9)    |          10638.9    | Million USD | Normal               | .                            |              2 | Net Reserves with SBP           |
| Gold and Foreign Exchange Reserves of Pakistan | 31-Mar-2025        | TS_GP_EXT_PAKRES_M.Z00020 | . Total SBP Reserves (3=4+5+6+7+8-9) |          10733.5    | Million USD | Normal               | .                            |              3 | Total SBP Reserves              |
| Gold and Foreign Exchange Reserves of Pakistan | 31-Mar-2025        | TS_GP_EXT_PAKRES_M.Z00011 | ....... SDR holdings (4)             |             55.1946 | Million USD | Normal               | .......                      |              4 | Special Drawing rights holdings |
| Gold and Foreign Exchange Reserves of Pakistan | 31-Mar-2025        | TS_GP_EXT_PAKRES_M.Z00013 | ....... Nostro balances (5)          |          10583.7    | Million USD | Normal               | .......                      |              5 | Nostro balances of SBP          |
```


---


## Analysis for: `inflation_base_2007.csv` (in `Data` directory)

*	No specific metadata found for `inflation_base_2007.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (852, 10) (rows, columns)
* **Total Cells:** 8520
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 852 entries, 0 to 851
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                852 non-null    object 
 1   Observation Date            852 non-null    object 
 2   Series Key                  852 non-null    object 
 3   Series Display Name         852 non-null    object 
 4   Observation Value           813 non-null    float64
 5   Unit                        852 non-null    object 
 6   Observation Status          852 non-null    object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                852 non-null    int64  
 9   Series name                 852 non-null    object 
dtypes: float64(2), int64(1), object(7)
memory usage: 66.7+ KB

```

### Missing Values Summary

Total missing values: 891
Columns with missing values:
```
Observation Value              39
Observation Status Comment    852
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                    1
Observation Date              142
Series Key                      6
Series Display Name             6
Observation Value             813
Unit                            1
Observation Status              2
Observation Status Comment      0
Sequence No.                    6
Series name                     6
```

### Descriptive Statistics

```markdown
|        | Dataset Name                            | Observation Date   | Series Key                    | Series Display Name   |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                            |
|:-------|:----------------------------------------|:-------------------|:------------------------------|:----------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:-------------------------------------------------------|
| count  | 852                                     | 852                | 852                           | 852                   |          813        | 852     | 852                  |                            0 |       852      | 852                                                    |
| unique | 1                                       | 142                | 6                             | 6                     |          nan        | 1       | 2                    |                          nan |       nan      | 6                                                      |
| top    | Inflation Snapshot (Base Year: 2007-08) | 30-Apr-2020        | TS_GP_RLS_CPI0708_M.P00010708 | . General CPI (YoY)   |          nan        | Percent | Normal               |                          nan |       nan      | General CPI, an Inflation Measure (Year-on-Year basis) |
| freq   | 852                                     | 6                  | 142                           | 142                   |          nan        | 852     | 813                  |                          nan |       nan      | 142                                                    |
| mean   | nan                                     | nan                | nan                           | nan                   |            4.12924  | nan     | nan                  |                          nan |        35      | nan                                                    |
| std    | nan                                     | nan                | nan                           | nan                   |            5.4814   | nan     | nan                  |                          nan |        17.0883 | nan                                                    |
| min    | nan                                     | nan                | nan                           | nan                   |           -3.67098  | nan     | nan                  |                          nan |        10      | nan                                                    |
| 25%    | nan                                     | nan                | nan                           | nan                   |            0.342904 | nan     | nan                  |                          nan |        20      | nan                                                    |
| 50%    | nan                                     | nan                | nan                           | nan                   |            1.66241  | nan     | nan                  |                          nan |        35      | nan                                                    |
| 75%    | nan                                     | nan                | nan                           | nan                   |            7.34168  | nan     | nan                  |                          nan |        50      | nan                                                    |
| max    | nan                                     | nan                | nan                           | nan                   |           24.8725   | nan     | nan                  |                          nan |        60      | nan                                                    |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                            | Observation Date   | Series Key                    | Series Display Name   |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                              |
|:----------------------------------------|:-------------------|:------------------------------|:----------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:---------------------------------------------------------|
| Inflation Snapshot (Base Year: 2007-08) | 30-Apr-2020        | TS_GP_RLS_CPI0708_M.P00010708 | . General CPI (YoY)   |           9.46195   | Percent | Normal               |                          nan |             10 | General CPI, an Inflation Measure (Year-on-Year basis)   |
| Inflation Snapshot (Base Year: 2007-08) | 30-Apr-2020        | TS_GP_RLS_CPI0708_M.P00020708 | . WPI (YoY)           |           7.34291   | Percent | Normal               |                          nan |             20 | WPI, an Inflation Measure (Year-on-Year basis)           |
| Inflation Snapshot (Base Year: 2007-08) | 30-Apr-2020        | TS_GP_RLS_CPI0708_M.P00030708 | . SPI (YoY)           |          11.7631    | Percent | Normal               |                          nan |             30 | SPI, an Inflation Measure (Year-on-Year basis)           |
| Inflation Snapshot (Base Year: 2007-08) | 30-Apr-2020        | TS_GP_RLS_CPI0708_M.P00040708 | . General CPI (MoM)   |           0.0936786 | Percent | Normal               |                          nan |             40 | General CPI, an Inflation Measure (Month-on-Month basis) |
| Inflation Snapshot (Base Year: 2007-08) | 30-Apr-2020        | TS_GP_RLS_CPI0708_M.P00050708 | . WPI (MoM)           |          -0.772792  | Percent | Normal               |                          nan |             50 | WPI, an Inflation Measure (Month-on-Month basis)         |
```


---


## Analysis for: `inflation_base_2015.csv` (in `Data` directory)

*	No specific metadata found for `inflation_base_2015.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (6360, 10) (rows, columns)
* **Total Cells:** 63600
* **Data Type Counts:** {dtype('O'): 8, dtype('float64'): 1, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 6360 entries, 0 to 6359
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                6360 non-null   object 
 1   Observation Date            6360 non-null   object 
 2   Series Key                  6360 non-null   object 
 3   Series Display Name         6360 non-null   object 
 4   Observation Value           6091 non-null   float64
 5   Unit                        6360 non-null   object 
 6   Observation Status          6360 non-null   object 
 7   Observation Status Comment  239 non-null    object 
 8   Sequence No.                6360 non-null   int64  
 9   Series name                 6360 non-null   object 
dtypes: float64(1), int64(1), object(8)
memory usage: 497.0+ KB

```

### Missing Values Summary

Total missing values: 6390
Columns with missing values:
```
Observation Value              269
Observation Status Comment    6121
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                     1
Observation Date               106
Series Key                      60
Series Display Name             26
Observation Value             2140
Unit                             1
Observation Status               2
Observation Status Comment       1
Sequence No.                    60
Series name                     60
```

### Descriptive Statistics

```markdown
|        | Dataset Name                           | Observation Date   | Series Key               | Series Display Name   |   Observation Value | Unit    | Observation Status   | Observation Status Comment                                                                                                                                                       |   Sequence No. | Series name                                             |
|:-------|:---------------------------------------|:-------------------|:-------------------------|:----------------------|--------------------:|:--------|:---------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------:|:--------------------------------------------------------|
| count  | 6360                                   | 6360               | 6360                     | 6360                  |          6091       | 6360    | 6360                 | 239                                                                                                                                                                              |       6360     | 6360                                                    |
| unique | 1                                      | 106                | 60                       | 26                    |           nan       | 1       | 2                    | 1                                                                                                                                                                                |        nan     | 60                                                      |
| top    | Inflation Snapshot (New Base: 2015-16) | 30-Apr-2025        | TS_GP_PT_CPI_M.P00011516 | ............. Rural   |           nan       | Percent | Normal               | The observation status is missing "MIS" due to trimmed inflation for YoY, MoM, 12MMA and Period Average. Further MIS is also used against 12MMA due to its computational nature. |        nan     | National CPI, an Inflation Measure (Year-on-Year basis) |
| freq   | 6360                                   | 60                 | 106                      | 1272                  |           nan       | 6360    | 6091                 | 239                                                                                                                                                                              |        nan     | 106                                                     |
| mean   | nan                                    | nan                | nan                      | nan                   |             9.60203 | nan     | nan                  | nan                                                                                                                                                                              |        305     | nan                                                     |
| std    | nan                                    | nan                | nan                      | nan                   |             9.72194 | nan     | nan                  | nan                                                                                                                                                                              |        173.195 | nan                                                     |
| min    | nan                                    | nan                | nan                      | nan                   |            -7.4     | nan     | nan                  | nan                                                                                                                                                                              |         10     | nan                                                     |
| 25%    | nan                                    | nan                | nan                      | nan                   |             2.26    | nan     | nan                  | nan                                                                                                                                                                              |        157.5   | nan                                                     |
| 50%    | nan                                    | nan                | nan                      | nan                   |             6.76    | nan     | nan                  | nan                                                                                                                                                                              |        305     | nan                                                     |
| 75%    | nan                                    | nan                | nan                      | nan                   |            13.374   | nan     | nan                  | nan                                                                                                                                                                              |        452.5   | nan                                                     |
| max    | nan                                    | nan                | nan                      | nan                   |            52.4     | nan     | nan                  | nan                                                                                                                                                                              |        600     | nan                                                     |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                           | Observation Date   | Series Key               | Series Display Name          |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                   |
|:---------------------------------------|:-------------------|:-------------------------|:-----------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:--------------------------------------------------------------|
| Inflation Snapshot (New Base: 2015-16) | 30-Apr-2025        | TS_GP_PT_CPI_M.P00011516 | . CPI-YoY-National           |                 0.3 | Percent | Normal               |                          nan |             10 | National CPI, an Inflation Measure (Year-on-Year basis)       |
| Inflation Snapshot (New Base: 2015-16) | 30-Apr-2025        | TS_GP_PT_CPI_M.P00021516 | ............. Urban          |                 0.5 | Percent | Normal               |                          nan |             20 | Urban CPI, an Inflation Measure (Year-on-Year basis)          |
| Inflation Snapshot (New Base: 2015-16) | 30-Apr-2025        | TS_GP_PT_CPI_M.P00041516 | ................... Food     |                -1.9 | Percent | Normal               |                          nan |             30 | Urban Food CPI, an Inflation Measure (Year-on-Year basis)     |
| Inflation Snapshot (New Base: 2015-16) | 30-Apr-2025        | TS_GP_PT_CPI_M.P00061516 | ................... Non-Food |                 2.2 | Percent | Normal               |                          nan |             40 | Urban Non-Food CPI, an Inflation Measure (Year-on-Year basis) |
| Inflation Snapshot (New Base: 2015-16) | 30-Apr-2025        | TS_GP_PT_CPI_M.P00031516 | ............. Rural          |                -0.1 | Percent | Normal               |                          nan |             50 | Rural CPI, an Inflation Measure (Year-on-Year basis)          |
```


---


## Analysis for: `kibor_kibid.csv` (in `Data` directory)

*	No specific metadata found for `kibor_kibid.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (88330, 10) (rows, columns)
* **Total Cells:** 883300
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 88330 entries, 0 to 88329
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                88330 non-null  object 
 1   Observation Date            88330 non-null  object 
 2   Series Key                  88330 non-null  object 
 3   Series Display Name         88330 non-null  object 
 4   Observation Value           88330 non-null  float64
 5   Unit                        88330 non-null  object 
 6   Observation Status          88330 non-null  object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                88330 non-null  int64  
 9   Series name                 88330 non-null  object 
dtypes: float64(2), int64(1), object(7)
memory usage: 6.7+ MB

```

### Missing Values Summary

Total missing values: 88330
Columns with missing values:
```
Observation Status Comment    88330
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                     1
Observation Date              5194
Series Key                      18
Series Display Name             18
Observation Value             1828
Unit                             1
Observation Status               1
Observation Status Comment       0
Sequence No.                    18
Series name                     18
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                   | Observation Date   | Series Key                     | Series Display Name                       |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                             |
|:-------|:-----------------------------------------------|:-------------------|:-------------------------------|:------------------------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:----------------------------------------|
| count  | 88330                                          | 88330              | 88330                          | 88330                                     |         88330       | 88330   | 88330                |                            0 |     88330      | 88330                                   |
| unique | 1                                              | 5194               | 18                             | 18                                        |           nan       | 1       | 1                    |                          nan |       nan      | 18                                      |
| top    | Structure of Interest Rates: KIBORs and KIBIDs | 30-Sep-2014        | TS_GP_BAM_SIRKIBOR_D.KIBOR0030 | . Six-Months Karachi Interbank Offer Rate |           nan       | Percent | Normal               |                          nan |       nan      | Six-Months Karachi Interbank Offer Rate |
| freq   | 88330                                          | 18                 | 5194                           | 5194                                      |           nan       | 88330   | 88330                |                          nan |       nan      | 5194                                    |
| mean   | nan                                            | nan                | nan                            | nan                                       |            10.9541  | nan     | nan                  |                          nan |        90.932  | nan                                     |
| std    | nan                                            | nan                | nan                            | nan                                       |             3.74689 | nan     | nan                  |                          nan |        50.3928 | nan                                     |
| min    | nan                                            | nan                | nan                            | nan                                       |             5.01    | nan     | nan                  |                          nan |        10      | nan                                     |
| 25%    | nan                                            | nan                | nan                            | nan                                       |             8.35    | nan     | nan                  |                          nan |        50      | nan                                     |
| 50%    | nan                                            | nan                | nan                            | nan                                       |            10.34    | nan     | nan                  |                          nan |        90      | nan                                     |
| 75%    | nan                                            | nan                | nan                            | nan                                       |            12.86    | nan     | nan                  |                          nan |       130      | nan                                     |
| max    | nan                                            | nan                | nan                            | nan                                       |            25.16    | nan     | nan                  |                          nan |       180      | nan                                     |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                   | Observation Date   | Series Key                     | Series Display Name                      |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                            |
|:-----------------------------------------------|:-------------------|:-------------------------------|:-----------------------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:---------------------------------------|
| Structure of Interest Rates: KIBORs and KIBIDs | 02-May-2025        | TS_GP_BAM_SIRKIBOR_D.10KIBID1W | . One-Week Karachi Interbank Bid Rate    |               11.87 | Percent | Normal               |                          nan |             10 | One-Week Karachi Interbank Bid Rate    |
| Structure of Interest Rates: KIBORs and KIBIDs | 02-May-2025        | TS_GP_BAM_SIRKIBOR_D.1KIBOR1W  | . One-Week Karachi Interbank Offer Rate  |               12.37 | Percent | Normal               |                          nan |             20 | One-Week Karachi Interbank Offer Rate  |
| Structure of Interest Rates: KIBORs and KIBIDs | 02-May-2025        | TS_GP_BAM_SIRKIBOR_D.11KIBID2W | . Two-Weeks Karachi Interbank Bid Rate   |               11.84 | Percent | Normal               |                          nan |             30 | Two-Weeks Karachi Interbank Bid Rate   |
| Structure of Interest Rates: KIBORs and KIBIDs | 02-May-2025        | TS_GP_BAM_SIRKIBOR_D.2KIBOR2W  | . Two-Weeks Karachi Interbank Offer Rate |               12.34 | Percent | Normal               |                          nan |             40 | Two-Weeks Karachi Interbank Offer Rate |
| Structure of Interest Rates: KIBORs and KIBIDs | 02-May-2025        | TS_GP_BAM_SIRKIBOR_D.12KIBID1M | . One-Month Karachi Interbank Bid Rate   |               11.77 | Percent | Normal               |                          nan |             50 | One-Month Karachi Interbank Bid Rate   |
```


---


## Analysis for: `m2_broad_money.csv` (in `Data` directory)

### Metadata

> * **Business Area:** Monetary and Financial Sector
> * **Dataset Name:** Weekly Broad Money M2
> * **Dataset Description:** Broad Money (M2) is the high frequency aggregate level of monetary assets in the economy. It is compiled on weekly basis through consolidation of SBP and Schedule Banks’ balance sheets data (unaudited). M2 is obtained by aggregating balance sheets items into sub-classification of sectors that provide high frequency firsthand information about developments in four important segments of the economy i.e. Fiscal, External, Real and Banking. Therefore, it facilitates policy makers/researcher/analysts in their macroeconomic analysis, policy and decision making process.
> * **Data Source:** State Bank of Pakistan (easyData Portal)
> * **Data Frequency:** Weekly
> * **Notes/Links:**
>     * Available since 04-Jul-2014
>     * Available upto 18-Apr-2025
>     * Last refresh 30-Apr-2025 
> 
>      https://easydata.sbp.org.pk/apex/f?p=10:211:14540173699877::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_BAM_M2_W,250&cs=150AEEC28EE439E5C043FA596B3BE2F8B
> 
> * **Contains**: M2 Growth, Credit to Private Sector
> 
> ---


### Basic Information

* **Shape:** (28200, 10) (rows, columns)
* **Total Cells:** 282000
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 28200 entries, 0 to 28199
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                28200 non-null  object 
 1   Observation Date            28200 non-null  object 
 2   Series Key                  28200 non-null  object 
 3   Series Display Name         28200 non-null  object 
 4   Observation Value           28200 non-null  float64
 5   Unit                        28200 non-null  object 
 6   Observation Status          28200 non-null  object 
 7   Observation Status Comment  3 non-null      float64
 8   Sequence No.                28200 non-null  int64  
 9   Series name                 28200 non-null  object 
dtypes: float64(2), int64(1), object(7)
memory usage: 2.2+ MB

```

### Missing Values Summary

Total missing values: 28197
Columns with missing values:
```
Observation Status Comment    28197
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                      1
Observation Date                564
Series Key                       50
Series Display Name              45
Observation Value             25403
Unit                              2
Observation Status                1
Observation Status Comment        3
Sequence No.                     50
Series name                      50
```

### Descriptive Statistics

```markdown
|        | Dataset Name          | Observation Date   | Series Key             | Series Display Name                                 |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name             |
|:-------|:----------------------|:-------------------|:-----------------------|:----------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:------------------------|
| count  | 28200                 | 28200              | 28200                  | 28200                                               |     28200           | 28200       | 28200                |                       3      |      28200     | 28200                   |
| unique | 1                     | 564                | 50                     | 45                                                  |       nan           | 2           | 1                    |                     nan      |        nan     | 50                      |
| top    | Weekly Broad Money M2 | 18-Apr-2025        | TS_GP_BAM_M2_W.M000010 | ............................... Deposits with banks |       nan           | Million PKR | Normal               |                     nan      |        nan     | Currency in Circulation |
| freq   | 28200                 | 50                 | 564                    | 1128                                                |       nan           | 26508       | 28200                |                     nan      |        nan     | 564                     |
| mean   | nan                   | nan                | nan                    | nan                                                 |         4.38661e+06 | nan         | nan                  |                      78.1917 |        255     | nan                     |
| std    | nan                   | nan                | nan                    | nan                                                 |         7.22576e+06 | nan         | nan                  |                      81.6056 |        144.311 | nan                     |
| min    | nan                   | nan                | nan                    | nan                                                 |        -8.26837e+06 | nan         | nan                  |                      15.9327 |         10     | nan                     |
| 25%    | nan                   | nan                | nan                    | nan                                                 |    -20807.5         | nan         | nan                  |                      31.9988 |        130     | nan                     |
| 50%    | nan                   | nan                | nan                    | nan                                                 |    703955           | nan         | nan                  |                      48.0649 |        255     | nan                     |
| 75%    | nan                   | nan                | nan                    | nan                                                 |         6.37975e+06 | nan         | nan                  |                     109.321  |        380     | nan                     |
| max    | nan                   | nan                | nan                    | nan                                                 |         3.74315e+07 | nan         | nan                  |                     170.578  |        500     | nan                     |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name          | Observation Date   | Series Key             | Series Display Name                          |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                          |
|:----------------------|:-------------------|:-----------------------|:---------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:---------------------------------------------------------------------|
| Weekly Broad Money M2 | 18-Apr-2025        | TS_GP_BAM_M2_W.M000010 | ......A. Currency in Circulation             |         1.01456e+07 | Million PKR | Normal               |                          nan |             10 | Currency in Circulation                                              |
| Weekly Broad Money M2 | 18-Apr-2025        | TS_GP_BAM_M2_W.M000020 | ......B. Other Deposits with SBP             |     51024.9         | Million PKR | Normal               |                          nan |             20 | Deposits with SBP excluding banks, IMF and other Intl. Organizations |
| Weekly Broad Money M2 | 18-Apr-2025        | TS_GP_BAM_M2_W.M000030 | ......C. Total Deposits with Scheduled Banks |         2.6893e+07  | Million PKR | Normal               |                          nan |             30 | Total Deposits with Scheduled Banks                                  |
| Weekly Broad Money M2 | 18-Apr-2025        | TS_GP_BAM_M2_W.M000040 | ............(i) Demand Deposits              |         2.46804e+07 | Million PKR | Normal               |                          nan |             40 | Demand Deposits                                                      |
| Weekly Broad Money M2 | 18-Apr-2025        | TS_GP_BAM_M2_W.M000050 | ............(ii) Time Deposits               |    502889           | Million PKR | Normal               |                          nan |             50 | Time Deposits                                                        |
```


---


## Analysis for: `policy_rate.csv` (in `Data` directory)

### Metadata

> * **Business Area:** Interest Rates
> * **Dataset Name:** Structure of Interest Rate: State Bank of Pakistan Policy Rates
> * **Dataset Description:** This dataset pertains to SBP Policy (Target) Rate. Earlier, SBP 3-Day Repo Facility rate was considered as policy rate. Since August 17, 2009; vide DMMD Circular # 01 of 2009, it was replaced with SBP O/N Reverse Repo Rate; which remained SBP policy rate till May 24, 2015 when (w.e.f. May 25, 2015) Vide DMMD Circular # 09 of 2015 SBP introduced this Policy (Target) Rate.
> * **Data Source:** 	State Bank of Pakistan
> * **Data Frequency:** As-Needed
> * **Notes/Links:**
>     * Available since 01-Jan-1956
>     * Available upto 28-Jan-2025
>     * Last refresh 28-Jan-2025
>     
>     https://easydata.sbp.org.pk/apex/f?p=10:211:14540173699877::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_IR_SIRPR_AH,250&cs=18F6A1529BBDB9B9316E47F915592D5DD
>    
> 
> * **Contains**: Policy Rates
> 
> ---
> 
> ### 3. `kibor_kibid.csv`
> 
> * **Business Area:** Interest Rates
> * **Dataset Name:** Structure of Interest Rates: KIBORs and KIBIDs 
> * **Dataset Description:** 	This dataset shows the following daily benchmark rates:
> 1. KIBOR
> 2. KIBID
> KIBOR and KIBID are daily interest rate benchmarks. At KIBID / KIBOR, a bank bids / offers to lend / borrow unsecured funds to / from other banks in the Karachi interbank money market. KIBOR is widely used interest rate benchmark used by banks to lend money to consumers and businesses in Pakistan.
> * **Data Source:** State Bank of Pakistan
> * **Data Frequency:** 	Daily
> * **Notes/Links:**
>     * Available since	09-Jun-2005
>     * Available upto 02-May-2025
>     * Last refresh 	02-May-2025
> 
>     https://easydata.sbp.org.pk/apex/f?p=10:211:14540173699877::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_BAM_SIRKIBOR_D,250&cs=14C5EB95804F108DCDD543E61D6A4E4C5
>     
>    
> * **Contains:**  KIBORs and KIBIDs
> 
> ---
> 
> ### 4. `t_bills.csv`
> 
> * **Business Area:** Interest Rates
> * **Dataset Name:** Structure of Interest Rate: T-Bills Auction Result
> * **Dataset Description:** This dataset is based on data of auction results of Treasury Bills of Pakistan.
> * **Data Source:** State Bank of Pakistan
> * **Data Frequency:** As-Needed
> * **Notes/Links:**
>     * Available since 	24-Jun-2004
>     * Available upto 	26-Mar-2025
>     * Last refresh 03-Apr-2025
> 
>     https://easydata.sbp.org.pk/apex/f?p=10:211:14540173699877::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_BAM_SIRTBIL_AH,250&cs=1A7AEFB06A69A1B7ABCFE71AE72002D92
>    
> * **Contains:** T-bills.
> 
> ---
> 
> ### 5. `exchange_rate.csv`
> 
> * **Business Area:** External Sector
> * **Dataset Name:** Bank Floating Daily Average Exchange Rates (PKR per National Currency)
> * **Dataset Description:** This dataset is based on daily average of bank floating exchange rates of tradeable currencies. This daily data is compiled and disseminated on monthly basis.
> * **Data Source:** State Bank of Pakistan
> * **Data Frequency:** 	Daily
> * **Notes/Links:**
>     * Available since	02-Jul-2013
>     * Available upto 	28-Mar-2025
>     * Last refresh 08-Apr-2025
> 
> https://easydata.sbp.org.pk/apex/f?p=10:211:10924627559931::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_ES_FADERPKR_M,250&cs=1E6A0FE9A4DB9761ACD10F0AC21106046
> 
>     
> * **Contains:**  Exchange rates
> 
> ---
> 
> ### 6. `country_wise_remittance.csv`
> 
> * **Business Area:** 	External Sector
> * **Dataset Name:** 	Country-wise Workers' Remittances
> * **Dataset Description:** 	This dataset is based on inward remittances sent by overseas Pakistanis, working abroad, for the purpose of family maintenance in Pakistan.
> 
> The data of Workers’ Remittances includes the conversions related to current transfers from Roshan Digital Accounts since September 2020.
> 
> From July, 2019 data is based on original country of remitter. The details of country-wise revisions are available at: http://www.sbp.org.pk/departments/stats/AdvanceNotice.pdf
> 
> Prior to July 2018, countries at serial number 7 (Malaysia), 13 (South Africa) and 14 (South Korea) were recorded under Other Countries (serial number 15). Similarly, encashments from FCBCs and FEBCs are recorded under 'Other Countries' at serial number 15 from July 2022.
> 
> For explanation on data compilation methodology, please click here.
> * **Data Source:** State Bank of Pakistan
> * **Data Frequency:** Monthly
> * **Notes/Links:**
>     * Available since Jul-1972 
>     * Available upto Mar-2025
>     * Last refresh 	14-Apr-2025
> 
> https://easydata.sbp.org.pk/apex/f?p=10:211:10924627559931::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_BOP_WR_M,250&cs=157866335180CD2B7910AF42D3E4C3C43
>     
> * **Contains:**  Country wise remittances
>    
> ---
> 
> ### 7. `seasonal_worker_remittance.csv`
> 
> * **Business Area:** External Sector
> * **Dataset Name:** Seasonally Adjusted Workers’ Remittances
> * **Dataset Description:** This dataset is based on Seasonally Adjusted Workers’ Remittances. It is compiled on monthly basis using X12 ARIMA and MINITAB.
> * **Data Source:** State Bank of Pakistan
> * **Data Frequency:** 	Monthly
> * **Notes/Links:**
>     * Available since	Jul-2005
>     * Available upto	Mar-2025
>     * Last refresh 	14-Apr-2025
> 
> https://easydata.sbp.org.pk/apex/f?p=10:211:10924627559931::NO:RP:P211_DATASET_TYPE_CODE,P211_PAGE_ID:TS_GP_ES_SWR_M,250&cs=13B7D21544C7E31201837385310579968
>     
> * **Contains:**  Worker remittance
> 
> ---


### Basic Information

* **Shape:** (182, 10) (rows, columns)
* **Total Cells:** 1820
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 182 entries, 0 to 181
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                182 non-null    object 
 1   Observation Date            182 non-null    object 
 2   Series Key                  182 non-null    object 
 3   Series Display Name         182 non-null    object 
 4   Observation Value           182 non-null    float64
 5   Unit                        182 non-null    object 
 6   Observation Status          182 non-null    object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                182 non-null    int64  
 9   Series name                 182 non-null    object 
dtypes: float64(2), int64(1), object(7)
memory usage: 14.3+ KB

```

### Missing Values Summary

Total missing values: 182
Columns with missing values:
```
Observation Status Comment    182
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                   1
Observation Date              93
Series Key                     3
Series Display Name            3
Observation Value             56
Unit                           1
Observation Status             1
Observation Status Comment     0
Sequence No.                   3
Series name                    3
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                                    | Observation Date   | Series Key                  | Series Display Name                          |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                |
|:-------|:----------------------------------------------------------------|:-------------------|:----------------------------|:---------------------------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:-------------------------------------------|
| count  | 182                                                             | 182                | 182                         | 182                                          |           182       | 182     | 182                  |                            0 |      182       | 182                                        |
| unique | 1                                                               | 93                 | 3                           | 3                                            |           nan       | 1       | 1                    |                          nan |      nan       | 3                                          |
| top    | Structure of Interest Rate: State Bank of Pakistan Policy Rates | 28-Jan-2025        | TS_GP_IR_SIRPR_AH.SBPOL0010 | . State Bank of Pakistan's Reverse Repo Rate |           nan       | Percent | Normal               |                          nan |      nan       | State Bank of Pakistan's Reverse Repo Rate |
| freq   | 182                                                             | 3                  | 93                          | 93                                           |           nan       | 182     | 182                  |                          nan |      nan       | 93                                         |
| mean   | nan                                                             | nan                | nan                         | nan                                          |            11.4973  | nan     | nan                  |                          nan |       16.8681  | nan                                        |
| std    | nan                                                             | nan                | nan                         | nan                                          |             4.43531 | nan     | nan                  |                          nan |        7.83632 | nan                                        |
| min    | nan                                                             | nan                | nan                         | nan                                          |             3       | nan     | nan                  |                          nan |       10       | nan                                        |
| 25%    | nan                                                             | nan                | nan                         | nan                                          |             8       | nan     | nan                  |                          nan |       10       | nan                                        |
| 50%    | nan                                                             | nan                | nan                         | nan                                          |            10.625   | nan     | nan                  |                          nan |       10       | nan                                        |
| 75%    | nan                                                             | nan                | nan                         | nan                                          |            14       | nan     | nan                  |                          nan |       20       | nan                                        |
| max    | nan                                                             | nan                | nan                         | nan                                          |            23       | nan     | nan                  |                          nan |       30       | nan                                        |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                                    | Observation Date   | Series Key                  | Series Display Name                             |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                   |
|:----------------------------------------------------------------|:-------------------|:----------------------------|:------------------------------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:----------------------------------------------|
| Structure of Interest Rate: State Bank of Pakistan Policy Rates | 28-Jan-2025        | TS_GP_IR_SIRPR_AH.SBPOL0010 | . State Bank of Pakistan's Reverse Repo Rate    |                  13 | Percent | Normal               |                          nan |             10 | State Bank of Pakistan's Reverse Repo Rate    |
| Structure of Interest Rate: State Bank of Pakistan Policy Rates | 28-Jan-2025        | TS_GP_IR_SIRPR_AH.SBPOL0020 | . State Bank of Pakistan's Repo Rate            |                  11 | Percent | Normal               |                          nan |             20 | State Bank of Pakistan's Repo Rate            |
| Structure of Interest Rate: State Bank of Pakistan Policy Rates | 28-Jan-2025        | TS_GP_IR_SIRPR_AH.SBPOL0030 | . State Bank of Pakistan's Policy (Target) Rate |                  12 | Percent | Normal               |                          nan |             30 | State Bank of Pakistan's Policy (Target) Rate |
| Structure of Interest Rate: State Bank of Pakistan Policy Rates | 17-Dec-2024        | TS_GP_IR_SIRPR_AH.SBPOL0010 | . State Bank of Pakistan's Reverse Repo Rate    |                  14 | Percent | Normal               |                          nan |             10 | State Bank of Pakistan's Reverse Repo Rate    |
| Structure of Interest Rate: State Bank of Pakistan Policy Rates | 17-Dec-2024        | TS_GP_IR_SIRPR_AH.SBPOL0020 | . State Bank of Pakistan's Repo Rate            |                  12 | Percent | Normal               |                          nan |             20 | State Bank of Pakistan's Repo Rate            |
```


---


## Analysis for: `quaterly_gdp_2015.csv` (in `Data` directory)

*	No specific metadata found for `quaterly_gdp_2015.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (304, 10) (rows, columns)
* **Total Cells:** 3040
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 304 entries, 0 to 303
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                304 non-null    object 
 1   Observation Date            304 non-null    object 
 2   Series Key                  304 non-null    object 
 3   Series Display Name         304 non-null    object 
 4   Observation Value           288 non-null    float64
 5   Unit                        304 non-null    object 
 6   Observation Status          304 non-null    object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                304 non-null    int64  
 9   Series name                 304 non-null    object 
dtypes: float64(2), int64(1), object(7)
memory usage: 23.9+ KB

```

### Missing Values Summary

Total missing values: 320
Columns with missing values:
```
Observation Value              16
Observation Status Comment    304
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                    1
Observation Date               38
Series Key                      8
Series Display Name             8
Observation Value             281
Unit                            2
Observation Status              2
Observation Status Comment      0
Sequence No.                    8
Series name                     8
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                      | Observation Date   | Series Key                       | Series Display Name                                                                         |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                                              |
|:-------|:--------------------------------------------------|:-------------------|:---------------------------------|:--------------------------------------------------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-----------------------------------------------------------------------------------------|
| count  | 304                                               | 304                | 304                              | 304                                                                                         |       288           | 304         | 304                  |                            0 |        304     | 304                                                                                      |
| unique | 1                                                 | 38                 | 8                                | 8                                                                                           |       nan           | 2           | 2                    |                          nan |        nan     | 8                                                                                        |
| top    | Quarterly GDP at Constant Basic Prices of 2015-16 | 31-Dec-2024        | TS_GP_RS_QGDP1516_Q.QGDP00070000 | A. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16)) |       nan           | Million PKR | Normal               |                          nan |        nan     | Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16)) |
| freq   | 304                                               | 8                  | 38                               | 38                                                                                          |       nan           | 152         | 288                  |                          nan |        nan     | 38                                                                                       |
| mean   | nan                                               | nan                | nan                              | nan                                                                                         |         2.36032e+06 | nan         | nan                  |                          nan |        450     | nan                                                                                      |
| std    | nan                                               | nan                | nan                              | nan                                                                                         |         3.10251e+06 | nan         | nan                  |                          nan |        229.507 | nan                                                                                      |
| min    | nan                                               | nan                | nan                              | nan                                                                                         |       -20.88        | nan         | nan                  |                          nan |        100     | nan                                                                                      |
| 25%    | nan                                               | nan                | nan                              | nan                                                                                         |         3.625       | nan         | nan                  |                          nan |        275     | nan                                                                                      |
| 50%    | nan                                               | nan                | nan                              | nan                                                                                         |         1.58679e+06 | nan         | nan                  |                          nan |        450     | nan                                                                                      |
| 75%    | nan                                               | nan                | nan                              | nan                                                                                         |         4.37711e+06 | nan         | nan                  |                          nan |        625     | nan                                                                                      |
| max    | nan                                               | nan                | nan                              | nan                                                                                         |         1.01353e+07 | nan         | nan                  |                          nan |        800     | nan                                                                                      |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                      | Observation Date   | Series Key                       | Series Display Name                                                                                       |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                                                              |
|:--------------------------------------------------|:-------------------|:---------------------------------|:----------------------------------------------------------------------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:-----------------------------------------------------------------------------------------|
| Quarterly GDP at Constant Basic Prices of 2015-16 | 31-Dec-2024        | TS_GP_RS_QGDP1516_Q.QGDP00070000 | A. Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16))               |         1.01353e+07 | Million PKR | Normal               |                          nan |            100 | Gross Domestic Product (Total of Gross Value Addition at Constant Basic Prices(2015-16)) |
| Quarterly GDP at Constant Basic Prices of 2015-16 | 31-Dec-2024        | TS_GP_RS_QGDP1516_Q.QGDP00080000 | B. Growth Rate of Gross Domestic Product (Total of Gross Value Addition at Constant Factor Cost(2015-16)) |         1.73        | Percent     | Normal               |                          nan |            200 | Growth Rate of Real Gross Domestic Product                                               |
| Quarterly GDP at Constant Basic Prices of 2015-16 | 31-Dec-2024        | TS_GP_RS_QGDP1516_Q.QGDP00010000 | ......I(a). Agricultural Sector                                                                           |         2.39042e+06 | Million PKR | Normal               |                          nan |            300 | Agricultural Sector                                                                      |
| Quarterly GDP at Constant Basic Prices of 2015-16 | 31-Dec-2024        | TS_GP_RS_QGDP1516_Q.QGDP00020000 | ......I(b). Growth Rate of Agriculture Sector                                                             |         1.1         | Percent     | Normal               |                          nan |            400 | Growth Rate of Agriculture Sector                                                        |
| Quarterly GDP at Constant Basic Prices of 2015-16 | 31-Dec-2024        | TS_GP_RS_QGDP1516_Q.QGDP00030000 | ......II(a). Industrial Sector                                                                            |         1.76004e+06 | Million PKR | Normal               |                          nan |            500 | Industrial Sector                                                                        |
```


---


## Analysis for: `seasonal_worker_remittance.csv` (in `Data` directory)

*	No specific metadata found for `seasonal_worker_remittance.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (474, 10) (rows, columns)
* **Total Cells:** 4740
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 474 entries, 0 to 473
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                474 non-null    object 
 1   Observation Date            474 non-null    object 
 2   Series Key                  474 non-null    object 
 3   Series Display Name         474 non-null    object 
 4   Observation Value           474 non-null    float64
 5   Unit                        474 non-null    object 
 6   Observation Status          474 non-null    object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                474 non-null    int64  
 9   Series name                 474 non-null    object 
dtypes: float64(2), int64(1), object(7)
memory usage: 37.2+ KB

```

### Missing Values Summary

Total missing values: 474
Columns with missing values:
```
Observation Status Comment    474
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                    1
Observation Date              237
Series Key                      2
Series Display Name             2
Observation Value             474
Unit                            1
Observation Status              1
Observation Status Comment      0
Sequence No.                    1
Series name                     2
```

### Descriptive Statistics

```markdown
|        | Dataset Name                             | Observation Date   | Series Key             | Series Display Name        |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name         |
|:-------|:-----------------------------------------|:-------------------|:-----------------------|:---------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:--------------------|
| count  | 474                                      | 474                | 474                    | 474                        |             474     | 474         | 474                  |                            0 |            474 | 474                 |
| unique | 1                                        | 237                | 2                      | 2                          |             nan     | 1           | 1                    |                          nan |            nan | 2                   |
| top    | Seasonally Adjusted Workers’ Remittances | 31-Mar-2025        | TS_GP_ES_SWR_M.SWR0001 | 1 Workers Remittances (WR) |             nan     | Million USD | Normal               |                          nan |            nan | Workers Remittances |
| freq   | 474                                      | 2                  | 237                    | 237                        |             nan     | 474         | 474                  |                          nan |            nan | 237                 |
| mean   | nan                                      | nan                | nan                    | nan                        |            1503.93  | nan         | nan                  |                          nan |              1 | nan                 |
| std    | nan                                      | nan                | nan                    | nan                        |             774.728 | nan         | nan                  |                          nan |              0 | nan                 |
| min    | nan                                      | nan                | nan                    | nan                        |             308.81  | nan         | nan                  |                          nan |              1 | nan                 |
| 25%    | nan                                      | nan                | nan                    | nan                        |             804.543 | nan         | nan                  |                          nan |              1 | nan                 |
| 50%    | nan                                      | nan                | nan                    | nan                        |            1505.22  | nan         | nan                  |                          nan |              1 | nan                 |
| 75%    | nan                                      | nan                | nan                    | nan                        |            2049.18  | nan         | nan                  |                          nan |              1 | nan                 |
| max    | nan                                      | nan                | nan                    | nan                        |            4055.33  | nan         | nan                  |                          nan |              1 | nan                 |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                             | Observation Date   | Series Key             | Series Display Name                           |   Observation Value | Unit        | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                           |
|:-----------------------------------------|:-------------------|:-----------------------|:----------------------------------------------|--------------------:|:------------|:---------------------|-----------------------------:|---------------:|:--------------------------------------|
| Seasonally Adjusted Workers’ Remittances | 31-Mar-2025        | TS_GP_ES_SWR_M.SWR0001 | 1 Workers Remittances (WR)                    |             4055.33 | Million USD | Normal               |                          nan |              1 | Workers Remittances                   |
| Seasonally Adjusted Workers’ Remittances | 31-Mar-2025        | TS_GP_ES_SWR_M.SWR0002 | 1 Seasonally adjusted Worker Remittance (SWR) |             3582.67 | Million USD | Normal               |                          nan |              1 | Seasonally adjusted Worker Remittance |
| Seasonally Adjusted Workers’ Remittances | 28-Feb-2025        | TS_GP_ES_SWR_M.SWR0002 | 1 Seasonally adjusted Worker Remittance (SWR) |             3454.04 | Million USD | Normal               |                          nan |              1 | Seasonally adjusted Worker Remittance |
| Seasonally Adjusted Workers’ Remittances | 28-Feb-2025        | TS_GP_ES_SWR_M.SWR0001 | 1 Workers Remittances (WR)                    |             3124.44 | Million USD | Normal               |                          nan |              1 | Workers Remittances                   |
| Seasonally Adjusted Workers’ Remittances | 31-Jan-2025        | TS_GP_ES_SWR_M.SWR0002 | 1 Seasonally adjusted Worker Remittance (SWR) |             3295.86 | Million USD | Normal               |                          nan |              1 | Seasonally adjusted Worker Remittance |
```


---


## Analysis for: `t_bills.csv` (in `Data` directory)

*	No specific metadata found for `t_bills.csv` in `datasets_info.md`.*

### Basic Information

* **Shape:** (3276, 10) (rows, columns)
* **Total Cells:** 32760
* **Data Type Counts:** {dtype('O'): 7, dtype('float64'): 2, dtype('int64'): 1}

### DataFrame Info Summary

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 3276 entries, 0 to 3275
Data columns (total 10 columns):
 #   Column                      Non-Null Count  Dtype  
---  ------                      --------------  -----  
 0   Dataset Name                3276 non-null   object 
 1   Observation Date            3276 non-null   object 
 2   Series Key                  3276 non-null   object 
 3   Series Display Name         3276 non-null   object 
 4   Observation Value           2773 non-null   float64
 5   Unit                        3276 non-null   object 
 6   Observation Status          3276 non-null   object 
 7   Observation Status Comment  0 non-null      float64
 8   Sequence No.                3276 non-null   int64  
 9   Series name                 3276 non-null   object 
dtypes: float64(2), int64(1), object(7)
memory usage: 256.1+ KB

```

### Missing Values Summary

Total missing values: 3779
Columns with missing values:
```
Observation Value              503
Observation Status Comment    3276
```

### Unique Values per Column (Sample)

Showing unique counts for first/last 5 columns (Total columns: 10):
```
Dataset Name                     1
Observation Date               546
Series Key                       6
Series Display Name              6
Observation Value             1676
Unit                             1
Observation Status               2
Observation Status Comment       0
Sequence No.                     6
Series name                      6
```

### Descriptive Statistics

```markdown
|        | Dataset Name                                       | Observation Date   | Series Key                  | Series Display Name                      |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                            |
|:-------|:---------------------------------------------------|:-------------------|:----------------------------|:-----------------------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:---------------------------------------|
| count  | 3276                                               | 3276               | 3276                        | 3276                                     |          2773       | 3276    | 3276                 |                            0 |      3276      | 3276                                   |
| unique | 1                                                  | 546                | 6                           | 6                                        |           nan       | 1       | 2                    |                          nan |       nan      | 6                                      |
| top    | Structure of Interest Rate: T-Bills Auction Result | 26-Mar-2025        | TS_GP_BAM_SIRTBIL_AH.TB0010 | . Treasury Bills' Cut-off Yield 3-Months |           nan       | Percent | Normal               |                          nan |       nan      | Treasury Bills' Cut-off Yield 3-Months |
| freq   | 3276                                               | 6                  | 546                         | 546                                      |           nan       | 3276    | 2769                 |                          nan |       nan      | 546                                    |
| mean   | nan                                                | nan                | nan                         | nan                                      |            10.8965  | nan     | nan                  |                          nan |        35      | nan                                    |
| std    | nan                                                | nan                | nan                         | nan                                      |             4.24072 | nan     | nan                  |                          nan |        17.0809 | nan                                    |
| min    | nan                                                | nan                | nan                         | nan                                      |             0.1215  | nan     | nan                  |                          nan |        10      | nan                                    |
| 25%    | nan                                                | nan                | nan                         | nan                                      |             7.8382  | nan     | nan                  |                          nan |        20      | nan                                    |
| 50%    | nan                                                | nan                | nan                         | nan                                      |             9.9763  | nan     | nan                  |                          nan |        35      | nan                                    |
| 75%    | nan                                                | nan                | nan                         | nan                                      |            13.022   | nan     | nan                  |                          nan |        50      | nan                                    |
| max    | nan                                                | nan                | nan                         | nan                                      |            25.07    | nan     | nan                  |                          nan |        60      | nan                                    |
```

### Data Sample (All 10 columns)

*	Showing the first 5 rows.*

```markdown
| Dataset Name                                       | Observation Date   | Series Key                  | Series Display Name                               |   Observation Value | Unit    | Observation Status   |   Observation Status Comment |   Sequence No. | Series name                                     |
|:---------------------------------------------------|:-------------------|:----------------------------|:--------------------------------------------------|--------------------:|:--------|:---------------------|-----------------------------:|---------------:|:------------------------------------------------|
| Structure of Interest Rate: T-Bills Auction Result | 26-Mar-2025        | TS_GP_BAM_SIRTBIL_AH.TB0010 | . Treasury Bills' Cut-off Yield 3-Months          |               12.01 | Percent | Normal               |                          nan |             10 | Treasury Bills' Cut-off Yield 3-Months          |
| Structure of Interest Rate: T-Bills Auction Result | 26-Mar-2025        | TS_GP_BAM_SIRTBIL_AH.TB0020 | . Treasury Bills' Cut-off Yield 6-Months          |               12    | Percent | Normal               |                          nan |             20 | Treasury Bills' Cut-off Yield 6-Months          |
| Structure of Interest Rate: T-Bills Auction Result | 26-Mar-2025        | TS_GP_BAM_SIRTBIL_AH.TB0030 | . Treasury Bills' Cut-off Yield 12-Months         |               12.01 | Percent | Normal               |                          nan |             30 | Treasury Bills' Cut-off Yield 12-Months         |
| Structure of Interest Rate: T-Bills Auction Result | 26-Mar-2025        | TS_GP_BAM_SIRTBIL_AH.TB0040 | . Treasury Bills' Weighted Average Yield 3-Months |               11.83 | Percent | Normal               |                          nan |             40 | Treasury Bills' Weighted Average Yield 3-Months |
| Structure of Interest Rate: T-Bills Auction Result | 26-Mar-2025        | TS_GP_BAM_SIRTBIL_AH.TB0050 | . Treasury Bills' Weighted Average Yield 6-Months |               11.92 | Percent | Normal               |                          nan |             50 | Treasury Bills' Weighted Average Yield 6-Months |
```


---

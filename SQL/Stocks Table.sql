select * from Stocks

create table Stocks
([Date] datetime PRIMARY KEY,
[Open] float,
[High] float,
[Low] float,
[Close] float,
[Adj Close] float,
[Volume] int,
[30_day_MA] float,
[100_day_MA] float,
[Daily_Return] float)

select * from Stocks
/*-------------------------------------------------------------------
                    SQL PARTITIONING (In Progress)
---------------------------------------------------------------------
Divides a large table into smaller partitions while SQL still 
treats it as one logical table. Improves query/index efficiency 
by letting SQL scan only the relevant partition.

Partition key: usually a date column, sometimes region/category.
RANGE LEFT vs RANGE RIGHT: determines which side of a boundary 
value it belongs to.
Filegroups: logical containers for physical data files.

*/
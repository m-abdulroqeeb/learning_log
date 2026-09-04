/*-------------------------------------------------------------------------------------------- 
	NUMBER FUNCTIONS
 ----------------------------------------------------------------------------------------------
 This page treats the functions we use on numeric data.
 Which are ROUND(for approximation), and ABS(To ensure the number is positive).
*/
-- ROUND
SELECT 
	3.516 AS num,
	ROUND(3.516,2) AS num2,
	ROUND(3.516,1) AS num1
/* ROUND: To approximate a decimal number*/

-- ABS
SELECT 
	-10 AS num,
	ABS(-10) AS abs_num1,
	ABS(10) AS abs_num2
/*ABS(Absolute): To give absolute of any number. In other words, to make sure a number remains positive.*/
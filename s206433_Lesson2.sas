DATA lesson2 (LABEL = 'Comics Character Data');
LIBNAME  Homework 'C:\Users\s206433';        /*Set up a libref named 'Homework' pointing to the directory 'C:\Users\your student ID'*/
libref. Homework;
SET s206433;    /*Save SAS data set name as your student ID*/ 
INPUT Id Name $ Height Weight DoB MMDDYY8. @@;
LABEL Id = 'Identification no.'
Height = 'Height in inches'
Weight = 'Weight in pounds'
DoB = 'Date of birth';
INFORMAT DoB MMDDYY8.;
FORMAT DoB WORDDATE18.;
DATALINES;
53 Susie 42 . 07-11-97 54 Charlie 46 55 10-26-94
55 Calvin 40 35 01-10-98 56 Lucy . 52 01-13-95
57 . 49 58 12-28-01 58 Stan 45 40 02-24-99
; 
PROC PRINT DATA = lesson2;     /*Print the dataset in results viewer window*/
PROC CONTENTS DATA=Homework._ALL_ NODETALLS;    /*Print the description & variable attributes of dataset in results viewer window*/ 
Run;

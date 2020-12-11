Data mark1;
INFILE 'C:\Users\s206433\Lesson 5\Mark_1.txt\'
DLM='09'X
FIRSTOBS=2;
INPUT sid $  f_name $ l_name $ q1 q2 ca;
PROC SORT Data=mark1;
BY sid;
RUN;

Data mark2;
INFILE 'C:\Users\s206433\Lesson 5\Mark_2.csv\'
DLM=','
FIRSTOBS=2;
INPUT sid $ mt final total grade $;
PROC SORT Data=mark2;
BY sid;
RUN;

Data mark3;
INFILE 'C:\Users\s206433\Lesson 5\Mark_3.dat\' TRUNCOVER 
FIRSTOBS=2;
INPUT sid $  f_name $10-20 l_name $21-30 q1 q2 ca mt final total 83-86 grade $87;
PROC SORT Data=mark3;
BY sid;
RUN; 

Data mark_t;
INFILE 'C:\Users\s206433\Lesson 5\Mark_UP.dat\'
DLM=';'
FIRSTOBS=2;
INPUT sid $  f_name $ l_name $ q1 q2 ca mt final total grade $;
PROC SORT DATA = mark_t;
BY sid;
RUN;

Data mark4;
MERGE mark1 mark2;
BY sid;
RUN;

Data mark_m;
SET mark4 mark3;
BY sid;
RUN;

Data mark_final;
UPDATE mark_m  mark_t;
BY sid;
RUN;

Data mark_change;
UPDATE mark_m (IN= new) mark_t;
BY sid f_name l_name q1 q2 ca mt final total grade;
IF new= 0;
RUN;

Data mark_top1;
SET mark_final;
sid = SUBSTR(sid,2,2); 
PROC SORT Data = mark_top1;
BY DESCENDING sid total;

Data mark_top;
SET mark_top1;
BY DESCENDING sid total;
IF Last.sid=1;

PROC PRINT DATA = mark1;
PROC PRINT DATA = mark2;
PROC PRINT DATA = mark3;
PROC PRINT DATA = mark4;
PROC PRINT DATA = mark_t;
PROC PRINT DATA = mark_m;
PROC PRINT DATA = mark_final; TITLE 'Final Result';
PROC PRINT DATA = mark_change; TITLE 'Records updated';
PROC PRINT DATA = mark_top; TITLE 'Highest score by year';
RUN;

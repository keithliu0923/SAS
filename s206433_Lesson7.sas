DATA mark_g;
INFILE 'C:\Users\s206433\Mark_gender.dat'
DLM = ','
FIRSTOBS = 2;
INPUT sid $ f_name $ l_name $ gender $ q1 q2 ca mt final total grade $;
RUN;
PROC SGPLOT DATA = mark_g;  /*step(i)*/
SCATTER X=mt Y=final;
XAXIS LABEL  = 'Midterm Score' VALUES = (50 TO 100 BY 10);
YAXIS LABEL  = 'Final Score' VALUES = (20 TO 100 BY 20);
TITLE 'Midterm vs Final Score for AMS1001';
RUN;
PROC UNIVARIATE DATA = mark_g; /*step(ii)*/
VAR ca;
HISTOGRAM ca/NORMAL;
PROBPLOT ca;
QQPLOT ca;
RUN;
PROC CORR DATA = mark_g PLOTS=MATRIX(HISTOGRAM); /*step(iii)*/
VAR q1 q2 mt final;
RUN;
PROC TTEST DATA =  mark_g; /*step(iv)*/
CLASS gender;
VAR final;
RUN;
Data mark_year;
SET mark_g;
sid = SUBSTR(sid,2,2);
RUN; 
PROC ANOVA DATA= mark_year;
CLASS sid;
MODEL total;
RUN;

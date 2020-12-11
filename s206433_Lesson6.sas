DATA mark_all;
	INFILE 'C:\Users\s198120\Mark_all.dat' DSD
	DLM = ','
	FIRSTOBS = 2;
	INPUT sid $ f_name $ l_name $ q1 q2 ca mt final total grade $;
RUN;

PROC SORT DATA = mark_all;
	BY grade;

PROC PRINT DATA = mark_all;
	BY grade;
	PAGEBY grade;
RUN;

PROC FORMAT;
	VALUE mid_review 0 -< 60 = 'poor'
				  60 -< 70 = 'average'
				  70 -< 80 = 'good'
				  80 - HIGH = 'excellent';

PROC PRINT DATA = mark_all;
	FORMAT ca mid_review.;
RUN;

DATA mark_means;
	SET mark_all;

PROC SORT DATA = mark_means;
	BY ca;

PROC MEANS DATA = mark_means;
	BY ca;
	FORMAT ca mid_review.;
RUN;

PROC MEANS DATA = mark_means;
	CLASS ca;
	FORMAT ca mid_review.;
RUN;

PROC TABULATE DATA = mark_all;
	CLASS ca grade;
	VAR mt final;
	TABLE MEAN*(mt*FORMAT = 8.1 final*FORMAT = 8.1)*ca, grade;
	FORMAT ca mid_review.;
RUN;

PROC REPORT DATA = mark_all;
	COLUMN ca grade N (mt final),MEDIAN;
	DEFINE ca / GROUP;
	DEFINE grade / GROUP;
	FORMAT ca mid_review.;
RUN;

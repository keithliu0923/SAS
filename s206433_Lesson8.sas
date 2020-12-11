DATA  mark_g;
	INFILE 'C:\Users\s206433\Mark_gender.dat' DSD
	DLM = ','
	FIRSTOBS = 2; 
	INPUT sid $ f_name $ l_name $ gender $ q1 q2 ca mt final total grade $; 

/*(i)*/
PROC TABULATE DATA = mark_g; 
	CLASS gender;
	VAR mt final;  
	TABLE gender all, mean*(mt final); 
	ODS OUTPUT TABLE mark_g; 
RUN; 

/*(ii)*/
ODS RTF FILE = 'C:\Users\keithliu\SAS File\Lesson 8\Lesson 8 Exercise\mark_word.rtf' BODYTITLE COLUMNS=2; 
ODS NOPROCTITLE; 
DATA mark_word; 
SET mark_g; 
PROC MEANS DATA = mark_word N MEAN CLM ALPHA=.1; 
	VAR final; 
	TITLE 'Part ii'; 
RUN;
ODS RTF CLOSE; 

/*(iii)*/
ODS PDF FILE = 'C:\Users\keithliu\SAS File\Lesson 8\Lesson 8 Exercise\mark_pdf.pdf' STARTPAGE = NO; 
ODS NOPROCTITLE; 
DATA mark_pdf; 
SET mark_g; 
PROC CORR DATA = mark_pdf; 
	VAR q1 q2 mt; 
	WITH final total; 
	Title 'part iii';
RUN; 
ODS PDF CLOSE; 

/*(iv)*/
ODS EXCEL FILE= 'C:\Users\keithliu\SAS File\Lesson 8\Lesson 8 Exercise\mark_excel.xlsx'
	options(start_at='2,2' frozen_headers='2'
	frozen_rowheaders='2' autofilter='1-6'
	sheet_name='mark_excel' row_repeat='2'
	embedded_titles='yes'); 
DATA mark_excel;
SET mark_g; 
PROC MEANS DATA = mark_excel MEAN MIN MAX; 
	CLASS grade; 
	VAR q1 q2 ca mt final total;
    Title 'part iv';   
RUN; 
PROC Print Data=mark_excel; 
RUN; 
ODS EXCEL CLOSE; 

/*(v)*/
Data mark_raw; 
set mark_g; 
FILE 'C:\Users\keithliu\SAS File\Lesson 8\Lesson 8 Exercise\mark_raw.txt' PRINT; 
TITLE;
PUT 'student id ' sid 'score ' final 'in final and receive grade ' grade; 
RUN; 




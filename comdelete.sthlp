{smcl}
{* *! version 1.2.1  8dec2016}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help comdelete"}{...}
{viewerjumpto "Syntax" "comdelete##syntax"}{...}
{viewerjumpto "Description" "comdelete##description"}{...}
{viewerjumpto "Options" "comdelete##options"}{...}
{viewerjumpto "Remarks" "comdelete##remarks"}{...}
{viewerjumpto "Examples" "comdelete##examples"}{...}
{title:Title}

{phang}
{bf:comdelete} {hline 2} Removes line and block comments from .do file


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:comdelete}
{it:input_folder}{cmd:,} {cmdab:s:aveto(}{it:folder_name}{cmd:)} 
[{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt s:aveto(folder_name)}}output folder {p_end}
{synopt:{opt f:iles(filenames)}}list of files to be processed; default is for all
        .do files in {it:input_folder} to be processed{p_end}
{synopt:{opt b:lock}}removes block comments {p_end}
{synopt:{opt l:ine}}removes comments created using "//" {p_end}		
{synoptline}
{p2colreset}{...}



{marker description}{...}
{title:Description}

{pstd}
{cmd:comdelete} creates replicated .do files for files located in 
			{it:input_folder} with comments removed. 


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt saveto(folder_name)} specifies that new .do files will be  saved in
				{it:folder_name}.

{phang}
{opt files(filenames)} restricts processing to specified files. These files must
			be located in {it:input_folder}. Input should follow the format 
			"file1.do file2.do file3.do ...".
			
{phang}
{opt block} removes all line comments. These are full and part line comments following
			"//"
				
{phang}
{opt line} removes all block comments. These are comments contained inside
			"/*" and "*/".


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:comdelete} creates a replicated .do file with comments removed. By default all comments created using a "*" are removed. Any text inside a block comment will not be deleted
unless {opt block} is given. So text following "*" inside a block comment will not be removed.
Similarly "//" comments inside a block will not be removed if {opt line} is given but {opt block} is not.

{pstd}
Note that if {opt block} is specified then all text on the line in which "/*" and "*/" are located will be deleted.
This means that any uncommented code placed before "/*" and after "*/" on the same line will be removed.
For example if a line reads "text here /*" beginning a block comment, then "text here" will also be removed.
Programming errors will also not be taken into account. For instance, if a line reads "*/ text" but is
not proceeded by "/*" beginning the block, this will be treated as a full line comment and will be deleted
as the first character in the line is "*".



{marker examples}{...}
{title:Examples}

{phang}{cmd:. comdelete C:\Users\dofiles, saveto(C:Users\newdofiles)}{p_end}

{phang}{cmd:. comdelete C:\Users\dofiles, s(C:Users\newdofiles) files(file1.do file2.do) }{p_end}

{phang}{cmd:. comdelete C:\Users\dofiles, s(C:Users\newdofiles) f(file1.do file2.do) b }{p_end}

{phang}{cmd:. comdelete C:\Users\dofiles, s(C:Users\newdofiles) f(file1.do file2.do) b l}{p_end}


{marker author}{...}
{title:Author}

{pstd}Iain Snoddy{p_end}
{pstd}iainsnoddy@gmail.com{p_end}

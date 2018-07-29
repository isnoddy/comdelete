*! version 2.0 	 13 December 2016	Author: Iain Snoddy, iainsnoddy@gmail.com

program define comdelete
	version 12
	syntax anything(name=location), [Saveto(string) Files(string) Block Line ]
							
								
	if "`saveto'"==""{
		di as error "The saveto() option must be provided "
		exit
	}
	if "`saveto'"=="`location'"{
		di as error "The folder given in saveto() cannot be the same"
		di as error "as the location of the original .do file(s)"
		exit
	}
	
	if "`files'"=="" local files: dir "`location'" files "*.do"
	
	foreach filename of local files{

		file open odofile using `location'\\`filename', r 
		file read odofile tline
		file open ndofile using `saveto'\\`filename', w replace 
		
		local blcom=0
		
		if "`block'"=="" & "`line'"==""{
			while r(eof)==0{
				if substr("`tline'",indexnot("`tline'"," "),2)=="/*" local blcom=1
				if `blcom'==0{
					local cond1 `"substr("`tline'",indexnot("`tline'"," "),1)!="*" "'
					local cond2 `"substr("`tline'",indexnot("`tline'"," "),1)=="*" "'			
					local cond3 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					if `cond1' | `cond2' & `cond3' file write ndofile "`tline'" _n
					file read odofile tline 
				}
				else{
					file write ndofile "`tline'" _n
					file read odofile tline
					local cond3 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					if `cond3' local blcom=0				
				}
			}	
		}
		else if "`block'"=="" & "`line'"!=""{
			while r(eof)==0{
				if substr("`tline'",indexnot("`tline'"," "),2)=="/*" local blcom=1
				if `blcom'==0{		
					local linepos=strpos("`tline'","//")
					local cont=strpos("`tline'","///")	
					local cond1 `"substr("`tline'",indexnot("`tline'"," "),1)!="*" "'
					local cond2 `"substr("`tline'",indexnot("`tline'"," "),1)=="*" "'
					local cond3 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					local cond4 `"`linepos'!=0 & `linepos'==`cont' "'
					local cond5 `"`linepos'!=0 & `linepos'!=`cont' "'	
					local cond6 `"`linepos'==0 "'							
					if `cond1' & `cond4' | `cond2' & `cond3' & `cond4' {
						local instr=substr("`tline'",1,`cont'+2)
						disp "`instr'"
						file write ndofile "`instr'" _n
					}
					else if `cond1' & `cond5' | `cond2' & `cond3' & `cond5' {
						local instr=substr("`tline'",1,`linepos'-1)
						file write ndofile "`instr'" _n
					}
					else if `cond1' & `cond6' | `cond2' & `cond3' & `cond6' file write ndofile "`tline'" _n
					file read odofile tline 		
				}		
				else{
					file write ndofile "`tline'" _n
					file read odofile tline
					local cond3 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					if `cond3' local blcom=0				
				}
			}
		}
		else if "`block'"!="" & "`line'"==""{
			while r(eof)==0{
				if substr("`tline'",indexnot("`tline'"," "),2)=="/*" local blcom=1
				if `blcom'==0{
					local cond1 `"substr("`tline'",indexnot("`tline'"," "),1)!="*" "'
					if `cond1'  file write ndofile "`tline'" _n
					file read odofile tline 
				}
				else{
					file read odofile tline
					local cond2 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					if `cond2' local blcom=0			
				}
			}
		}
		else{
			while r(eof)==0{				
				if substr("`tline'",indexnot("`tline'"," "),2)=="/*" local blcom=1
				if `blcom'==0{
					local linepos=strpos("`tline'","//")
					local cont=strpos("`tline'","///")	
					local cond1 `"substr("`tline'",indexnot("`tline'"," "),1)!="*" "'
					local cond2 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					local cond3 `"`linepos'!=0 & `linepos'==`cont' "'
					local cond4 `"`linepos'!=0 & `linepos'!=`cont' "'	
					local cond5 `"`linepos'==0 "'
					if `cond1' & `cond3' {
						local instr=substr("`tline'",1,`cont'+2)
						file write ndofile "`instr'" _n
					}					
					else if `cond1' & `cond4' {
						local instr=substr("`tline'",1,`linepos'-1)
						file write ndofile "`instr'" _n			
					}
					else if `cond1' & `cond5' file write ndofile "`tline'" _n
					
					file read odofile tline 
				}
				else{
					file read odofile tline
					local cond2 `"substr("`tline'",indexnot("`tline'"," "),2)=="*/" "'
					if `cond2' local blcom=0			
				}							
			}
		}

		file close odofile 
		file close ndofile
	}

end




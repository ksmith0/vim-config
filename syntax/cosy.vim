" Vim syntax file
" Language: COSY Infinity
" Author: Karl Smith <ksmith@nuclearemail.org>
" Revision Date: 2017 Sep 26

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "cosy"

syn case ignore

"Numbers
syn match integer '\<\d\+\>' nextgroup=num_error display "Integer
syn match float '\<\d\+\.\d*' nextgroup=num_error display "Floating point
syn match exp '\<\d\+\(\.\d*\)\=[eE][+-]\=\d\+\>' nextgroup=num_error display "Exponential

"Regions
syn region cosyComment start="{" end="}" keepend
syn region string start="'" end="'"

"Syntax checking
syn match num_error contained "\S\+\>"
syn match too_many_error contained "[^; ][^;]*"
syn match too_few_error contained "\S*;"
hi def link num_error Error
hi def link too_many_error Error
hi def link too_few_error Error

" Functions and Procedures
"syn region basicLanguageKeywords start="PROCEDURE" end="ENDPROCEDURE" fold transparent

" Keywords
syn keyword basicLanguageInclude INCLUDE
syn keyword basicTypedef VARIABLE
syn keyword basicLanguageKeywords PROCEDURE ENDPROCEDURE
syn keyword basicLanguageKeywords FUNCTION ENDFUNCTION
syn keyword basicLanguageKeywords END QUIT
syn keyword basicReapeat WHILE ENDWHILE
syn keyword basicReapeat LOOP ENDLOOP
syn keyword basicReapeat PLOOP ENDPLOOP
syn keyword basicConditionals IF ELSEIF ENDIF
syn keyword cosyReadWrite OPENF CLOSEF READ WRITE
syn keyword cosyReadWrite OPENFB CLOSEFB READB WRITEB
syn keyword cosyReadWrite RDREAB RDWRTB
syn keyword cosyFunction RUN
syn keyword cosySpecialWords FIT ENDFIT WSET

" Sets the order and dimension of the calculations
syn keyword order OV skipwhite nextgroup=three_val,too_few_error
syn keyword order CO skipwhite nextgroup=ove_val,too_few_error
"Beam Definition
syn keyword beam RP RPR RPM 	skipwhite nextgroup=three_val,too_few_error
syn keyword beam RPP RPE 	skipwhite nextgroup=one_val,too_few_error
syn keyword beam RPS 		skipwhite nextgroup=two_val,too_few_error
syn keyword beam SB 		skipwhite nextgroup=eleven_val,too_few_error
syn keyword beam SP 		skipwhite nextgroup=six_val,too_few_error
syn keyword beam SBE 		skipwhite nextgroup=three_val,too_few_error
syn keyword maps UM SM SNM AM ANM PM PSM WM RM WSM RSM ME SIGMA MR MT
syn keyword trajectories SR SSR ER SCDE ENVEL ENCL CR
syn keyword trajectories PRAY WRAY PR RRAY SRAY LRAY ARAY ADDRAYS
syn keyword trajectories PSPI WSPI RSPI SSPI LSPI ASPI ADDSPIS
syn keyword plotting PTY BP EP PP PG PGE PS

"Drift
syn keyword opticalElements DL skipwhite nextgroup=one_val,too_few_error
"Change Bending direction
syn keyword opticalElements CB skipwhite nextgroup=too_many_error
"Multipoles
syn keyword opticalElements MQ MH MO MD MZ EQ EH EO ED EZ skipwhite nextgroup=three_val,too_few_error
syn keyword opticalElements M5 E5 	skipwhite nextgroup=seven_val,too_few_error
syn keyword opticalElements MM EM 	skipwhite nextgroup=four_val,too_few_error
syn keyword opticalELements MMS EMS 	skipwhite nextgroup=five_val,too_few_error
"Bending Elements
syn keyword opticalElements MS ES 	skipwhite nextgroup=eight_val,too_few_error
"Special electrostatic deflectors
syn keyword opticalElements EC 		skipwhite nextgroup=five_val,too_few_error
syn keyword opticalElements ECL ESP 	skipwhite nextgroup=three_val,too_few_error
"Dipoles
syn keyword opticalElements DI MC 	skipwhite nextgroup=seven_val,too_few_error
syn keyword opticalElements MSS 	skipwhite nextgroup=eight_val,too_few_error
syn keyword opticalElements DP 		skipwhite nextgroup=three_val,too_few_error
"Wien Filters
syn keyword opticalElements WF 		skipwhite nextgroup=four_val,too_few_error
syn keyword opticalElements WC 		skipwhite nextgroup=seven_val,too_few_error
"Wigglers
syn keyword opticalElements WI 		skipwhite nextgroup=seven_val,too_few_error
"Cavities
syn keyword opticalElements RF 		skipwhite nextgroup=five_val,too_few_error
"Cylindrical Electromagnetic Lenses
syn keyword opticalElements CMR CML CMG CEG 	skipwhite nextgroup=two_val,too_few_error
syn keyword opticalElements CMSI CMST CEL CEA 	skipwhite nextgroup=four_val,too_few_error
syn keyword opticalElements CMS 		skipwhite nextgroup=three_val,too_few_error
"Fringe Fields
syn keyword opticalElements FR 		skipwhite nextgroup=one_val,too_few_error
syn keyword opticalElements FC 		skipwhite nextgroup=nine_val,too_few_error
syn keyword opticalElements FP 		skipwhite nextgroup=six_val,too_few_error
syn keyword opticalElements FD FD2 	skipwhite nextgroup=too_few_error
syn keyword opticalElements FC2 	skipwhite nextgroup=three_val,too_few_error
"General Particle Optical Elements
syn keyword opticalElements GE 		skipwhite nextgroup=six_val,too_few_error
syn keyword opticalElements MF		skipwhite nextgroup=eleven_val,too_few_error
syn keyword opticalElements MGE		skipwhite nextgroup=six_val,too_few_error
"Absorber Wedges
syn keyword opticalElements WAS 	skipwhite nextgroup=one_val,too_few_error
syn keyword opticalElements BBC		skipwhite nextgroup=six_val,too_few_error
syn keyword opticalElements WA EL WL	skipwhite nextgroup=five_val,too_few_error
"Glass Lenses and Mirrors
syn keyword opticalElements GLS GP 	skipwhite nextgroup=five_val,too_few_error
syn keyword opticalElements GL 		skipwhite nextgroup=seven_val,too_few_error
syn keyword opticalElements GMS GMP GMF skipwhite nextgroup=two_val,too_few_error
syn keyword opticalElements GM		skipwhite nextgroup=three_val,too_few_error
"Misalignments
syn keyword opticalElements SA TA 	skipwhite nextgroup=two_val,too_few_error
syn keyword opticalElements RA	 	skipwhite nextgroup=one_val,too_few_error

"Check for the correct number of arguments recursively
syn match one_val	contained '[^; ]\+\s*'hs=e+1 contains=float,integer,exp nextgroup=too_many_error
syn match two_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=one_val,too_few_error
syn match three_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=two_val,too_few_error
syn match four_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=three_val,too_few_error
syn match five_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=four_val,too_few_error
syn match six_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=five_val,too_few_error
syn match seven_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=six_val,too_few_error
syn match eight_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=seven_val,too_few_error
syn match nine_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=eight_val,too_few_error
syn match ten_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=nine_val,too_few_error
syn match eleven_val	contained '[^; ]\+\s*' contains=float,integer,exp nextgroup=ten_val,too_few_error

"Highlighting
hi def link string String
hi def link integer Number
hi def link float Float
hi def link exp Float

hi def link basicLanguageKeywords Keyword
hi def link basicLanguageInclude Include
hi def link basicConditionals Conditional
hi def link basicReapeat Repeat
hi def link basicTypedef Typedef

hi def link cosyReadWrite Keyword
hi def link cosyComment Comment
hi def link cosySpecialWords Keyword
hi def link cosyFunction Function

hi def link drift Function
hi def link opticalElements Function
hi def link order Function
hi def link trajectories Function
hi def link beam Function
hi def link maps Function
hi def link plotting Function

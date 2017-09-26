" Vim syntax file
" Language: COSY Infinity
" Author: Karl Smith <ksmith@nuclearemail.org>
" Revision Date: 2017 Sep 26

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "cosy"

syn case ignore

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

syn keyword opticalElements DL CB MS ES DI
syn keyword opticalElements MQ MH MO MD MZ M5 MM MMS
syn keyword opticalElements EQ EH EO ED EZ E5 EM EMS
syn keyword opticalElements EC ECL ESP
syn keyword opticalElements DI DP MC
syn keyword opticalElements WF WC
syn keyword opticalElements WI RF
syn keyword opticalElements CMR CML CMSI CMS CMST CMG CEL CEA CEG
syn keyword opticalElements FR FC FP FD FC2 FD2
syn keyword opticalElements GE MF MGE
syn keyword opticalElements WAS WA EL WL
syn keyword opticalElements GLS GL GP GMS GMP GMF GM
syn keyword opticalElements SA TA RA

" Sets the order and dimension of the calculations
syn keyword order OV CO
syn keyword beam RP RPP RPE RPR RPM RPS
syn keyword beam SB SP SBE
syn keyword maps UM SM SNM AM ANM PM PSM WM RM WSM RSM ME SIGMA MR MT
syn keyword trajectories SR SSR ER SCDE ENVEL ENCL CR
syn keyword trajectories PRAY WRAY PR RRAY SRAY LRAY ARAY ADDRAYS
syn keyword trajectories PSPI WSPI RSPI SSPI LSPI ASPI ADDSPIS
syn keyword plotting PTY BP EP PP PG PGE PS

" Functions and Prodecures
"syn region basicLanguageKeywords start="PROCEDURE" end="ENDPROCEDURE" fold transparent

" Matches
"syn match varName excludenl "\w\+"
syn match integer '\<\d\+\>' display "Integer
syn match float '\<\d\+\.\d*\>' display "Floating point
syn match float '\<\d\+\(\.\d*\)\=[eE][+-]\=\d\+\>' display "Exponential

" Regions
syn region cosyComment start="{" end="}"
syn region string start="'" end="'"

hi def link string String
"hi def link varName Identifier
hi def link integer Number
hi def link float Float

hi def link basicLanguageKeywords Keyword
hi def link basicLanguageInclude Include
hi def link basicConditionals Conditional
hi def link basicReapeat Repeat
hi def link basicTypedef Typedef

hi def link cosyReadWrite Keyword
hi def link cosyComment Comment
hi def link cosySpecialWords Keyword
hi def link cosyFunction Function

hi def link opticalElements Function
hi def link order Function
hi def link trajectories Function
hi def link beam Function
hi def link maps Function
hi def link plotting Function

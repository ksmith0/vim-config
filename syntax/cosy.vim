" Vim syntax file
" Language: COSY Infinity
" Maintainer: karl Smith <ksmith37@nd.edu>
" Last Change: 2013 Sep 30

if exists("b:current_syntax")
	finish
endif

syn case ignore 

" Keywords 
syn keyword basicTypedef VARIABLE 
syn keyword basicLanguageKeywords PROCEDURE ENDPROCEDURE
syn keyword basicLanguageKeywords FUNCTION ENDFUNCTION
syn keyword basicReapeat LOOP ENDLOOP 
syn keyword basicReapeat WHILE ENDWHILE 
syn keyword basicConditionals IF ELSEIF ENDIF
syn keyword cosyReadWrite OPENF CLOSEF READ WRITE
syn keyword cosyReadWrite OPENFB CLOSEFB READB WRITEB
syn keyword cosyReadWrite RDREAB RDWRTB 
syn keyword basicLanguageKeywords INCLUDE
syn keyword basicLanguageKeywords END QUIT

syn keyword cosyOpticalElements DL CB FR WF MQ MH WM UM
syn keyword cosySpecialWords FIT ENDFIT WSET OV

" Functions and Prodecures
"syn region basicLanguageKeywords start="PROCEDURE" end="ENDPROCEDURE" fold transparent

" Matches
"syn match varName excludenl "\w\+"
"syn match number display "\d\+" 
"syn match number "[+-]\d\+" 
"syn match number "\d\+\.?\d*" 
"syn match number "[+-]\d\+\.?\d*" 

" Regions
syn region cosyComment start="{" end="}" fold 
syn region string start="'" end="'"

hi def link string String
hi def link number Number
hi def link varName Identifier
hi def link basicLanguageKeywords Keyword
hi def link cosyReadWrite Keyword
hi def link basicConditionals Conditional
hi def link basicReapeat Repeat
hi def link basicTypedef Typedef
hi def link cosyComment Comment
hi def link cosyOpticalElements Keyword
hi def link cosySpecialWords Keyword

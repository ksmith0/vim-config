" Vim syntax file
" Language:     Condor Job Description
" Maintainer:   Haakon Riiser <hakonrk@fys.uio.no>
" Last Change:  2004 May 22

if exists("b:current_syntax")
    finish
endif

sy case match

" Special case sensitive string constants for ClassAd attribute values.
sy keyword condorAttrVals   contained Idle Busy Suspended Vacating Killing
sy keyword condorAttrVals   contained Benchmarking INTEL ALPHA SGI SUN4u SUN4x
sy keyword condorAttrVals   contained HPPA1 HPPA2 HPUX10 IRIX6 IRIX65 LINUX
sy keyword condorAttrVals   contained OSF1 SOLARIS251 SOLARIS26 SOLARIS27
sy keyword condorAttrVals   contained SOLARIS28 WINNT40 Owner Unclaimed
sy keyword condorAttrVals   contained Matched Claimed Preempting

sy case ignore

" All valid attributes.
sy keyword condorAttributes contained activity arch clockday clockmin
sy keyword condorAttributes contained condorloadavg consoleidle cpus
sy keyword condorAttributes contained currentrank disk enteredcurrentactivity
sy keyword condorAttributes contained filesystemdomain keyboardidle kflops
sy keyword condorAttributes contained lastheardfrom loadavg machine memory
sy keyword condorAttributes contained mips mytype name opsys requirements
sy keyword condorAttributes contained startdipaddr state targettype uiddomain
sy keyword condorAttributes contained virtualmemory clientmachine currentrank
sy keyword condorAttributes contained remoteowner remoteuser jobid jobstart
sy keyword condorAttributes contained lastperiodiccheckpoint ckptarch
sy keyword condorAttributes contained ckptopsys clusterid executablesize
sy keyword condorAttributes contained imagesize jobprio jobstatus
sy keyword condorAttributes contained jobuniverse lastckptserver lastckpttime
sy keyword condorAttributes contained lastvacatetime numckpts numrestarts
sy keyword condorAttributes contained niceuser owner procid qdate jobstartdate

" All non-whitespace should be highlighted.  If it's not, it must be a syntax
" error!
sy match   condorError              display "\S"

" Any non recognized "NAME = VALUE" string is a macro definition.
sy match   condorMacroDef           "^\s*\zs\<\w\+\ze\s*=" skipwhite nextgroup=condorPlainArg

" Use these when we don't want to highlight blanks.
sy match   condorBlank              contained display "\s"
sy match   condorLeadBlanks         contained display "^\s\+"

" These characters are delimiters in "A=B; C=D; ... " expressions.
sy match   condorSemicolon          contained display ";"
sy match   condorEqual              contained display "="

" Dollar characters not used in the "$(foo)" syntax are errors.
sy match   condorDollar             contained display "\$"

" Lines starting with "#" are comments.
sy match   condorComment            "^\s*\zs#.*$"

" Numbers used in ClassAd expressions.
sy match   condorNumber             contained display "\<\d\+\>"

" Boolean ops used in ClassAd expressions (both "Requirements" and "Rank").
sy match   condorBoolOps            contained display "==\|<=\|>=\|<\|>\|&&\|||"

" Boolean ops used in "Rank" ClassAd expressions.
sy match   condorFloatOps           contained display "\*\|/\|+\|-"

" Match boolean expressions: "KEYWORD = <True | False>".
sy match   condorBool               "^\s*\zs\<\(copy_to_spool\|getenv\|hold\|nice_user\)\>" skipwhite nextgroup=condorBoolAssign
sy match   condorBoolAssign         contained "=" skipwhite nextgroup=condorBoolArg
sy match   condorBoolArg            contained display "\<\(true\|false\)\>\ze\s*$"

" Strings used in ClassAd expressions.
sy match   condorString             contained display +".\{-}"+
sy match   condorString             contained display +"\w\+"+ contains=condorAttrVals

" Match the "Queue [NUMBER]" command.
sy match   condorQueue              "^\s*\zs\<queue\>" skipwhite nextgroup=condorQueueArg
sy match   condorQueueArg           contained display ".*$" contains=condorError,condorNumber

" Match the "Image_Size = SIZE [Meg]" expression.
sy match   condorImgSize            "^\s*\zs\<image_size\>" skipwhite nextgroup=condorImgSizeAssign
sy match   condorImgSizeAssign      contained "=" skipwhite nextgroup=condorImgSizeArg
sy match   condorImgSizeArg         contained "\d\+\s*\(Meg\s*\)\=$" contains=condorBlank

" Match the "Universe = UNIVERSE" command.
sy match   condorUniverse           "^\s*\zs\<universe\>" skipwhite nextgroup=condorUniverseAssign
sy match   condorUniverseAssign     contained "=" skipwhite nextgroup=condorUniverseArg
sy keyword condorUniverseArg        contained vanilla standard pvm scheduler globus mpi

" Match the "Machine_Count = MIN..MAX | MAX" command.
sy match   condorMachineCnt         "^\s*\zs\<machine_count\>" skipwhite nextgroup=condorMachineCntAssign
sy match   condorMachineCntAssign   contained "=" skipwhite nextgroup=condorMachineCntArg
sy match   condorMachineCntArg      contained display "\d\+\.\.\d\+\|\d\+"

" Match "KEYWORD = NUMBER" expressions.
sy match   condorNumExpr            "^\s*\zs\<\(coresize\|buffer_size\|buffer_block_size\)\>" skipwhite nextgroup=condorNumExprAssign
sy match   condorNumExprAssign      contained "=" skipwhite nextgroup=condorNumber

" Expressions where anything goes.  The arguments are usually just paths.
sy match   condorPlain              "^\s*\zs\<\(input\|output\|initialdir\|error\|notify_user\|log\|rendezvousdir\|x509directory\|x509userproxy\|globusscheduler\|globusrsl\)\>" skipwhite nextgroup=condorPlainArg
sy region  condorPlainArg           contained start="=" end="$" contains=condorMacro,condorDollar,condorLineCont

" Like "condorPlain", but also contains "condorSubstMacro".
sy match   condorExeArg             "^\s*\zs\<\(executable\|arguments\)\>" skipwhite nextgroup=condorExeArgArg
sy region  condorExeArgArg          contained start="=" end="$" contains=condorMacro,condorSubstMacro,condorDollar,condorLineCont

" Use this to override "condorError" highlighting for parens.
sy match   condorParenChars         contained display "[()]"

" Skip backslash escaped newlines.
sy match   condorLineCont           contained "\\$"

" Match the boolean ClassAd "Requirements" expression.
sy match   condorRequirements       "^\s*\zs\<requirements\>" skipwhite nextgroup=condorRequirementsAssign
sy match   condorRequirementsAssign contained "=" nextgroup=condorRequirementsArg
sy region  condorRequirementsArg    contained start="" skip="\\$" end="$" contains=@condorReqExprMembers
sy region  condorRequirementsParen  contained start="(" end=")" skip="\\$" end="$" keepend extend contains=@condorReqExprMembers,condorParenChars
sy cluster condorReqExprMembers     contains=condorAttributes,condorRequirementsParen,condorBoolOps,condorMacro,condorError,condorString,condorNumber,condorLineCont

" Match the floating point ClassAd "Rank" expression.
sy match   condorRank               "^\s*\zs\<rank\>" skipwhite nextgroup=condorRankAssign
sy match   condorRankAssign         contained "=" nextgroup=condorRankArg
sy region  condorRankArg            contained start="" skip="\\$" end="$" contains=@condorRankExprMembers
sy region  condorRankParen          contained start="(" end=")" skip="\\$" end="$" keepend extend contains=@condorRankExprMembers,condorParenChars
sy cluster condorRankExprMembers    contains=condorAttributes,condorRequirementsParen,condorBoolOps,condorFloatOps,condorMacro,condorError,condorString,condorNumber,condorLineCont

" Standard variables (environent, user defined and internal).
sy match   condorMacro              contained "$(\w\+)" extend

" Substitution Macro.  Only valid in "Executable", "Environment", and
" "Arguments" expressions.
sy match   condorSubstMacro         contained "$$(\<\(activity\|arch\|clockday\|clockmin\|condorloadavg\|consoleidle\|cpus\|currentrank\|disk\|enteredcurrentactivity\|filesystemdomain\|keyboardidle\|kflops\|lastheardfrom\|loadavg\|machine\|memory\|mips\|mytype\|name\|opsys\|requirements\|startdipaddr\|state\|targettype\|uiddomain\|virtualmemory\|clientmachine\|currentrank\|remoteowner\|remoteuser\|jobid\|jobstart\|lastperiodiccheckpoint\|ckptarch\|ckptopsys\|clusterid\|executablesize\|imagesize\|jobprio\|jobstatus\|jobuniverse\|lastckptserver\|lastckpttime\|lastvacatetime\|numckpts\|numrestarts\|niceuser\|owner\|procid\|qdate\|jobstartdate\)\>)" contains=condorAttributes

" Match the "+ATTRIBUTE = VALUE" expression.
sy match   condorAttribSet          "^\s*\zs+\(activity\|arch\|clockday\|clockmin\|condorloadavg\|consoleidle\|cpus\|currentrank\|disk\|enteredcurrentactivity\|filesystemdomain\|keyboardidle\|kflops\|lastheardfrom\|loadavg\|machine\|memory\|mips\|mytype\|name\|opsys\|requirements\|startdipaddr\|state\|targettype\|uiddomain\|virtualmemory\|clientmachine\|currentrank\|remoteowner\|remoteuser\|jobid\|jobstart\|lastperiodiccheckpoint\|ckptarch\|ckptopsys\|clusterid\|executablesize\|imagesize\|jobprio\|jobstatus\|jobuniverse\|lastckptserver\|lastckpttime\|lastvacatetime\|numckpts\|numrestarts\|niceuser\|owner\|procid\|qdate\|jobstartdate\)\>" contains=condorAttributes skipwhite nextgroup=condorAttribSetAssign
sy match   condorAttribSetAssign    contained "=.*$" contains=condorNumber,condorString,condorMacro,condorDollar,condorBoolArg

" Match the "Priority = [-20 .. +20]" expression.
sy match   condorPriority           "^\s*\zs\<priority\>" skipwhite nextgroup=condorPriorityAssign
sy match   condorPriorityAssign     contained "=" skipwhite nextgroup=condorPriorityArg
sy match   condorPriorityArg        contained display "[+-]\=0*\(1\=[0-9]\|20\)\>"

" Match the "Notification = WHEN" expression.
sy match   condorNotification       "^\s*\zs\<notification\>" skipwhite nextgroup=condorNotificationAssign
sy match   condorNotificationAssign contained "=" skipwhite nextgroup=condorNotificationArg
sy keyword condorNotificationArg    contained always complete error never

" Match the "Kill_Sig = SIGSPEC" expression.
sy match   condorKillSig            "^\s*\zs\<kill_sig\>" skipwhite nextgroup=condorKillSigAssign
sy match   condorKillSigAssign      contained "=" skipwhite nextgroup=condorKillSigArg
sy match   condorKillSigArg         contained display "\d\+\|\(SIGHUP\|SIGINT\|SIGQUIT\|SIGILL\|SIGTRAP\|SIGABRT\|SIGIOT\|SIGBUS\|SIGFPE\|SIGKILL\|SIGUSR1\|SIGSEGV\|SIGUSR2\|SIGPIPE\|SIGALRM\|SIGTERM\|SIGSTKFLT\|SIGCHLD\|SIGCONT\|SIGSTOP\|SIGTSTP\|SIGTTIN\|SIGTTOU\|SIGURG\|SIGXCPU\|SIGXFSZ\|SIGVTALRM\|SIGPROF\|SIGWINCH\|SIGIO\|SIGPOLL\|SIGLOST\|SIGPWR\|SIGSYS\|SIGUNUSED\)\>"

" Match the "Environment = name1=value1; name2=value2; ..." expression.
sy match   condorEnv                "^\s*\zs\<environment\>" skipwhite nextgroup=condorEnvAssign
sy match   condorEnvAssign          contained "=" skipwhite nextgroup=condorEnvArg
sy region  condorEnvArg             contained start="" end="$" contains=condorEnvName
sy region  condorEnvName            contained excludenl start="" end=";" end="$" contains=condorEnvValue,condorLeadBlanks,condorLineCont
sy region  condorEnvValue           contained excludenl matchgroup=Operator start="=" matchgroup=Operator end=";" end="$" contains=condorLeadBlanks,condorLineCont

" Match the "File_Remaps = REMAP-STRING" expression.
sy match   condorFileRemaps         "^\s*\zs\<file_remaps\>" skipwhite nextgroup=condorFileRemapsAssign
sy match   condorFileRemapsAssign   contained "=" skipwhite nextgroup=condorFileRemapsArg
sy region  condorFileRemapsArg      contained start=+"+ end=+"+ end="$" contains=condorSemicolon,condorEqual,condorEscaped,condorLineCont,condorAccessSpec,condorLeadBlanks
sy match   condorAccessSpec         contained "\<\(local\|remote\)\>:"
sy match   condorEscaped            contained "\\."

" Match the "Should_Transfer_Files = YES / NO / IF_NEEDED" expression.
sy match   condorSTF                "^\s*\zs\<should_transfer_files\>" skipwhite nextgroup=condorSTFAssign
sy match   condorSTFAssign          contained "=" skipwhite nextgroup=condorSTFValue
sy keyword condorSTFValue           contained yes no if_needed

" Match the "When_To_Transfer_Output = ON_EXIT / ON_EXIT_OR_EVICT" expression.
sy match   condorWTTO               "^\s*\zs\<when_to_transfer_output\>" skipwhite nextgroup=condorWTTOAssign
sy match   condorWTTOAssign         contained "=" skipwhite nextgroup=condorWTTOValue
sy keyword condorWTTOValue          contained on_exit on_exit_or_evict

" Match the "Transfer_Input_Files = file1,file2,..." expression.
sy match   condorTIF                "^\s*\zs\<transfer_input_files\>" skipwhite nextgroup=condorTIFAssign
sy match   condorTIFAssign          contained "=" skipwhite nextgroup=condorTIFValue
sy match   condorTIFValue           contained ".*"

hi def link condorAccessSpec          Comment
hi def link condorAttribSet           Operator
hi def link condorAttribSetAssign     NONE
hi def link condorAttributes          Identifier
hi def link condorAttrVals            Identifier
hi def link condorBlank               NONE
hi def link condorBool                Keyword
hi def link condorBoolArg             Boolean
hi def link condorBoolAssign          NONE
hi def link condorBoolOps             Operator
hi def link condorComment             Comment
hi def link condorDollar              Error
hi def link condorEnv                 Keyword
hi def link condorEnvArg              NONE
hi def link condorEnvAssign           NONE
hi def link condorEnvName             Identifier
hi def link condorEnvValue            Constant
hi def link condorEqual               Operator
hi def link condorError               Error
hi def link condorEscaped             SpecialChar
hi def link condorExeArg              Keyword
hi def link condorExeArgArg           NONE
hi def link condorFileRemaps          Keyword
hi def link condorFileRemapsArg       String
hi def link condorFileRemapsAssign    NONE
hi def link condorFloatOps            Operator
hi def link condorImgSize             Keyword
hi def link condorImgSizeArg          Number
hi def link condorImgSizeAssign       NONE
hi def link condorKillSig             Keyword
hi def link condorKillSigArg          Constant
hi def link condorKillSigAssign       NONE
hi def link condorMachineCnt          Keyword
hi def link condorMachineCntArg       Constant
hi def link condorMachineCntAssign    NONE
hi def link condorMacro               Macro
hi def link condorMacroDef            Macro
hi def link condorNotification        Keyword
hi def link condorNotificationArg     Constant
hi def link condorNotificationAssign  NONE
hi def link condorNumber              Number
hi def link condorNumExpr             Keyword
hi def link condorNumExprAssign       NONE
hi def link condorParenChars          NONE
hi def link condorPlain               Keyword
hi def link condorPlainArg            NONE
hi def link condorPriority            Keyword
hi def link condorPriorityArg         Number
hi def link condorPriorityAssign      NONE
hi def link condorQueue               Keyword
hi def link condorQueueArg            NONE
hi def link condorRank                Keyword
hi def link condorRankArg             NONE
hi def link condorRankAssign          NONE
hi def link condorRankParen           NONE
hi def link condorRequirements        Keyword
hi def link condorRequirementsArg     NONE
hi def link condorRequirementsAssign  NONE
hi def link condorRequirementsParen   NONE
hi def link condorSemicolon           Operator
hi def link condorString              String
hi def link condorSubstMacro          Macro
hi def link condorUniverse            Keyword
hi def link condorUniverseArg         Constant
hi def link condorUniverseAssign      NONE
hi def link condorSTF                 Keyword
hi def link condorSTFAssign           NONE
hi def link condorSTFValue            Constant
hi def link condorWTTO                Keyword
hi def link condorWTTOAssign          NONE
hi def link condorWTTOValue           Constant
hi def link condorTIF                 Keyword
hi def link condorTIFAssign           NONE
hi def link condorTIFValue            NONE

let b:current_syntax = "condor"

" vim: ts=8

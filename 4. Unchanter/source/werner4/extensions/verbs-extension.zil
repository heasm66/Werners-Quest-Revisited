;"-----------------------------------------------------------------------------
; ZILF Library and extensions
;
; <SET REDEFINE T> - Replaces definitions of routines, constants 
;                    and variables.
;                    This must appear AFTER original definition. 
; -----------------------------------------------------------------------------"

;"REDEFINE = TRUE"
<SET REDEFINE T>

;"-----------------------------------------------------------------------------
; ZILF Library and extensions - verbs.zil
; -----------------------------------------------------------------------------"

<CONSTANT CANT-GO-THAT-WAY ,SYSMESSAGE-007>                 ;"Changed line"

<ROUTINE V-QUIT ()
    <TELL CR ,SYSMESSAGE-012>                               ;"Changed line"
    <COND (<YES?>
        <JIGS-UP "">)                                       ;"Changed line"
        (ELSE
        <TELL CR "OK - not quitting." CR>)>>

<ROUTINE V-INVENTORY ()
    ;"check for light first"
    <COND (,HERE-LIT
           <COND (<FIRST? ,WINNER>
                  <TELL "You are carrying:" CR>
                  <MAP-CONTENTS (I ,WINNER)
                      <TELL "   " A .I>
                      <AND <FSET? .I ,WORNBIT> <TELL " " ,SYSMESSAGE-010>>          ;"Changed Line"
                      <AND <FSET? .I ,LIGHTBIT> <TELL " (providing light)">>
                      <COND (<FSET? .I ,CONTBIT>
                             <COND (<FSET? .I ,OPENABLEBIT>
                                    <COND (<FSET? .I ,OPENBIT> <TELL " (open)">)
                                          (ELSE <TELL " (closed)">)>)>
                             <COND (<SEE-INSIDE? .I> <INV-DESCRIBE-CONTENTS .I>)>)>
                      <CRLF>>)
                 (ELSE
                  <TELL ,SYSMESSAGE-011 CR>)>)              ;"Changed Line"
          (ELSE
           <TELL "It's too dark to see what you're carrying." CR>)>>

<ROUTINE V-RESTART ()
    <TELL CR "Are you sure you want to restart?">           ;"Changed line"
    <COND (<YES?>
           <RESTART>)
          (ELSE
           <TELL "Restart aborted." CR>)>>

;"-----------------------------------------------------------------------------
; ZILF Library and extensions - New syntax (Game specific)
; -----------------------------------------------------------------------------"

;"Syntax: BUY -----------------------------------------------------------------"
<SYNTAX BUY OBJECT = V-BUY>

<ROUTINE V-BUY ()
    <COND (<NOT <HELD? ,08-COIN>>
        <TELL ,MESSAGE-096 CR>
        <RTRUE>)   
    >
	<TELL ,SYSMESSAGE-008 CR CR>
>

;"Syntax: PUT (extension)------------------------------------------------------"
<SYNTAX PUT OBJECT IN OBJECT (FIND CONTBIT) (IN-ROOM) = V-INSERT>
<SYNTAX INSERT OBJECT IN OBJECT (FIND CONTBIT) (IN-ROOM) = V-INSERT>

<ROUTINE V-INSERT () <TELL ,SYSMESSAGE-008 CR>>

<SYNTAX PUT OBJECT (MANY TAKE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (IN-ROOM) = V-PUT-ON PRE-PUT-ON>
<VERB-SYNONYM PUT PLACE>

<SYNTAX HANG OBJECT (MANY TAKE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (IN-ROOM) = V-PUT-ON PRE-PUT-ON>

<SYNTAX COVER OBJECT (FIND SURFACEBIT) (IN-ROOM) WITH OBJECT (MANY TAKE HELD CARRIED) = V-SPUT-ON>

<ROUTINE V-SPUT-ON ()
    <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
    <RTRUE>>

;"Syntax: THROW (extension)----------------------------------------------------"
<SYNTAX THROW OBJECT (TAKE HAVE HELD CARRIED) = V-THROW>

<ROUTINE V-THROW () <V-DROP>>

;"Syntax: PUSH (synonyms)------------------------------------------------------"
<VERB-SYNONYM PUSH PRESS USE RING>

;"Syntax: UNWEAR (synonyms)----------------------------------------------------"
<VERB-SYNONYM UNWEAR REMOVE>

;"Syntax: SWIM (synonyms)------------------------------------------------------"
<VERB-SYNONYM SWIM BATH>

;"Syntax: RESTORE (synonyms)---------------------------------------------------"
<VERB-SYNONYM RESTORE LOAD>

;"Syntax: QUIT (synonyms)------------------------------------------------------"
<VERB-SYNONYM QUIT STOP>

;"Syntax: CLIMB (synonyms)-----------------------------------------------------"
<VERB-SYNONYM CLIMB ASCEND>

;"Syntax: DESCEND -------------------------------------------------------------"
<SYNTAX DESCEND = V-DESCEND>

<SYNTAX DESCEND OBJECT = V-DESCEND>
<ROUTINE V-DESCEND ()
     <COND (<PRSO? <>>
        <DO-WALK P?DOWN>
        <RTRUE>)
    (T
	    <TELL ,SYSMESSAGE-007>)
    >
>

;"Syntax: GIVE (new definition and synonyms)-----------------------------------"
<SYNTAX GIVE OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND PERSONBIT) (IN-ROOM)= V-GIVE>       ;"Overrides default definition"
<SYNTAX GIVE OBJECT (FIND PERSONBIT) (IN-ROOM) OBJECT (HAVE HELD CARRIED) = V-SGIVE>        ;"Overrides default definition"

;"Syntax: SHOW ----------------------------------------------------------------"
<SYNTAX SHOW OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND PERSONBIT) (IN-ROOM)= V-SHOW>
<SYNTAX SHOW OBJECT (FIND PERSONBIT) (IN-ROOM) OBJECT (HAVE HELD CARRIED) = V-SSHOW>

<ROUTINE V-SHOW ()
    <TELL "You are plainly ignored." CR>>

<ROUTINE V-SSHOW ()
    <PERFORM ,V?SHOW ,PRSI ,PRSO>
    <RTRUE>>

;"Syntax: ENTER ---------------------------------------------------------------"
<SYNTAX ENTER = V-GO-IN>

<ROUTINE V-GO-IN () <DO-WALK ,P?IN>>

;"Syntax: SAY -----------------------------------------------------------------"
<SYNTAX SAY OBJECT TO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-SAY>
<VERB-SYNONYM SAY ANSWER>

<ROUTINE V-SAY () 
    <COND (<AND <=? ,PRSO ,HELLO> <FSET? ,PRSI ,PERSONBIT>>
        <SETG ,WINNER ,PRSI>
        <PERFORM V?HELLO ,PRSI>
        <RTRUE>
    )>
    <TELL "Talking to yourself, huh?" CR>
>

<OBJECT HELLO
	(IN GLOBAL-OBJECTS)
	(SYNONYM HELLO HI)
	(DESC "hello")
    (FLAGS NDESCBIT NARTICLEBIT)>

;"Syntax: TIE -----------------------------------------------------------------"
<SYNTAX TIE OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND TIEABLEBIT) (IN-ROOM)= V-TIE>

<ROUTINE V-TIE () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: UNTIE ---------------------------------------------------------------"
<SYNTAX UNTIE OBJECT = V-UNTIE>
<VERB-SYNONYM UNTIE RELEASE>

<ROUTINE V-UNTIE () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: DIG -----------------------------------------------------------------"
<SYNTAX DIG  = V-DIG>

<ROUTINE V-DIG () <TELL "You lack the proper tools." CR>>

;"Syntax: SLEEP ---------------------------------------------------------------"
<SYNTAX SLEEP  = V-SLEEP>

<ROUTINE V-SLEEP () <TELL "You aren't feeling especially sleepy." CR>>

;"Syntax: LOOK UP -------------------------------------------------------------"
<SYNTAX LOOK UP OBJECT (FIND KLUDGEBIT) = V-LOOK-UP>

<ROUTINE V-LOOK-UP () <TELL "You see nothing special." CR>>

;"Syntax: TOUCH ---------------------------------------------------------------"
<SYNTAX TOUCH OBJECT = V-TOUCH>
<SYNTAX TOUCH OBJECT (HAVE HELD CARRIED) WITH OBJECT (HAVE HELD CARRIED)= V-TOUCH-WITH>
<VERB-SYNONYM TOUCH FEEL>

<ROUTINE V-TOUCH () <TELL "You feel nothing special." CR>>
<ROUTINE V-TOUCH-WITH () <TELL "Nothing special happens." CR>>

;"Syntax: CONNECT -------------------------------------------------------------"
<SYNTAX CONNECT OBJECT (HAVE HELD CARRIED)= V-CONNECT>
<SYNTAX CONNECT OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND TOOLBIT) (ON-GROUND)= V-CONNECT>
<VERB-SYNONYM CONNECT START>

<ROUTINE V-CONNECT () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: ATTACK (overrides action) -------------------------------------------"
<ROUTINE V-ATTACK ()
    <TELL ,MESSAGE-118 CR>
    <RTRUE>
>

;"Syntax: KISS ----------------------------------------------------------------"
<SYNTAX KISS OBJECT = V-KISS>

<ROUTINE V-KISS () <TELL "Keep your mind on the game." CR>>

;"Syntax: HELLO ---------------------------------------------------------------"
<SYNTAX HELLO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-HELLO>

<VERB-SYNONYM HELLO HI GREET>

<ROUTINE V-HELLO () <TELL "You are plainly ignored." CR>>

;"Syntax: REPLACE -------------------------------------------------------------"
<SYNTAX REPLACE OBJECT WITH OBJECT (FIND EXTRABIT) (HAVE HELD CARRIED) = V-REPLACE>

<ROUTINE V-REPLACE () <TELL ,SYSMESSAGE-008 CR>>

<VERB-SYNONYM REPLACE CHANGE SWAP>

;"Syntax: PUMP ----------------------------------------------------------------"
<SYNTAX PUMP OBJECT = V-PUMP>

<ROUTINE V-PUMP () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: CAST ----------------------------------------------------------------"
<SYNTAX CAST OBJECT (FIND SPELLBIT) (HAVE HELD CARRIED) ON OBJECT = V-CAST>

<ROUTINE V-CAST () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: LEARN ---------------------------------------------------------------"
<SYNTAX LEARN OBJECT (FIND SPELLBIT) (HAVE HELD CARRIED) = V-LEARN>
<VERB-SYNONYM LEARN MEMORIZE>

<ROUTINE V-LEARN () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: SPELLS --------------------------------------------------------------"
<SYNTAX BRENWYN OBJECT (HELD CARRIED ON-GROUND IN-ROOM)= V-BRENWYN>
<SYNTAX BRRRODVEJ OBJECT (HELD CARRIED ON-GROUND IN-ROOM)= V-BRRRODVEJ>
<SYNTAX REPHLEX = V-REPHLEX>
<SYNTAX REPHLEX OBJECT (HELD CARRIED ON-GROUND IN-ROOM)= V-REPHLEX>
<SYNTAX REVHOL OBJECT (HELD CARRIED ON-GROUND IN-ROOM)= V-REVHOL>
<SYNTAX TUBORG OBJECT (HELD CARRIED ON-GROUND IN-ROOM)= V-TUBORG>
<SYNTAX WORTA OBJECT (HELD CARRIED ON-GROUND IN-ROOM)= V-WORTA>
<SYNTAX XEROX OBJECT (FIND SCROLLBIT) (HAVE HELD CARRIED) = V-XEROX>

<ROUTINE V-BRENWYN ()
    <COND (<NOT <=? ,11-CURRENT-SPELL 41>> <TELL ,MESSAGE-102 CR> <RTRUE>)>
    <TELL ,MESSAGE-103 CR>>

<ROUTINE V-BRRRODVEJ ()
    <COND (<NOT <=? ,11-CURRENT-SPELL 42>> <TELL ,MESSAGE-102 CR> <RTRUE>)>
    <TELL ,MESSAGE-104 CR>>

<ROUTINE V-REPHLEX ()
    <COND (<NOT <=? ,11-CURRENT-SPELL 43>> <TELL ,MESSAGE-102 CR> <RTRUE>)>
    <COND (<=? ,HERE ,57-SECRET-CHAMBER> <SETG ,PRSO ,KVILL> <KVILL-F>)>
    <COND (<NOT <=? ,HERE ,57-SECRET-CHAMBER>> <TELL ,MESSAGE-088 CR>)>>

<ROUTINE V-REVHOL ()
    <COND (<NOT <=? ,11-CURRENT-SPELL 44>> <TELL ,MESSAGE-102 CR> <RTRUE>)>
    <TELL ,MESSAGE-105 CR>>

<ROUTINE V-TUBORG ()
    <COND (<NOT <=? ,11-CURRENT-SPELL 46>> <TELL ,MESSAGE-102 CR> <RTRUE>)>
    <TELL ,MESSAGE-106 CR>>

<ROUTINE V-WORTA ()
    <COND (<NOT <=? ,11-CURRENT-SPELL 45>> <TELL ,MESSAGE-102 CR> <RTRUE>)>
    <TELL ,SYSMESSAGE-008 CR>>

<ROUTINE V-XEROX () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: FILL/POUR -----------------------------------------------------------"
<SYNTAX FILL OBJECT (FIND CONTBIT) (IN-ROOM) WITH OBJECT (FIND LIQUIDBIT) (IN-ROOM) = V-FILL>
<SYNTAX FILL OBJECT (FIND LIQUIDBIT) (IN-ROOM) IN OBJECT (FIND CONTBIT) (IN-ROOM) = V-FILL-IN>
<VERB-SYNONYM FILL POUR>

<ROUTINE V-FILL-IN () <PERFORM V?FILL ,PRSI ,PRSO>>

;"Syntax: WRAP ----------------------------------------------------------------"
<SYNTAX WRAP OBJECT AROUND OBJECT (FIND PARTBIT) (IN-ROOM)= V-WRAP>

<ROUTINE V-WRAP () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: WRITE ---------------------------------------------------------------"
<SYNTAX WRITE ON OBJECT (FIND SCROLLBIT) (HAVE HELD CARRIED) WITH OBJECT (FIND TOOLBIT) (HAVE HELD CARRIED)= V-WRITE>

<ROUTINE V-WRITE () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: MODERN/CLASSIC ------------------------------------------------------"
<SYNTAX MODERN = V-MODERN>
<SYNTAX CLASSIC = V-CLASSIC>

<ROUTINE V-MODERN ()
        <TELL "The game is now in modern mode." CR>
        <SETG GAME_VERSION_CLASSIC <>>
        <SETG HINTS-OFF <>>
>

<ROUTINE V-CLASSIC ()
        <TELL "The game is now in classic mode." CR>
        <SETG GAME_VERSION_CLASSIC T>
        <SETG HINTS-OFF T>

>

;"Syntax: ABOUT ---------------------------------------------------------------"
<SYNTAX ABOUT = V-ABOUT>

<ROUTINE V-ABOUT ()
    <TELL "Werner's Quest was originally developed by Jan Åberg for the Commodore 64 with the Quill Adventure System.
This version for the Z-machine other than using an improved parser and a status line, have the same game logic
with some minor changes. If you want to play Werner's Quest without these changes you can change the game mode
from modern mode to classic mode with the commands 'MODERN' or 'CLASSIC'.||
The difference between modern mode and classic mode is primarely that in modern mode you have scoring and hints.||
For a detailed list of differences between classic and modern mode type 'DETAILS'.|"
    >
>

;"Syntax: INSTRUCTIONS --------------------------------------------------------"
<SYNTAX DETAILS = V-DETAILS>

<ROUTINE V-DETAILS ()
    <TELL "There are only a few differences between modern and classic mode. In modern mode:|
|
          1. There is a scoring system.|
          2. You have access to hints.|
"
    >
>

;"Syntax: XYZZY (debug)--------------------------------------------------------"

;"<SYNTAX DEBUG = V-DEBUG>

<ROUTINE V-DEBUG ()
    <GOTO ,28-SMALL-ROOM>
    <MOVE ,08-COIN ,WINNER>
    <MOVE ,43-REPHLEX-SPELL ,38-SPELL-BOOK>
    <MOVE ,44-REVHOL-SPELL ,38-SPELL-BOOK>
    <MOVE ,46-TUBORG-SPELL ,38-SPELL-BOOK>
    <MOVE ,41-BRENWYN-SPELL ,38-SPELL-BOOK>
    <MOVE ,42-BRRRODVEJ-SPELL ,38-SPELL-BOOK>
    <MOVE ,28-BUCKET-WITH-PETROL ,WINNER>
    <MOVE ,24-BOX ,WINNER>
    <MOVE ,05-YEAST-SCROLL ,WINNER>
    <MOVE ,30-BLANK-SCROLL ,WINNER>
>
"

; "REDEFINE = FALSE"
<SET REDEFINE <>>
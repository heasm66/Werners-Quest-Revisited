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
                      <AND <FSET? .I ,WORNBIT> <TELL " (worn)">>
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
    <COND (<NOT <OR <HELD? ,06-COIN> <HELD? ,12-MONEY>>>
        <TELL ,MESSAGE-040 CR>
    )
    (T
        <COND (<=? ,HERE ,24-FURNITURE-SHOP>
            <TELL ,MESSAGE-093 CR>
        )
        (T
           <TELL ,SYSMESSAGE-008 CR>
        )>
    )>
>

;"Syntax: PUT (extension)------------------------------------------------------"
<SYNTAX PUT OBJECT IN OBJECT (FIND CONTBIT) (HAVE TAKE HELD CARRIED IN-ROOM) = V-INSERT>

<ROUTINE V-INSERT () <TELL ,SYSMESSAGE-008 CR>
>

;"Syntax: THROW (extension)----------------------------------------------------"
<SYNTAX THROW OBJECT (TAKE HAVE HELD CARRIED) = V-THROW>

<ROUTINE V-THROW () <V-DROP>
>

;"Syntax: PUSH (synonyms)------------------------------------------------------"
<VERB-SYNONYM PUSH PRESS USE RING>

;"Syntax: UNWEAR (synonyms)----------------------------------------------------"
<VERB-SYNONYM UNWEAR REMOVE>

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
<VERB-SYNONYM GIVE SHOW>

;"Syntax: ENTER ---------------------------------------------------------------"
<SYNTAX ENTER = V-GO-IN>

<ROUTINE V-GO-IN () <DO-WALK ,P?IN>>

;"Syntax: SAY -----------------------------------------------------------------"
<SYNTAX SAY OBJECT = V-SAY>
<SYNTAX SAY OBJECT TO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-SAY>
<VERB-SYNONYM SAY ANSWER>

<ROUTINE V-SAY () <TELL ,MESSAGE-083 CR>>

;"Syntax: TIE -----------------------------------------------------------------"
<SYNTAX TIE OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND TIEABLEBIT) (IN-ROOM)= V-TIE>

<ROUTINE V-TIE () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: UNTIE ---------------------------------------------------------------"
<SYNTAX UNTIE OBJECT = V-UNTIE>
<VERB-SYNONYM UNTIE RELEASE>

<ROUTINE V-UNTIE () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: DIG -----------------------------------------------------------------"
<SYNTAX DIG  = V-DIG>

<ROUTINE V-DIG ()
    <COND (<HELD? ,15-SHOVEL>
        <TELL ,MESSAGE-100 CR>
        <RTRUE>
    )
    (T
        <TELL ,MESSAGE-099 CR>
        <RTRUE>
    )>
>

;"Syntax: DIG -----------------------------------------------------------------"
<SYNTAX SLEEP  = V-SLEEP>

<ROUTINE V-SLEEP ()
    <COND (<AND <OR <HELD? ,24-VELVET-CUSHION> <=? <LOC ,24-VELVET-CUSHION> ,HERE>>
                <OR <HELD? ,27-SATIN-CUSHION> <=? <LOC ,27-SATIN-CUSHION> ,HERE>>
                <OR <HELD? ,33-RADIO-MELLOW-YELLOW> <=? <LOC ,33-RADIO-MELLOW-YELLOW> ,HERE>>>
        <TELL ,MESSAGE-080 CR>
        <COND (<NOT ,SCORE-SLEEP-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-SLEEP-FLAG T>)>
        <RTRUE>
    )
    (T
        <TELL ,MESSAGE-079 CR>
        <RTRUE>
    )>
>

;"Syntax: LOOK UP -------------------------------------------------------------"
<SYNTAX LOOK UP OBJECT (FIND KLUDGEBIT) = V-LOOK-UP>

<ROUTINE V-LOOK-UP () <TELL "You see nothing special." CR>>

;"Syntax: LOOK UP -------------------------------------------------------------"
<SYNTAX SPRAY OBJECT = V-SPRAY>

<ROUTINE V-SPRAY () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: MAKE (DRAW, CONNECT) ------------------------------------------------"
<SYNTAX MAKE OBJECT = V-MAKE-LINE>
<SYNTAX MAKE FROM OBJECT TO OBJECT = V-MAKE-LINE>
<SYNTAX MAKE BETWEEN OBJECT TO OBJECT = V-MAKE-LINE>
<SYNTAX MAKE OBJECT TO OBJECT = V-MAKE-LINE>

<SYNONYM MAKE DRAW CONNECT>

<ROUTINE V-MAKE-LINE ()
    <COND (<HELD? ,18-PENCIL>
        <JIGS-UP ,MESSAGE-055>
        <RTRUE>
    )
    (T
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Syntax: MODERN/CLASIC -------------------------------------------------------"
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
The difference between modern mode and classic mode is primarely that in modern mode you have scoring.||
For a detailed list of differences between classic and modern mode type 'DETAILS'.|"
    >
>

;"Syntax: INSTRUCTIONS --------------------------------------------------------"
<SYNTAX DETAILS = V-DETAILS>

<ROUTINE V-DETAILS ()
    <TELL "There are only a few differences between standard and classic mode. In standard mode:|
|
          1. There is a scoring system.|
"
    >
>

;"Syntax: XYZZY (debug)--------------------------------------------------------"
;"
<SYNTAX DEBUG = V-DEBUG>

<ROUTINE V-DEBUG ()
    <MOVE ,12-MONEY ,PLAYER>
    <MOVE ,24-VELVET-CUSHION ,PLAYER>
    <MOVE ,27-SATIN-CUSHION ,PLAYER>
    <MOVE ,20-ROPE ,PLAYER>
    <MOVE ,13-BEAM ,PLAYER>
    <MOVE ,35-BATTERY ,PLAYER>
    <MOVE ,22-ROSETTE ,PLAYER>
    <MOVE ,39-DEVICE ,PLAYER>
    <GOTO ,53-IN-BRICK-BUILDING>
>
"

; "REDEFINE = FALSE"
<SET REDEFINE <>>
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
    <COND (<NOT <HELD? ,19-COIN>>
        <TELL ,MESSAGE-072 CR>
        <RTRUE>)   
    >
	<TELL ,SYSMESSAGE-008 CR CR>
>

;"Syntax: PUT (extension)------------------------------------------------------"
<SYNTAX PUT OBJECT IN OBJECT (FIND CONTBIT) (IN-ROOM) = V-INSERT>
<SYNTAX PUT OBJECT = V-INSERT>

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
<VERB-SYNONYM GIVE SHOW>

;"Syntax: ENTER ---------------------------------------------------------------"
<SYNTAX ENTER = V-GO-IN>

<ROUTINE V-GO-IN () <DO-WALK ,P?IN>>

;"Syntax: SAY -----------------------------------------------------------------"
<SYNTAX SAY OBJECT = V-SAY>
<SYNTAX SAY OBJECT TO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-SAY>
<VERB-SYNONYM SAY ANSWER>

<ROUTINE V-SAY () <TELL "Nobody is listening." CR>>

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
        <COND (<OR ,GAME_VERSION_CLASSIC <G=? ,HIT-COUNTER 1>>
            <JIGS-UP ,MESSAGE-049> 
            <RTRUE>
        )
        (T
            <TELL "As you raise your hand to strike, the now-familiar troll appears. His menacing presence makes you reconsider." CR>
            <SETG ,HIT-COUNTER <+ ,HIT-COUNTER 1>>
            <RTRUE>
        )>
   >

;"Syntax: KISS ----------------------------------------------------------------"
<SYNTAX KISS OBJECT = V-KISS>

<ROUTINE V-KISS () <TELL "Keep your mind on the game." CR>>

;"Syntax: HELLO ---------------------------------------------------------------"
<SYNTAX HELLO = V-HELLO>
<SYNTAX HELLO OBJECT (FIND PERSONBIT) (IN-ROOM)= V-HELLO>
<VERB-SYNONYM HELLO HI>

<ROUTINE V-HELLO () <TELL "You are plainly ignored." CR>>

;"Syntax: SAW -----------------------------------------------------------------"
<SYNTAX SAW OBJECT WITH OBJECT (FIND TOOLBIT) (HAVE HELD CARRIED) = V-SAW>

<ROUTINE V-SAW () <TELL ,SYSMESSAGE-008 CR>>

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
          3. Rance leaves the blanket behind when he rescues you from the well.|
"
    >
>

;"Syntax: XYZZY (debug)--------------------------------------------------------"

;"
<SYNTAX DEBUG = V-DEBUG>

<ROUTINE V-DEBUG ()
    <GOTO ,25-BEDROOM>
    <MOVE ,11-BLANKET ,WINNER>
    <MOVE ,08-BASKETBALL ,WINNER>
    <MOVE ,09-PAPERBAG ,WINNER>
    <MOVE ,05-ZX-SPECTRUM ,WINNER>
    <MOVE ,27-SALAMI ,WINNER>
    <MOVE ,26-YELLOW-STAMP ,WINNER>
    <MOVE ,29-DANISH-PASTRY ,WINNER>
    <MOVE ,30-ALBUM ,WINNER>
>
"

; "REDEFINE = FALSE"
<SET REDEFINE <>>
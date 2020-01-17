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

<ROUTINE V-QUIT ()
    <TELL CR ,SYSMESSAGE-012>
    <COND (<YES?>
        <JIGS-UP "">)
        (ELSE
        <TELL CR "OK - not quitting." CR>)>>

<ROUTINE V-RESTART ()
    <TELL CR "Are you sure you want to restart?">
    <COND (<YES?>
           <RESTART>)
          (ELSE
           <TELL "Restart aborted." CR>)>>
           
;"-----------------------------------------------------------------------------
; ZILF Library and extensions - New syntax (Game specific)
; -----------------------------------------------------------------------------"

;"Syntax: KNOCK ---------------------------------------------------------------"
<SYNTAX KNOCK OBJECT (FIND DOORBIT) (IN-ROOM)= V-KNOCK>
<SYNTAX KNOCK ON OBJECT (FIND DOORBIT) = V-KNOCK>

<ROUTINE V-KNOCK () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: BUY -----------------------------------------------------------------"
<SYNTAX BUY OBJECT = V-BUY>

<ROUTINE V-BUY ()
    <COND (<NOT <=? <LOC ,01-COIN> ,PLAYER>>
        <TELL ,MESSAGE-060 CR>
        <RTRUE>)   
    >
    <COND (<AND <PRSO? ,03-TICKET> <=? ,HERE ,10-SMALL-ROOM>>
        <SETG ,PRSI ,VENDING-MACHINE>
        <COIN-F>
        <RTRUE>)
    (T
	    <TELL ,SYSMESSAGE-008 CR CR>)
    >
>

;"Syntax: PUT (extension)------------------------------------------------------"
<SYNTAX PUT OBJECT = V-INSERT>
<VERB-SYNONYM PUT SLIDE DIP SOAK>

<ROUTINE V-INSERT ()
     <COND (<AND <PRSO? ,01-COIN> <EQUAL? ,HERE ,10-SMALL-ROOM>>
        <TELL "[in the vending machine]|">
        <SETG ,PRSI ,VENDING-MACHINE>
        <COIN-F>
        <RTRUE>)
    (T
	    <TELL ,SYSMESSAGE-008 CR>)
    >
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

;"Syntax: RAISE ---------------------------------------------------------------"
<SYNTAX RAISE OBJECT = V-RAISE>

<ROUTINE V-RAISE ()
     <COND (<PRSO? HAND>
        <TELL ,MESSAGE-043 CR>
        <RTRUE>)
    (T
	    <TELL ,SYSMESSAGE-008 CR>)
    >
>

;"Syntax: DUCK ----------------------------------------------------------------"
<SYNTAX DUCK = V-DUCK>

<ROUTINE V-DUCK () <TELL ,MESSAGE-043 CR>>

;"Syntax: GIVE (new definition and synonyms)-----------------------------------"
<SYNTAX GIVE OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND PERSONBIT) (IN-ROOM)= V-GIVE>       ; Overrides default definition
<SYNTAX GIVE OBJECT (FIND PERSONBIT) (IN-ROOM) OBJECT (HAVE HELD CARRIED) = V-SGIVE>        ; Overrides default definition
<VERB-SYNONYM GIVE SHOW>

;"Syntax: ENTER ---------------------------------------------------------------"
<SYNTAX ENTER = V-GO-IN>

<ROUTINE V-GO-IN () <DO-WALK ,P?IN>>

;"Syntax: CALL ----------------------------------------------------------------"
<SYNTAX CALL OBJECT = V-CALL>
<VERB-SYNONYM CALL DIAL>

<ROUTINE V-CALL ()
    <COND (<IN? ,14-PHONE ,PLAYER>
        <COND (<OR <=? ,P-NUMBER-HASH 203> <=? ,PRSO ,MAZE-SERVICE>>     ;"203 is the hash-number for 083214693"
            <COND (<FSET? ,HERE ,MAZEBIT>
                <TELL ,MESSAGE-077 CR CR>
                <GOTO ,11-DUNGEON-LOBBY>
                <COND (<NOT ,SCORE-ESCAPE-MAZE-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ESCAPE-MAZE-FLAG T>)>
                <RTRUE>
            )
            (T
                <TELL ,MESSAGE-078 CR>
                <RTRUE>
            )>
        )
        (T
            <COND (<AND <NOT <=? ,P-NUMBER-HASH 203>> <=? ,PRSO ,NUMBER>>
                <TELL ,MESSAGE-079 CR>
                <RTRUE>
            )
            (T
                <TELL ,SYSMESSAGE-008 CR>
                <RTRUE>
            )>
        )>
    )
    (T 
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Syntax: TURN ----------------------------------------------------------------"
<SYNTAX TURN OBJECT = V-TURN>

<ROUTINE V-TURN () <TELL ,MESSAGE-043 CR>>

;"Syntax: MOOSE ---------------------------------------------------------------"
<SYNTAX MOOSE = V-MOOSE>

<ROUTINE V-MOOSE () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: HELLO ---------------------------------------------------------------"
<SYNTAX HELLO = V-HELLO>
<VERB-SYNONYM HELLO HI>

<ROUTINE V-HELLO () <TELL ,SYSMESSAGE-008 CR>>

;"Syntax: ATTACK (overrides action) -------------------------------------------"
<ROUTINE V-ATTACK ()
    <COND (<OR <NOT <FSET? ,HERE ,NDUNGEONBIT>> <=? ,HERE ,10-SMALL-ROOM>>
        <COND (<OR ,GAME_VERSION_CLASSIC <G=? ,HIT-COUNTER 1>>
            <JIGS-UP ,MESSAGE-030> 
            <RTRUE>
        )
        (T
            <TELL "As you raise your hand to strike, the troll appears. The troll waves his axe in your direction and you understand that destroying the inventory will be frowned upon." CR>
            <SETG ,HIT-COUNTER <+ ,HIT-COUNTER 1>>
            <RTRUE>
        )>
    )>
    <COND (<PRSO? ,WINNER> <TELL "Let's hope it doesn't come to that." CR>)
          (<FSET? ,PRSO ,PERSONBIT> <YOU-MASHER>)
          (ELSE <POINTLESS "Taking your frustration out on">)>
    <RTRUE>>

;"Syntax: WAVE (new definition) -----------------------------------------------"
<SYNTAX WAVE OBJECT = V-WAVE>

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
The difference between modern mode and classic mode is primarely that in modern mode you have scoring, hints
and that the game is not quite so quick to kill you in a few instances.||
For a detailed list of differences between classic and modern mode type 'DETAILS' (contains some spoilers).|"
    >
>

;"Syntax: INSTRUCTIONS --------------------------------------------------------"
<SYNTAX DETAILS = V-DETAILS>

<ROUTINE V-DETAILS ()
    <TELL "There are only a few differences between modern and classic mode. In modern mode:|
|
          1. There is a scoring system.|
          2. You have access to hints.|
          3. Entering darkness doesn't kill you immediately.|
          4. If you paid for access to the dungeon but leave it, the troll will let you in again.|
          5. Trying to destroy things doesn't kill you immediately.|
          6. Wearing the spectacles doesn't kill you immediately.|
          7. The Nutri-Mat Liquid Dispensing Machine produces a new cup of tea if you give the first one to Arthur Dent.|
"
    >
>

;"Syntax: XYZZY (debug)--------------------------------------------------------"
;"
<SYNTAX XYZZY = V-XYZZY>

<ROUTINE V-XYZZY ()
    <MOVE ,01-COIN ,PLAYER>
    <MOVE ,05-DISGUISE ,PLAYER>
    <MOVE ,13-BABELFISH ,PLAYER>
    <MOVE ,16-SPECTACLES ,PLAYER>   
    <MOVE ,26-LADDER ,PLAYER>
    <MOVE ,21-RODS ,PLAYER>   
    <MOVE ,08-STATUETTE ,PLAYER>  
    <MOVE ,07-ACCESS-CARD ,PLAYER> 
    <MOVE ,14-PHONE ,PLAYER> 
    <MOVE ,21-RODS ,PLAYER> 
    <MOVE ,22-BLACK-ROD ,PLAYER> 
    <MOVE ,12-PASTRY ,PLAYER>
    <MOVE ,24-TEA ,PLAYER>
    <SETG ,12-LIGHT-FLAG T>
    <SETG ,17-DRAGON-COUNTER 0>
    <GOTO ,27-BAR>
>
"

; "REDEFINE = FALSE"
<SET REDEFINE <>>
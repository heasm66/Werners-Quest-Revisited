;"-----------------------------------------------------------------------------
; ZILF Library and extensions
;
; <SET REDEFINE T> - Replaces definitions of routines, constants 
;                    and variables.
;                    This must appear AFTER original definition. 
;
;                    Changed lines is marked with: Changed line
;
; -----------------------------------------------------------------------------"

;"REDEFINE = TRUE"
<SET REDEFINE T>

;"-----------------------------------------------------------------------------
; ZILF Library and extensions - parser.zil
; -----------------------------------------------------------------------------"

;"Only to change a couple of texts..."
<ROUTINE PARSER ("AUX" NOBJ VAL DIR DIR-WN O-R KEEP OW OH OHL)
    ;"Need to (re)initialize locals here since we use AGAIN"
    <SET OW ,WINNER>
    <SET OH ,HERE>
    <SET OHL ,HERE-LIT>
    <SET NOBJ <>>
    <SET VAL <>>
    <SET DIR <>>
    <SET DIR-WN <>>
    ;"Fill READBUF and LEXBUF"
    <COND (<L? ,P-CONT 0> <SETG P-CONT 0>)>
    <COND (,P-CONT
          <TRACE 1 "[PARSER: continuing from word " N ,P-CONT "]" CR>
          <ACTIVATE-BUFS "CONT">
          <COND (<1? ,P-CONT> <SETG P-CONT 0>)
                (<N=? ,MODE ,SUPERBRIEF>
                  ;"Print a blank line between multiple commands"
                  <COND (<NOT <VERB? TELL>> <CRLF>)>)>)
          (ELSE
          <TRACE 1 "[PARSER: fresh input]" CR>
          <RESET-WINNER>
          <SETG HERE <LOC ,WINNER>>
          <SETG HERE-LIT <SEARCH-FOR-LIGHT>>
          <READLINE T>)>

    <IF-DEBUG <SETG TRACE-INDENT 0>>
    <TRACE-DO 1 <DUMPBUFS> ;<DUMPLINE>>
    <TRACE-IN>

    <SETG P-LEN <GETB ,LEXBUF 1>>
    <COND (<0? ,P-LEN>
          <TELL "Huh?" CR>                                  ;"Changed line"
          <SETG P-CONT 0>
          <RFALSE>)>

    ;"Save undo state unless this looks like an undo command"
    <IF-UNDO
        <COND (<AND <G=? ,P-LEN 1>
                    <=? <GETWORD? 1> ,W?UNDO>
                    <OR <1? ,P-LEN>
                        <=? <GETWORD? 2> ,W?\. ,W?THEN>>>)
              (ELSE
              <TRACE 4 "[saving for UNDO]" CR>
              <BIND ((RES <ISAVE>))
                  <COND (<=? .RES 2>
                          <TELL "Previous turn undone." CR CR>
                          <SETG WINNER .OW>
                          <SETG HERE .OH>
                          <SETG HERE-LIT .OHL>
                          <V-LOOK>
                          <SETG P-CONT 0>
                          <AGAIN>)
                        (ELSE
                          <SETG USAVE .RES>)>>)>>

    <COND (<0? ,P-CONT>
          ;"Handle OOPS"
          <COND (<AND ,P-LEN <=? <GETWORD? 1> ,W?OOPS>>
                  <COND (<=? ,P-LEN 2>
                        <COND (<P-OOPS-WN>
                                <TRACE 2 "[handling OOPS]" CR>
                                <HANDLE-OOPS 2>
                                <SETG P-LEN <GETB ,LEXBUF 1>>
                                <TRACE-DO 1 <DUMPLINE>>)
                              (ELSE
                                <TELL "Nothing to correct." CR>
                                <RFALSE>)>)
                        (<=? ,P-LEN 1>
                        <TELL "It's OK." CR>
                        <RFALSE>)
                        (ELSE
                        <TELL "You can only correct one word at a time." CR>
                        <RFALSE>)>)>)>

    <SET KEEP 0>
    <P-OOPS-WN 0>
    <P-OOPS-CONT 0>
    <P-OOPS-O-REASON ,P-O-REASON>

    <COND (<0? ,P-CONT>
          ;"Save command in edit buffer for OOPS"
          <COND (<N=? ,READBUF ,EDIT-READBUF>
                  <COPY-TO-BUFS "EDIT">
                  <ACTIVATE-BUFS "EDIT">)>
          ;"Handle an orphan response, which may abort parsing or ask us to skip steps"
          <COND (<ORPHANING?>
                  <SET O-R <HANDLE-ORPHAN-RESPONSE>>
                  <COND (<N=? .O-R ,O-RES-NOT-HANDLED>
                        <SETG WINNER .OW>
                        <SETG HERE .OH>
                        <SETG HERE-LIT .OHL>)>
                  <COND (<=? .O-R ,O-RES-REORPHANED>
                        <TRACE-OUT>
                        <RFALSE>)
                        (<=? .O-R ,O-RES-FAILED>
                        <SETG P-O-REASON <>>
                        <TRACE-OUT>
                        <RFALSE>)
                        (<=? .O-R ,O-RES-SET-NP>
                        ;"TODO: Set the P-variables somewhere else? Shouldn't we fill in what
                          we know about the command-to-be when we ask the orphaning question, not
                          when we get the response?"
                        <SETG P-P1 <GETB ,P-SYNTAX ,SYN-PREP1>>
                        <COND (<ORPHANING-PRSI?>
                                <SETG P-P2 <GETB ,P-SYNTAX ,SYN-PREP2>>
                                <SETG P-NOBJ 2>
                                ;"Don't re-match P-NP-DOBJ when we've just orphaned PRSI. Use the saved
                                  match results. There won't be a NP to match if we GWIMmed PRSO."
                                <SET KEEP 1>)
                              (ELSE <SETG P-NOBJ 1>)>)
                        (<=? .O-R ,O-RES-SET-PRSTBL>
                        <COND (<ORPHANING-PRSI?> <SET KEEP 2>)
                              (ELSE <SET KEEP 1>)>)>
                  <SETG P-O-REASON <>>)>
          ;"If we aren't handling this command as an orphan response, convert it if needed
            and copy it to CONT bufs"
          <COND (<NOT .O-R>
                  ;"Translate order syntax (HAL, OPEN THE POD BAY DOOR or
                    TELL HAL TO OPEN THE POD BAY DOOR) into multi-command syntax
                    (\,TELL HAL THEN OPEN THE POD BAY DOOR)."
                  <COND (<CONVERT-ORDER-TO-TELL?>
                        <SETG P-LEN <GETB ,LEXBUF 1>>)>)>)>

    ;"Identify parts of speech, parse noun phrases"
    <COND (<N=? .O-R ,O-RES-SET-NP ,O-RES-SET-PRSTBL>
          <SETG P-V <>>
          <SETG P-NOBJ 0>
          <CLEAR-NOUN-PHRASE ,P-NP-DOBJ>
          <CLEAR-NOUN-PHRASE ,P-NP-IOBJ>
          <SETG P-P1 <>>
          <SETG P-P2 <>>
          ;"Identify the verb, prepositions, and noun phrases"
          <REPEAT ((I <OR ,P-CONT 1>) W V)
              <COND (<G? .I ,P-LEN>
                      ;"Reached the end of the command"
                      <SETG P-CONT 0>
                      <RETURN>)
                    (<NOT <OR <SET W <GETWORD? .I>>
                              <AND <PARSE-NUMBER? .I> <SET W ,W?\,NUMBER>>>>
                      ;"Word not in vocabulary"
                      <STORE-OOPS .I>
                      <SETG P-CONT 0>
                      <TELL ,SYSMESSAGE-006 CR>             ;"Changed line"
                      <RFALSE>)
                    (<=? .W ,W?THEN ,W?\.>
                      ;"End of command, maybe start of a new one"
                      <TRACE 3 "['then' word " N .I "]" CR>
                      <SETG P-CONT <+ .I 1>>
                      <COND (<G? ,P-CONT ,P-LEN> <SETG P-CONT 0>)
                            (ELSE <COPY-TO-BUFS "CONT">)>
                      <RETURN>)
                    (<AND <NOT ,P-V>
                          <SET V <WORD? .W VERB>>
                          <OR <NOT .DIR> <=? .V ,ACT?WALK>>>
                      ;"Found the verb"
                      <SETG P-V-WORD .W>
                      <SETG P-V-WORDN .I>
                      <SETG P-V .V>
                      <TRACE 3 "[verb word " N ,P-V-WORDN " '" B ,P-V-WORD "' = " N ,P-V "]" CR>)
                    (<AND <NOT .DIR>
                          <EQUAL? ,P-V <> ,ACT?WALK>
                          <SET VAL <WORD? .W DIRECTION>>>
                      ;"Found a direction"
                      <SET DIR .VAL>
                      <SET DIR-WN .I>
                      <TRACE 3 "[got a direction]" CR>)
                    (<SET VAL <CHKWORD? .W ,PS?PREPOSITION 0>>
                      ;"Found a preposition"
                      ;"Only keep the first preposition for each object"
                      <COND (<AND <==? .NOBJ 0> <NOT ,P-P1>>
                            <TRACE 3 "[P1 word " N .I " '" B .W "' = " N .VAL "]" CR>
                            <SETG P-P1 .VAL>)
                            (<AND <==? .NOBJ 1> <NOT ,P-P2>>
                            <TRACE 3 "[P2 word " N .I " '" B .W "' = " N .VAL "]" CR>
                            <SETG P-P2 .VAL>)>)
                    (<STARTS-NOUN-PHRASE? .W>
                      ;"Found a noun phrase"
                      <SET NOBJ <+ .NOBJ 1>>
                      <TRACE 3 "[NP start word " N .I ", now NOBJ=" N .NOBJ "]" CR>
                      <TRACE-IN>
                      <COND (<==? .NOBJ 1>
                            ;"If we found a direction earlier, try it as a preposition instead"
                            ;"This fixes GO IN BUILDING (vs. GO IN)"
                            <COND (<AND .DIR
                                        ,P-V
                                        <NOT ,P-P1>
                                        <SET V <GETWORD? .DIR-WN>>
                                        <SET VAL <CHKWORD? .V ,PS?PREPOSITION 0>>>
                                    <TRACE 3 "[revising direction word " N .DIR-WN
                                            " as P1: '" B .V "' = " N .VAL "]" CR>
                                    <SETG P-P1 .VAL>
                                    <SET DIR <>>
                                    <SET DIR-WN <>>)>
                            <SET VAL <PARSE-NOUN-PHRASE .I ,P-NP-DOBJ>>)
                            (<==? .NOBJ 2>
                            <SET VAL <PARSE-NOUN-PHRASE .I ,P-NP-IOBJ>>)
                            (ELSE
                            <SETG P-CONT 0>
                            <TELL "That sentence has too many objects." CR>
                            <RFALSE>)>
                      <TRACE 3 "[PARSE-NOUN-PHRASE returned " N .VAL "]" CR>
                      <TRACE-OUT>
                      <COND (.VAL
                            <SET I .VAL>
                            <AGAIN>)
                            (ELSE
                            <SETG P-CONT 0>
                            <RFALSE>)>)
                    (ELSE
                      ;"Unexpected word type"
                      <STORE-OOPS .I>
                      <SETG P-CONT 0>
                      <TELL "I didn't expect the word \"" WORD .I "\" there." CR>
                      <TRACE-OUT>
                      <RFALSE>)>
              <SET I <+ .I 1>>>

          <SETG P-NOBJ .NOBJ>

          <TRACE-OUT>
          <TRACE 1 "[sentence: V=" MATCHING-WORD ,P-V ,PS?VERB ,P1?VERB "(" N ,P-V ") NOBJ=" N ,P-NOBJ
                " P1=" MATCHING-WORD ,P-P1 ,PS?PREPOSITION 0 "(" N ,P-P1
                ") DOBJS=+" N <NP-YCNT ,P-NP-DOBJ> "-" N <NP-NCNT ,P-NP-DOBJ>
                " P2=" MATCHING-WORD ,P-P2 ,PS?PREPOSITION 0 "(" N ,P-P2
                ") IOBJS=+" N <NP-YCNT ,P-NP-IOBJ> "-" N <NP-NCNT ,P-NP-IOBJ> "]" CR>
          <TRACE-IN>

          ;"If we have a direction and nothing else except maybe a WALK verb, it's
            a movement command."
          <COND (<AND .DIR
                      <EQUAL? ,P-V <> ,ACT?WALK>
                      <0? .NOBJ>
                      <NOT ,P-P1>
                      <NOT ,P-P2>>
                  <SETG PRSO-DIR T>
                  <SETG PRSA ,V?WALK>
                  <SETG PRSO .DIR>
                  <SETG PRSI <>>
                  <COND (<NOT <VERB? AGAIN>>
                        <TRACE 4 "[saving for AGAIN]" CR>
                        <SAVE-PARSER-RESULT ,AGAIN-STORAGE>)>
                  <TRACE-OUT>
                  <RTRUE>)>
          ;"Otherwise, a verb is required and a direction is forbidden."
          <COND (<NOT ,P-V>
                  <SETG P-CONT 0>
                  <TELL "That sentence has no verb." CR>
                  <TRACE-OUT>
                  <RFALSE>)
                (.DIR
                  <STORE-OOPS .DIR-WN>
                  <SETG P-CONT 0>
                  <TELL "I don't understand what \"" WORD .DIR-WN "\" is doing in that sentence." CR>
                  <TRACE-OUT>
                  <RFALSE>)>
          <SETG PRSO-DIR <>>)>
    ;"Match syntax lines and objects"
    <COND (<NOT .O-R>
          <TRACE 2 "[matching syntax and finding objects, KEEP=" N .KEEP "]" CR>
          <COND (<NOT <AND <MATCH-SYNTAX> <FIND-OBJECTS .KEEP>>>
                  <TRACE-OUT>
                  <SETG P-CONT 0>
                  <RFALSE>)>)
          (<L? .KEEP 2>
          ;"We already found a syntax line last time, but we need FIND-OBJECTS to
            match at least one noun phrase."
          <TRACE 2 "[only finding objects, KEEP=" N .KEEP "]" CR>
          <COND (<NOT <FIND-OBJECTS .KEEP>>
                  <TRACE-OUT>
                  <SETG P-CONT 0>
                  <RFALSE>)>)>
    ;"Save command for AGAIN"
    <COND (<NOT <VERB? AGAIN>>
          <TRACE 4 "[saving for AGAIN]" CR>
          <SAVE-PARSER-RESULT ,AGAIN-STORAGE>)>
    ;"If successful PRSO, back up PRSO for IT"
    <SET-PRONOUNS ,PRSO ,P-PRSOS>
    <TRACE-OUT>
    <RTRUE>>

;"Checks whether the command is an order, and if so, converts it to multi-command syntax
  (\,TELL <actor> THEN <command>).

  Also Converts phrases like (<actor>, <noun>) to (TELL <actor> ABOUT <noun>).

Sets:
  HELD-READBUF
  HELD-LEXBUF

Returns:
  True if the command was converted."
<ROUTINE CONVERT-ORDER-TO-TELL? ("AUX" P W)
    <COND (<L? ,P-LEN 2> <RFALSE>)
          (<AND <STARTS-NOUN-PHRASE? <GETWORD? 1>>
                <SET P <PARSE-NOUN-PHRASE 1 ,P-NP-XOBJ T>>
                <L? .P ,P-LEN>
                <=? <GETWORD? .P> ,W?COMMA>
                <OR <CHKWORD? <SET W <GETWORD? <+ .P 1>>> ,PS?VERB>
                    <CHKWORD? .W ,PS?DIRECTION>>>
           <TRACE 2 "[got ACTOR, VERB order syntax]" CR>
           <TRACE-IN>
           <REPLACE-HELD-WORD .P ,W?.>
           <INSERT-HELD-WORD 1 ,W?\,TELL>
           <TRACE-OUT>
           <RTRUE>)
          (<AND <=? <GETWORD? 1> ,W?TELL>
                <SET P <PARSE-NOUN-PHRASE 2 ,P-NP-XOBJ T>>
                <L? .P ,P-LEN>
                <=? <GETWORD? .P> ,W?TO>
                <OR <CHKWORD? <SET W <GETWORD? <+ .P 1>>> ,PS?VERB>
                    <CHKWORD? .W ,PS?DIRECTION>>>
           <TRACE 2 "[got TELL ACTOR TO VERB order syntax]" CR>
           <TRACE-IN>
           <REPLACE-HELD-WORD .P ,W?.>
           <REPLACE-HELD-WORD 1 ,W?\,TELL>
           <TRACE-OUT>
           <RTRUE>)
          
          ;"Converts phrases like [ACTOR, NOUN] to [TELL ACTOR ABOUT NOUN]"
          (<AND <STARTS-NOUN-PHRASE? <GETWORD? 1>>          ;"Changed line"
                <SET P <FIND-COMMA-POSITION 1>>             ;"Changed line"
                <L? .P ,P-LEN>                              ;"Changed line"
                <G? .P 0>                                   ;"Changed line"        
                <STARTS-NOUN-PHRASE? <GETWORD? <+ .P 1>>>>  ;"Changed line"
           <TRACE 2 "[got ACTOR, NOUN]" CR>                 ;"Changed line"
           <TRACE-IN>                                       ;"Changed line"
           <REPLACE-HELD-WORD .P ,W?ABOUT>                  ;"Changed line"
           <INSERT-HELD-WORD 1 ,W?TELL>                     ;"Changed line"
           <TRACE-OUT>                                      ;"Changed line"
           <RTRUE>)>>                                       ;"Changed line"

;"New routine: Returns the position of a comma in current phrase starting at position WN.
  Returns 0 if no comma."
<ROUTINE FIND-COMMA-POSITION (WN)                           ;"Changed line"
    <REPEAT ()                                              ;"Changed line"
        <COND                                               ;"Changed line"
            ;"exit loop if we reached the end of the command"
            (<G? .WN ,P-LEN> <RETURN 0>)                    ;"Changed line"
            (<=? <GETWORD? .WN> ,W?COMMA> <RETURN .WN>)     ;"Changed line"
        >                                                   ;"Changed line"
        <SET .WN <+ .WN 1>>                                 ;"Changed line"
    >
>

;"Standard for PARSE-NUMBER is to return <RFALSE> if number > maxint (32767)
  This routine return maxint (32767) instead. This is to enable the player
  to CALL and arbitry telephone-number.
  The routine also calculates a simple hash-number and stores it in 
  P-NUMBER-HASH to be able to identify a specific telephone number."
<GLOBAL P-NUMBER-HASH 0>                                    ;"Changed line"

<ROUTINE PARSE-NUMBER? (WN "AUX" I MAX V C NEG OVF HASH V-HASH) ;"Changed line"
    <SET I <GETB ,LEXBUF <+ <* .WN 4> 1>>>
    <SET MAX <- <+ .I <GETB ,LEXBUF <* .WN 4>>> 1>>
    <SET OVF <>>                                            ;"Changed line"
    <SET HASH 1>                                            ;"Changed line"
    <SET V-HASH 0>                                          ;"Changed line"
    <COND (<0? .MAX> <RFALSE>)>
    <COND (<=? <SET C <GETB ,READBUF .I>> !\->
        <SET NEG T>
        <AND <IGRTR? I .MAX> <RFALSE>>
        <SET C <GETB ,READBUF .I>>)>
    <PROG ()
        <COND (<AND <G=? .C !\0> <L=? .C !\9>>
            ;"Special case for -32768"
            <COND (<AND <=? .V 3276>
                        <=? .C !\8>
                        .NEG
                        <=? .I .MAX>>
                    <SET V -32768>
                    <RETURN>)>
            ;"Detect overflow"
            <COND (<AND <G=? .V 3276>
                        <OR <G? .V 3276>
                            <G? .C !\7>>>
                    <SET V 32767>                                       ;"Changed line"
                    <SET OVF T>)>                                       ;"Changed line"
            <COND (<NOT .OVF> <SET V <+ <* .V 10> <- .C !\0>>>)>        ;"Changed line"
            <SET V-HASH <MOD <+ .V-HASH <* .HASH <- .C !\0>>> 10000>>   ;"Changed line"
            <SET HASH <+ .HASH 1>>)                                     ;"Changed line"
            (ELSE <RFALSE>)>
        <COND (<NOT <IGRTR? I .MAX>>
            <SET C <GETB ,READBUF .I>>
            <AGAIN>)>
        <COND (.NEG <SET V <- .V>>)>>
    <SETG P-NUMBER .V>
    <SETG P-NUMBER-HASH .V-HASH>                                        ;"Changed line"
    <PUT ,LEXBUF <- <* .I 2> 1> ,W?\,NUMBER>
    <RETURN ,NUMBER>>

;"Attempts to parse a noun phrase.

If the match fails, an error message may be printed.

Sets:
  P-OOPS-DATA

Uses:
  P-LEN

Args:
  WN: The 1-based word number where the noun clause starts.
  NP: A NOUN-PHRASE in which to return the parsed result.
  SILENT?: If true, don't print a message on failure, and don't set any error-related
    parser state (i.e. P-OOPS-DATA). Defaults to false.

Returns:
  If parsing is successful, returns a positive number: the number of the first word that is
  not part of the noun phrase, which will be one greater than P-LEN if the noun phrase consumes
  the rest of the command.

  If parsing fails, returns zero, prints an error message (unless SILENT? is true) and may
  leave NP in an invalid state."
<ROUTINE PARSE-NOUN-PHRASE (WN NP "OPT" (SILENT? <>) "AUX" SPEC CNT W VAL MODE ADJ NOUN BUT SPEC-WN)
    <TRACE 3 "[PARSE-NOUN-PHRASE starting at word " N .WN "]" CR>
    <TRACE-IN>

    <SET SPEC <NP-YSPEC .NP 1>>
    <NP-NCNT .NP 0>
    <REPEAT ()
        <COND
            ;"exit loop if we reached the end of the command"
            (<G? .WN ,P-LEN>
             <TRACE 4 "[end of command]" CR>
             <RETURN>)
            ;"fail if we found an unrecognized word"
            (<NOT <OR <SET W <GETWORD? .WN>>
                      <AND <PARSE-NUMBER? .WN> <SET W ,W?\,NUMBER>>>>
             <TRACE 4 "[stop at unrecognized word: " WORD .WN "]" CR>
             <COND (<NOT .SILENT?>
                    <STORE-OOPS .WN>
                    <TELL ,SYSMESSAGE-006 CR>)>             ;"Changed line"
             <TRACE-OUT>
             <RFALSE>)
            ;"exit loop if THEN or period"
            (<EQUAL? .W ,W?THEN ,W?\.>
             <TRACE 4 "[THEN at word " N .WN "]" CR>
             <RETURN>)
            ;"recognize BUT/EXCEPT"
            (<AND <NOT .BUT> <EQUAL? .W ,W?BUT ,W?EXCEPT>>
             <TRACE 4 "[BUT at word " N .WN "]" CR>
             <COND (<OR .ADJ .NOUN>
                    <OBJSPEC-ADJ .SPEC .ADJ>
                    <OBJSPEC-NOUN .SPEC .NOUN>
                    <SET ADJ <SET NOUN <>>>
                    <SET CNT <+ .CNT 1>>)>
             <TRACE 4 "[saving " N .CNT " YSPEC(s)]" CR>
             <NP-YCNT .NP .CNT>
             <SET BUT T>
             <SET SPEC <NP-NSPEC .NP 1>>
             <SET CNT 0>)
            ;"recognize ALL/ANY/ONE"
            (<EQUAL? .W ,W?ALL ,W?EVERY ,W?EVERYTHING ,W?ANY ,W?ONE>
             <COND (<OR .MODE .ADJ .NOUN>
                    <TRACE 4 "[too late for mode change at word " N .WN "]" CR>
                    <COND (<NOT .SILENT?>
                           <TELL "You can't use \"" B .W "\" there." CR>)>
                    <TRACE-OUT>
                    <RFALSE>)>
             <SET MODE
                  <COND (<EQUAL? .W ,W?ALL ,W?EVERY ,W?EVERYTHING> ,MCM-ALL)
                        (ELSE ,MCM-ANY)>>
             <TRACE 4 "[mode change at word " N .WN ", now mode=" N .MODE "]" CR>
             <SET SPEC-WN .WN>)
            ;"match adjectives, keeping only the first"
            (<VERSION?
                (ZIP <SET VAL <WORD? .W ADJECTIVE>>)
                (ELSE <CHKWORD? <SET VAL .W> ,PS?ADJECTIVE>)>
             <TRACE 4 "[adjective '" B .W "' at word " N .WN "]" CR>
             ;"if we already have a noun, this must start a new noun phrase"
             <COND (.NOUN
                    <TRACE 4 "[terminating]" CR>
                    <RETURN>)>
             <SET SPEC-WN .WN>
             <COND
                 ;"if W can also be a noun, treat it as such if
                   it isn't followed by an adj or noun"
                 (<AND <CHKWORD? .W ,PS?OBJECT>         ;"word can be a noun"
                       <OR ;"word is at end of line"
                           <==? .WN ,P-LEN>
                           ;"next word is not adj/noun"
                           <BIND ((NW <GETWORD? <+ .WN 1>>))
                               <NOT <OR <CHKWORD? .NW ,PS?ADJECTIVE>
                                        <CHKWORD? .NW ,PS?OBJECT>>>>>>
                  <TRACE 4 "[treating it as a noun]" CR>
                  <SET NOUN .W>)
                 (<==? .CNT ,P-MAX-OBJSPECS>
                  <TRACE 4 "[already have " N .CNT " specs]" CR>
                  <COND (<NOT .SILENT?>
                         <TELL "That phrase mentions too many objects." CR>)>
                  <TRACE-OUT>
                  <RFALSE>)
                 (<NOT .ADJ>
                  <SET ADJ .VAL>)
                 (ELSE
                  <TRACE 4 "[ignoring it]" CR>)>)
            ;"match nouns, exiting the loop if we already found one"
            (<CHKWORD? .W ,PS?OBJECT>
             <TRACE 4 "[noun '" B .W "' at word " N .WN "]" CR>
             <COND (.NOUN
                    <TRACE 4 "[terminating]" CR>
                    <RETURN>)
                   (<==? .CNT ,P-MAX-OBJSPECS>
                    <TRACE 4 "[already have " N .CNT " specs]" CR>
                    <COND (<NOT .SILENT?>
                           <TELL "That phrase mentions too many objects." CR>)>
                    <TRACE-OUT>
                    <RFALSE>)
                   (ELSE
                    <SET NOUN .W>
                    <SET SPEC-WN .WN>)>)
            ;"recognize AND/comma"
            (<EQUAL? .W ,W?AND ,W?COMMA>
             <TRACE 4 "[AND at word " N .WN "]" CR>
             <COND (<OR .ADJ .NOUN>
                    <OBJSPEC-ADJ .SPEC .ADJ>
                    <OBJSPEC-NOUN .SPEC .NOUN>
                    <SET ADJ <SET NOUN <>>>
                    <SET SPEC <REST .SPEC ,P-OBJSPEC-SIZE>>
                    <SET CNT <+ .CNT 1>>
                    <TRACE 4 "[now have " N .CNT " spec(s)]" CR>)>)
            ;"recognize OF"
            (<AND <EQUAL? .W ,W?OF>
                  <L? .WN ,P-LEN>
                  <STARTS-NOUN-PHRASE? <GETWORD? <+ .WN 1>>>>
             ;"This is a hack to deal with object names consisting of multiple NPs
               joined by OF. When we see OF before a word that could start a new
               noun phrase, we forget the current noun, so SMALL PIECE OF TASTY PIE
               parses as SMALL TASTY PIE (which in turn parses as SMALL PIE)."
             <TRACE 4 "[OF at word " N .WN ", clearing noun]" CR>
             <SET NOUN <>>)
            ;"skip buzzwords"
            (<CHKWORD? .W ,PS?BUZZ-WORD>
             <TRACE 4 "[skip buzzword at word " N .WN "]" CR>
             <SET SPEC-WN .WN>)
            ;"exit loop if we found any other word type"
            (ELSE
             <TRACE 4 "[bail over type at word " N .WN "]" CR>
             <RETURN>)>
        <SET WN <+ .WN 1>>>
    ;"store final adj/noun pair"
    <COND (<OR .ADJ .NOUN>
           <OBJSPEC-ADJ .SPEC .ADJ>
           <OBJSPEC-NOUN .SPEC .NOUN>
           <SET CNT <+ .CNT 1>>
           <TRACE 4 "[finally have " N .CNT " spec(s)]" CR>)>
    ;"store phrase count and mode"
    <COND (.BUT <NP-NCNT .NP .CNT>) (ELSE <NP-YCNT .NP .CNT>)>
    <NP-MODE .NP .MODE>
    <TRACE 2 "[noun phrase parsed: " NOUN-PHRASE .NP "]" CR>
    <TRACE-OUT>
    <+ .SPEC-WN 1>>

<ROUTINE ALL-INCLUDES? (OBJ)
    <NOT <OR <FSET? .OBJ ,INVISIBLE>
             <AND <VERB? TAKE> <HELD? .OBJ>>                ;"Changed line"
             <AND <VERB? DROP> <NOT <HELD? .OBJ>>>          ;"Changed line"
             <=? .OBJ ,WINNER>
             <AND <VERB? TAKE DROP>
                  <NOT <OR <FSET? .OBJ ,TAKEBIT>
                       <FSET? .OBJ ,TRYTAKEBIT>>>>>>>

<ROUTINE WHICH-DO-YOU-MEAN (TBL)
    <TELL ,MESSAGE-048 CR CR>                              ;"Changed line. Works because only scrolls needs to be specified."
    <TELL "Which do you mean, ">
    <LIST-OBJECTS .TBL <> <+ ,L-PRSTABLE ,L-THE ,L-OR>>
    <TELL "?" CR>>

<ROUTINE READLINE ("OPT" PROMPT?)
    <COND (.PROMPT? <TELL CR ,SYSMESSAGE-002>)>         ;"Changed line"
    <SETG READBUF ,KBD-READBUF>
    <SETG LEXBUF ,KBD-LEXBUF>
    <PUTB ,READBUF 0 <- ,READBUF-SIZE 2>>
    ;"The read buffer has a slightly different format on V3."
    <VERSION? (ZIP)
              (ELSE
                <PUTB ,READBUF 1 0>
                <UPDATE-STATUS-LINE>)>
    <DO-READ ,READBUF ,LEXBUF>
    <RTRUE>>
        
;"Writes the location name, score, and turn count in the status line.

Uses:
HERE
HERE-LIT
SCORE
MOVES"
<ROUTINE UPDATE-STATUS-LINE ("AUX" WIDTH)
    <SCREEN 1>
    <HLIGHT ,H-INVERSE>
    <FAKE-ERASE>
    <TELL !\ >
    <COND (,HERE-LIT <TELL D ,HERE>)
          (ELSE <TELL %,DARKNESS-STATUS-TEXT>)>
    <SET WIDTH <LOWCORE SCRH>>
    <COND (<NOT ,GAME_VERSION_CLASSIC>          ;"Changed line"
        <CURSET 1 <- .WIDTH 22>>
        <TELL "Score: ">
        <PRINTN ,SCORE>
    )>
    <CURSET 1 <- .WIDTH 10>>
    <TELL "Turns: ">                            ;"Changed line"
    <PRINTN ,MOVES>
    <SCREEN 0>
    <HLIGHT ,H-NORMAL>>

;"Prints a message and ends the game, prompting the player to restart,
(possibly) undo, restore, or quit.

Args:
TEXT: The message to print before the 'game is over' banner.

Returns:
True if RESURRECT? indicated that the game should resume.
Otherwise, never returns."
<ROUTINE JIGS-UP (TEXT "AUX" W)
    <SETG P-CONT 0>
    <TELL .TEXT CR>                                         ;"Changed line"
    <COND (<NOT <=? .TEXT "">> <TELL CR>)>                  ;"Changed line"
    <COND (,GAME_VERSION_CLASSIC                            ;"Changed line"
        <TELL ,SYSMESSAGE-017>                              ;"Changed line"
    )                                                       ;"Changed line"
    (T                                                      ;"Changed line"
        <TELL "You hace scored ">                           ;"Changed line"
        <PRINTN ,SCORE>                                     ;"Changed line"
        <TELL  " out of 100 points in ">                    ;"Changed line"
    )>                                                      ;"Changed line"
    <PRINTN ,MOVES>                                         ;"Changed line"
    <TELL ,SYSMESSAGE-018>                                  ;"Changed line"
    <COND (<NOT <=? ,MOVES 1>> <TELL ,SYSMESSAGE-019>)>     ;"Changed line"
    <TELL ,SYSMESSAGE-020 CR CR>                            ;"Changed line"
    <PRINT-GAME-OVER>
    <CRLF>
    <COND (<RESURRECT?> <RTRUE>)>
    <REPEAT PROMPT ()
        <IFFLAG (UNDO
                <PRINTI "Would you like to RESTART, UNDO, RESTORE, or QUIT? > ">)
                (ELSE
                <PRINTI "Would you like to RESTART, RESTORE or QUIT? > ">)>
        <REPEAT ()
            <READLINE>
            <SET W <AND <GETB ,LEXBUF 1> <GET ,LEXBUF 1>>>
            <COND (<EQUAL? .W ,W?RESTART>
                <RESTART>)
                (<EQUAL? .W ,W?RESTORE>
                <RESTORE>  ;"only returns on failure"
                <TELL "Restore failed." CR>
                <AGAIN .PROMPT>)
                (<EQUAL? .W ,W?QUIT>
                <TELL CR ,SYSMESSAGE-014 CR>
                <QUIT>)
                (<EQUAL? .W ,W?UNDO>
                <V-UNDO>   ;"only returns on failure"
                <TELL "Undo failed." CR>
                <AGAIN .PROMPT>)
                (T
                <IFFLAG (UNDO
                            <TELL CR "(Please type RESTART, UNDO, RESTORE or QUIT) >">)
                        (ELSE
                            <TELL CR "(Please type RESTART, RESTORE or QUIT) > ">)>)>>>>

;"Prints a message explaining that the game is over or the player has died.
  This is called after JIGS-UP has already printed the message passed in to
  describe the specific circumstances, so usually this should print a generic
  message appropriate for the game's theme."
<ROUTINE PRINT-GAME-OVER ()
    <TELL ,SYSMESSAGE-013 CR>>                          ;"Changed line"

;"Action handler for the player."
<ROUTINE PLAYER-F ()
    <COND (<N==? ,PLAYER ,PRSO>
           <RFALSE>)
          (<VERB? EXAMINE>
           <PRINTR "You look like you're up for an adventure.">)>
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>    ;"Changed lines --->"
        <COND (,21-WORTA-ME-FLAG
            <TELL ,MESSAGE-110 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-109 CR>
            <MOVE ,48-WART ,WINNER>
            <SETG ,21-WORTA-ME-FLAG T>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
        )>
    )>
>
          
; "REDEFINE = FALSE"
<SET REDEFINE <>>
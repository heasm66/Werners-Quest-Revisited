;"============================================================================="
;"
	Hints (InvisiClue-style)
    ------------------------
	Skeleton file to add a InvisiClue-style hintsystem to your story. The original 
	file (hint.zil) is from the project 'hitchhiker-invclues-r31' (Solid Gold-version) 
	at https://github.com/historicalsource/hitchhikersguide-gold/blob/master/hints.zil
	To make it work I only needed to add the code i the 'Added stuff'-section.
	To make your own hints you need to add text in the <GLOBAL HINT>-structure.
"
;"============================================================================="

;"============================================================================="
;"Added stuff"
;"============================================================================="

<CONSTANT S-TEXT 0>
<CONSTANT S-WINDOW 1>

<CONSTANT D-TABLE-ON 3>
<CONSTANT D-TABLE-OFF -3>

<ROUTINE PRINT-SPACES (CNT)
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<PRINTC 32>)>>>

<SYNTAX HELP = V-HINTS>
<SYNTAX HELP OFF OBJECT (FIND KLUDGEBIT) = V-HINTS-NO>
<VERB-SYNONYM HELP HINT HINTS CLUE CLUES VISICLUES INVISICLUES>

;"======================================================================"
;"Here starts the orginal hints.zil from HITCHHIKERS GUIDE TO THE GALAXY
  There is some small changes to the routines V-HINTS and V-HINTS-NO."
;"======================================================================"

<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINT-WARNING <>>

<GLOBAL HINTS-OFF <>>

<ROUTINE V-HINTS-NO ()
	<COND (,HINTS-OFF
	       <TELL "I don't understand what you mean." CR>)
	      (T
	       <SETG HINTS-OFF T>
	       <TELL "[Hints have been disallowed for this session.]" CR>)>
	<RFATAL>>

<ROUTINE V-HINTS ("AUX" CHR MAXC (C <>) Q)
	<COND (,HINTS-OFF
	       <PERFORM ,V?HINTS-NO>
	       <RFATAL>)
	      (<NOT ,HINT-WARNING>
	       <SETG HINT-WARNING T>
	       <TELL
"[Warning: It is recognized that the temptation for help may at times be so
exceedingly strong that you might fetch hints prematurely. Therefore, you may
at any time during the story type HINTS OFF, and this will disallow the
seeking out of help for the present session of the story. If you still want a
hint now, indicate HINT.]" CR>
	       <RFATAL>)>
       	<SET MAXC <GET ,HINTS 0>>
	<INIT-HINT-SCREEN>
	<CURSET 5 1>
	<PUT-UP-CHAPTERS>
	<SETG CUR-POS <- ,CHAPT-NUM 1>>
	<NEW-CURSOR>
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q> %131>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n> %130>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,CHAPT-NUM .MAXC>
			      <SETG CUR-POS 0>
			      <SETG CHAPT-NUM 1>
			      <SETG QUEST-NUM 1>)
			     (T 
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG CHAPT-NUM <+ ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p> %129>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,CHAPT-NUM 1>
			      <SETG CHAPT-NUM .MAXC>
			      <SETG CUR-POS <- ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>>
			      <SETG CHAPT-NUM <- ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10 %132>
		       <PICK-QUESTION>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>	;"AGAIN does whole routine?")>
	<CLEAR -1>
	<INIT-STATUS-LINE>
	<TELL CR "Back to the story..." CR>
	<RFATAL>>


<ROUTINE PICK-QUESTION ("AUX" CHR MAXQ (Q <>))
	<INIT-HINT-SCREEN <>>
	<LEFT-LINE 3 " RETURN = See hint">
	<RIGHT-LINE 3 "Q = Main menu" %<LENGTH "Q = Main menu">>
	<SET MAXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<CURSET 5 1>
	<PUT-UP-QUESTIONS>
	<SETG CUR-POS <- ,QUEST-NUM 1>>
	<NEW-CURSOR>
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q> %131>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n> %130>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM .MAXQ>
			      <SETG CUR-POS 0>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG QUEST-NUM <+ ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p> %129>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM 1>
			      <SETG QUEST-NUM .MAXQ>
			      <SETG CUR-POS <- ,QUEST-NUM 1>>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>> 
			      <SETG QUEST-NUM <- ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10 %132>
		       <DISPLAY-HINT>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>)>>

;"zeroth (first) element is 5"
<GLOBAL LINE-TABLE
	<PTABLE
	  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22>>

;"zeroth (first) element is 4"
<GLOBAL COLUMN-TABLE
	<PTABLE
	  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4>>

<GLOBAL CUR-POS 0>	;"determines where to place the highlight cursor
			  Can go up to 17 Questions"

<GLOBAL QUEST-NUM 1>	;"shows in HINT-TBL ltable which QUESTION it's on"

<GLOBAL CHAPT-NUM 1>	;"shows in HINT-TBL ltable which CHAPTER it's on"

<ROUTINE ERASE-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL " ">	;"erase previous highlight cursor">

;"go back 2 spaces from question text, print cursor and flash is between
the cursor and text"

<ROUTINE NEW-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL ">">	;"print the new cursor">

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	<HLIGHT ,H-INVERSE>
	<PRINT-SPACES <LOWCORE SCRH>>
	<HLIGHT ,H-NORMAL>>

;"cnt (3) is where in table answers begin. (2) in table is # of hints-seen"
<ROUTINE DISPLAY-HINT ("AUX" H MX MXC (CNT 2) CHR (FLG T) N)
	;<SPLIT 0>
	<CLEAR -1>
	<SPLIT 3>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<CURSET 3 1>
	<INVERSE-LINE>
	<LEFT-LINE 3 " RETURN = See hint">
	<RIGHT-LINE 3 "Q = See hint menu" %<LENGTH "Q = See hint menu">>
	<CURSET 2 1>
	<INVERSE-LINE>
	<HLIGHT ,H-BOLD>
	<SET H <GET <GET ,HINTS ,CHAPT-NUM> <+ ,QUEST-NUM 1>>>
	<CENTER-LINE 2 <GET .H 2>>
	<HLIGHT ,H-NORMAL>
	<SET MX <GET .H 0>>
	<SET MXC <GET ,HINTS 0>> 
	<SCREEN ,S-TEXT>
	<CRLF>
	<REPEAT ()
	       <COND (<EQUAL? .CNT <GET .H 1>>
		      <RETURN>)
		     (T
		      <TELL <GET .H .CNT> CR ;CR>
		      <SET CNT <+ .CNT 1>>)>>
	<REPEAT ()
	      <COND (<AND .FLG <G? .CNT .MX>>
		     <SET FLG <>>
		     <TELL "[That's all.]" CR>)
		    (.FLG
		     <SET N <+ <- .MX .CNT> 1>> ;"added +1 - Jeff"
		     <COND (<NOT <EQUAL? ,CHAPT-NUM .MXC>> ;"add cond-GARY" 
		            <TELL N .N " hint">
		            <COND (<NOT <EQUAL? .N 1>>
			           <TELL "s">)>
		            <TELL " left " ;CR ;CR>)> ;"removed CRs - GARY"
		     <TELL "-> ">
		     <SET FLG <>>)>
	      <SET CHR <INPUT 1>>
	      <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q> %131>
		     <PUT .H 1 .CNT>
		     <RETURN>)
		    (<EQUAL? .CHR 13 10>
		     <COND (<NOT <G? .CNT .MX>>
			    <SET FLG T>	;".cnt starts as 3" 
			    <TELL <GET .H .CNT>>
			    ;<CRLF> ;"extra CRLF removed by GARY"
			    <CRLF>
			    <SET CNT <+ .CNT 1>>
			    <COND (<G? .CNT .MX>
				   <SET FLG <>>
				   <TELL "[That's all.]" CR>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS ("AUX" (ST 1) MXQ MXL)
	<SET MXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXQ>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
		<TELL " " <GET <GET <GET ,HINTS ,CHAPT-NUM> <+ .ST 1>> 2>>
		<SET ST <+ .ST 1>>>>

<ROUTINE PUT-UP-CHAPTERS ("AUX" (ST 1) MXC MXL)
	<SET MXC <GET ,HINTS 0>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXC>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
		<TELL " " <GET <GET ,HINTS .ST> 1>>
		<SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T))
	;<SPLIT 0>
	<CLEAR -1>
	<SPLIT <- <GETB 0 32> 1>>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CURSET 2 1>
	<INVERSE-LINE>
	<CURSET 3 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<LEFT-LINE 2 " N = Next">
	<RIGHT-LINE 2 "P = Previous" %<LENGTH "P = Previous">>
	<COND (<T? .THIRD>
	      <LEFT-LINE 3 " RETURN = See topics">
	      <RIGHT-LINE 3 "Q = Resume story" %<LENGTH "Q = Resume story">>)>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT ,D-TABLE-ON ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT ,D-TABLE-OFF>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <+ </ <- <LOWCORE SCRH> .LEN> 2> 1>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	<CURSET .LN 1>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT 3 ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT -3>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <- <LOWCORE SCRH> .LEN>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<GLOBAL DIROUT-TBL
	<TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 >>

;"longest hint topic can be 17 questions long, longest question 36 characters"

<GLOBAL HINTS
   	<PLTABLE
    ;"Table of chapters."
      	<PLTABLE 
    	"Junction Area"
	 		<LTABLE 3
	  		"Oversized, chrome spoon?"
			  	"You'll need it."
	  			"But Thing-Fish won't let you take it."
				"Don't bother with it. It will magically appear when you need it."
				>
         	<LTABLE 3
	  		"Cloak room."
      	  		"It's a place to hang your cloak."
				"Others have done it."
				"Maybe there's some loose change in the pockets?"
				"EXAMINE CLOAKS.">
         	<LTABLE 3
	  		"What to buy in the gift shop?"
      	  		"You got limited means. Be carefull."
				"Don't buy anything before you've seen Peter Austin."
				"BUY ADVENTURE KIT (for coin)."
				"Don't read more hints before you have used the adventure kit."
				"Ok, now you have a wheelbarrow of money. What to buy?"
				"Have you ever played INFIDEL?"
				"A wooden beam can really be useful."
				"BUY WOODEN BEAM.">
	 		<LTABLE 3
    		"In the library."
				"Read the leaflet."
	  			"Really, it is a hint."
				"Also, there's a hidden exit in this room."
	  			"Have you tried moving the bookcase looking for the hidden exits?"
	  			"Maybe you just should examine it."
				"EXAMINE BOOKCASE. PRESS TINY BUTTON.">
         	<LTABLE 3
	  		"Beyond the bookcase."
			  	"Pick up the magnifying glass."
      	  		"Not much more here to do before you got the password.">
         	<LTABLE 3
	  		"The tied wizard."
			  	"Maybe just free him is the answer?"
      	  		"UNTIE ROPE."
				"The rope is usefull."
				"It's of the self-knotting type."
				"Just throw it and it will tie itself to things if something suitable is in range.">>
      	<PLTABLE
       	"Muffin Utility Research Kitchen (MURK)"
         	<LTABLE 3
	  		"The snoring gnome."
	  			"He's sleeping."
	  			"Try waking him."
				"WAKE GNOME."
				"Remember what he tells you. It'll come to use later on.">
         	<LTABLE 3
	  		"The muffin man."
	  			"He's making muffins."
	  			"Listen to what he says."
				"He tells you the answer to the riddle."
				"Also be sure to take the green rosetta he offers.">>
      	<PLTABLE
       	"Riddle Room"
         	<LTABLE 3
	  		"Riddle Room"
			  	"The answer to the riddle is around here somewhere."
      	  		"Just listen to the muffin man."
				"SAY CUPCAKE.">
			<LTABLE 3
			"Tea Room"
				"Do you know about Alice?"
				"Here's a cake."
				"Examine it."
				"If you have the magnifying glass you should be able to read the icing."
				"Ok... Maybe you shouldn't eat THAT!">>
      	<PLTABLE
       	"Grandfather Clock and Beyond"
         	<LTABLE 3
	  		"Grandfather clock."
			  	"Read the description."
      	  		"You can enter the clock."
				"Try pressing the button to see what happens.">
			<LTABLE 3
			"At Level 9."
				"Pete Austin is a prominent author of many text adventures."
				"He's always looking for ways to promote the next one."
				"Try dressing up as an adventurer."
				"OPEN KIT. GET SWORD. GET LANTERN. GET BOTTLE.">>
		<PLTABLE
		"Around Narrow Ledge"
			<LTABLE 3
	  		"Soft room."
				"Everything here is soft."
				"Especially the rug."
				"Try searching through the rug."
				"SEARCH RUG.">
			<LTABLE 3
			"Cerise door room."
				"He won't let you pass whitout you showing some kindness."
				"Maybe a cake..."
				"GIVE CAKE TO MIDGET."
				"(Maybe not so nice...)">
			<LTABLE 3
			"Jell-O room"
				"It's Jell-O."
				"You can look for something hidden in the jell-o."
				"The skeleton is not useful."
				"But you'll need the battery that the skeleton is holding."
				"SEARCH JELL-O. EXAMINE SKELETON. GET BATTERY.">
			<LTABLE 3
			"Small room."
				"Don't touch the lever!"
				"Read description carefully."
				"Can you find something that is NOT forbidden?"
				"PULL LEVER.">
			<LTABLE 3
			"Can I reach the other ledge across the ravine?"
				"Yes."
				"You need the rope."
				"You also need the wooden beam."
				"Have you noticed the hole in the ceiling?"
				"It's the same hole as up in the small chamber."
				"Drop beam in small chamber and then throw rope in middle of narrow ledge."
				"You'll need the small black device to get back.">
				>
		<PLTABLE
		"Canyon Area"
			<LTABLE 3
			"Help! I can't return up the chute."
				"It's a one way ride."
				"You have to find another way back.">
			<LTABLE 3
			"Small black device. What is it?"
				"Have you read Hitchhikers Guide to the Galaxy?"
				"It's a type of teleportation device."
				"Just press the button and your out of here."
				"But wait. It only works one time."
				"There's another way out of here. Save the device for a later time.">
			<LTABLE 3
			"Furs in the cave?"
				"Just examine them."
				"Hidden in the furs there's a wormhole.">
			<LTABLE 3
			"\"XYZZY\" room."
				"This is obvious."
				"Just do as you would do in 'Adventure'"
				"Just say the magic word."
				"SAY XYZZY.">
			<LTABLE 3
			"Small brick building."
				"Another 'Adventure' reference."
				"Examine the room carefully."
				"Remember that it's all stage-craft."
				"LOOK UP."
				"If you don't have the rope you're out of luck!"
				"THROW ROPE.">
			<LTABLE 3
			"Help! I have escaped the canyon but are missing the rope."
				"No problem. The rope is around here somewhere."
				"The rope is in the lost & found department.">>
		<PLTABLE
		"Other Side of Ravine"
			<LTABLE 3
			"Help! Kebaberus won't let me pass."
				"You'll have to passify the dog."
				"Or to be more correct. You'll need to irritate the dog more."
				"Kebaberus like to look tough."
				"How tough do you look with a grenn rosette?"
				"TIE ROSETTE TO KEBABERUS.">
			<LTABLE 3
			"Angel in oddly-angled room?"
				"He sure is an odd angel."
				"Examine him."
				"It's Zaphod. He likes to party."
				"Have you examined the rope?"
				"Hmm. It's made of hemp."
				"GIVE ROPE TO ZAPHOD. TAKE RADIO.">
			<LTABLE 3
			"Werner Dungeon Bank"
				"It works just like the bank in Zork III."
				"Unfortunaly there's very few people that understand how the bank in Zork works."
				"Just go north and enter the curtain of light."
				"In featureless room you go south to enter the curtain of light."
				"You'll need the small blck device to leave the bank.">
			<LTABLE 3
			"Mr Lamberth."
				"You'll need to distract him to get the cushion."
				"Did you listen to the gnome?"
				"LAMBERTH, MATRESS. TAKE CUSHION.">>
	    <PLTABLE
       	"End Game"
			<LTABLE 3
			"Ok. What do I do now?"
				"Have you visited the library?"
				"There's a secret exit in the library."
				"AND read the leaflet."
				"You need the battery, the radio, the velvet cushion and the satin cushion."
				"INSERT BATTERY. TURN ON RADIO. SLEEP."
				"Remeber the password.">
			<LTABLE 3
			"Rance the Dungeonkeeper."
				"Just tell him the password."
				"SAY CROOK TO RANCE.">>
		<PLTABLE
		"Miscellaneous"
			<LTABLE 3
			"How all the points are scored"
				"This section should only be used as a last resort, or for your own interest after you've completed the game."
				"SCORE  ACTION"
				"   10  Free the wizard"
				"   10  Getting the money from Peter Austin"
				"   10  Finding the velvet cushion"
				"   10  Finding the battery"
				"   10  Escaping the small brick building without using the black device"
				"   10  Crossing the ravine"
				"   10  Giving the hemp rope to Zaphod"
				"   10  Make Mr Lamberth wear a bucket"
				"   10  Sleeping with all accessories"
				"   10  Telling Rance the password"
				"  100   TOTAL POINTS">
			<LTABLE 3
			"Frank Zappa and other references"
				"Here's a list of Frank Zappa and other references in the game."
				"Thing-Fish: The unforgetable Thing-Fish (Ike Willis) from the 1984 Zappa album with the same name."
				"The Over-sized Chrome Spoon: Is from the song 'Muffin Man' on the 1975 Zappa & Captain Beefheart album 'Bongo Fury'."
				"Rance the Dungeonkeeper: Rance Mohammitz (Theodore Bikel) from the 1971 Zappa movie '200 Motels'."
				"The poem on the leaflet is from the song 'Absolutely Free' from the 1966 album with the same name."
				"Peter Austin was a prominent author av text adventures during the 80s (Level 9)."
				"The wooden beam is of course from the Infocom game 'Infidel'."
				"Various references to different adventure games. Mostly Zork I-III, The Hitchhikers Guide to the Galaxy, Sherlock Holmes and Adventure.">
			<LTABLE 3
			"Have you tried..."
				"Eating the cake."
				"Reading the poster.">>
>>

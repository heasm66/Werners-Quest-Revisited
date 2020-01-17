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
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
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
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
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
		      (<EQUAL? .CHR 13 10>
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
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM .MAXQ>
			      <SETG CUR-POS 0>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG QUEST-NUM <+ ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM 1>
			      <SETG QUEST-NUM .MAXQ>
			      <SETG CUR-POS <- ,QUEST-NUM 1>>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>> 
			      <SETG QUEST-NUM <- ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10>
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
	      <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
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
    	"Round Room"
	 		<LTABLE 3
	  		"Is the printout important?"
	  			"Yes.">
         	<LTABLE 3
	  		"How do I get up the escalator?"
      	  		"Have you tried turning the escalator off?"
				"You can't. The Escalator is only going down.">
	 		<LTABLE 3
    		"How do I open the stone doors?"
	  			"Have you examined the rock?"
	  			"Use the key."
	  			"Maybe the spoon is multi-purpose?"
				"INSERT SPOON IN SLOT.">>
      	<PLTABLE
       	"The Great Hall"
         	<LTABLE 3
	  		"What about the rails?"
	  			"Maybe something use the rails for transportation?"
	  			"Locate the plastic gnome.">
	 		<LTABLE 3
	  		"What about the plastic gnome?"
	  			"Have you tried moving it around?"
	  			"It won't budge you have to find some other way to move it."
				"It moves by pressing one of the numbered buttons up on the vertex structure.">
	 		<LTABLE 3
	  		"Why am I standing on one leg atop the vertex structure?"
	  			"Have you noticed the floating buttons?"
				"Have you tried pushing them?"
	  			"You have to examine the great hall to see if something changed."
				"By pressing the buttons you can move the plastic gnome to eight different locations.">
	 		<LTABLE 3
	  		"How do I open the door in the toadstool?"
	  			"It's no ordinary door."
	  			"It opens by some sort of magic."
	  			"Try moving the plastic gnome here."
	  			"PRESS 5 (of the floating buttons).">
	 		<LTABLE 3
	  		"What's the point inside the toadstool?"
	  			"Is there something of value here?"
	  			"Have you examined everything?"
	  			"SEARCH FLOOR.">
	 		<LTABLE 3
	  		"What do I do with the toad?"
	  			"You need a ladder to reach it."
	  			"Can it be some sort of magic?"
	  			"What do you usually do with toads in fairy tales?"
	  			"Try kissing it."
				"You don't need the toad for anything in this story.">>
      	<PLTABLE
       	"Around the Old Farm"
         	<LTABLE 3
	  		"How do I get out of the well?"
				"Have you tried climbing?"
				"It seems like you are stuck."
				"Just wait. Eventually Rance will come and rescue you (don't forget the coin).">
			<LTABLE 3
	  		"How do I enter the old farm"
				"It's the control center for the game. Rance will not let YOU in."
				"Maybe you can trick him?"
				"If you looked like Thing-Fish, maybe?"
				"Wear paper bag before entering. ">
			<LTABLE 3
			"What do I do in the toolshed?"
				"Ponder your sins?"
				"Pick up the saw and the ladder.">>
		<PLTABLE
		"Plain Cute"
			<LTABLE 3
			"Are the bunnies important?"
				"No.">
			<LTABLE 3
			"How do I get the paper bag?"
				"Try taking the bag from the person."
				"Hmm. He won't let you. Maybe violence is the answer?"
				"HIT PERSON WITH SPOON">
			<LTABLE 3
			"Will John Taylor give me an Duran Duran album?"
				"He certinaly won't let you board the boat."
				"Have you tried greeting him?"
				"HELLO TAYLOR. (Hello Sailor, get it?)">>
	    <PLTABLE
       	"Bedroom Area"
         	<LTABLE 3
			"How do I help the old man so he can get some sleep."
				"The sound is obivously disturbing him."
				"Have you tried closing the door?"
				"That's not enough. You also have to do something else.">
			<LTABLE 3
			"What do I do about Bruce Springsteen"
				"Listen to the Boss."
				"Do you have something to cover Bruce with?"
				"COVER BRUCE WITH BLANKET">
			<LTABLE 3
			"Is there anything to do in the living room?"
				"Yes."
				"You can always watch some TV."
				"You can even change the channel by pressing the buttons."
				"Have you seen Poltergeist?"
				"TOUCH SCREEN">>
		<PLTABLE
		"Bar Area"
			<LTABLE 3
			"What to do in the bar?"
				"Mingle?"
				"Chat?"
				"Buy alcohol?"
				"BUY DRINK">
			<LTABLE 3
			"Anything else you can do here?"
				"No.">>
		<PLTABLE
		"Museum"
         	<LTABLE 3
			"How do I take the philatelist's stone?"
				"Have you tried taking it wear the fully proteced body armour?"
				"You can't take the stone from here. The burglary system is to good."
				"Have you noticed the ceiling."
				"See hint about the small room for more information.">
			<LTABLE 3
			"How do I solve the royal puzzle?"
				"You have to push the walls."
				"You have to push the walls in the right order."
				"Maybe the game mode is to hard for you?"
				"Try the puzzle in demo mode instead."
				"PRESS DEMO BUTTON">
			<LTABLE 3
			"Help! I'm on the pedestal and can't leave."
				"Climb back up?"
				"You need some sort of transportation out of here."
				"If you not been to the ravine area you are stuck."
				"You need the black device."
				"PRESS RED BUTTON">>
		<PLTABLE
		"Foggy Room Area"
			<LTABLE 3
			"What's the meaning of the foggy room?"
				"Feel your way around."
				"It's just a room. Nothing to see here.">
			<LTABLE 3
			"What do I do in the elevator?"
				"Listen to the music?"
				"An elevator is a device that transport you vertically."
				"Pressing the different buttons take you to different floors.">
			<LTABLE 3
			"What do I do in the small room?"
				"Have you noticed the floor?"
				"I you only had the right tool..."
				"SAW FLOOR WITH SAW">
			<LTABLE 3
			"What's to do in the volcano chamber?"
				"Take the book?"
				"Further your education by reading it?"
				"GET BOOK. READ BOOK. GET STAMP.">
			<LTABLE 3
			"Is the volcano important?"
				"No. It's just scenary.">>
		<PLTABLE
		"Ravine / Danish Bakery"
			<LTABLE 3
			"What do I do in the ravine area?"
				"Remember this area from Werner's Quest II?"
				"In WQII there was a usefull thing in the cave. Go see if it's still there."
				"N. E. GET DEVICE.">
			<LTABLE 3
			"How do I escape the ravine area?"
				"You can use the device."
				"Using the device is pointless. The goal is to escape this area with the device intact."
				"Just wait around. Eventually Rance will discover you and take you back.">
			<LTABLE 3
			"What do I do in the bakery?"
				"Preben & Preben seems to have a hobby."
				"Besides baking."
				"If you don't have a drink then your out of luck and stuck."
				"GIVE DRINK TO PREBEN">>
		<PLTABLE
		"End Game"
			<LTABLE 3
			"How do I solve the end game?"
				"Don't overcomplicate things."
				"Have you seen the lever?"
				"PULL LEVER">>
		<PLTABLE
		"Miscellaneous"
			<LTABLE 3
			"How all the points are scored"
				"This section should only be used as a last resort, or for your own interest after you've completed the game."
				"SCORE  ACTION"
				"   10  Inserting spoon in slot"
				"   10  Taking the ZX Spectrum"
				"   10  Taking the paper bag"
				"   10  Taking the Duran Duran album"
				"   10  Taking the basketball"
				"   10  Taking the danish pastry"
				"   10  Taking the salami sausage"
				"   10  Taking the yellow 3 skilling banco stamp"
				"   10  Waking the old man"
				"   10  Pull the lever"
				"  100   TOTAL POINTS">
			<LTABLE 3
			"Where are all the 'treasures' located"
				"This section should only be used as a last resort, or for your own interest after you've completed the game."
				"The ZX Spectrum - Hidden in the rubble on the floor inside the toadstool."
				"The paper bag - Thing-Fish have it but you need to beat him unconscious before getting it."
				"The Duran Duran album - On the yacht. You need to create chaos on the boat to get it."
				"The basketball - Rance has it inside the old farm. He will only give it to you if he thinks you're Thing-Fish."
				"The danish pastry - In the danish bakery. Preben & Preben will give it to you in exchange for a drink."
				"The salami sausage - In the Royal Puzzle."
				"The yellow 3 skilling banco stamp - You find a green one in the cerise book. You have to change the color of it with the philatelist's stone.">
			<LTABLE 3
			"Frank Zappa and other references"
				"Here's a complete list Frank Zappa and other references in the game."
				"Thing-Fish: The unforgetable Thing-Fish (Ike Willis) from the 1984 Zappa album with the same name."
				"Rance the Dungeonkeeper: Rance Mohammitz (Theodore Bikel) from the 1971 Zappa movie '200 Motels'."
				"The Over-sized Chrome Spoon: Is from the song 'Muffin Man' on the 1975 Zappa & Captain Beefheart album 'Bongo Fury'."
				"The wizard that at times appears to ask existential questions is from the song 'Call Any Vegetable' from the 1972 Mothers of Invention album 'Just Another Band from L.A.'."
				"Preben & Preben was a standing sketch part in swedish televisions big saturday night entertainment block during the 80s."
				"Bruce Springsteen is a rock artist."
				"Duran Duran was a pop band."
				"Various references to different Infocom games. Mostly Zork I-III, Enchanter and The Hitchhikers Guide to the Galaxy.">>
>>
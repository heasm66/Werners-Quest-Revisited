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
    	"Above Ground"
	 		<LTABLE 3
	  		"How do I enter the house?"
			  	"Do as the sign says."
	  			"Have you tried knocking?"
				"KNOCK ON DOOR."
				>
         	<LTABLE 3
	  		"Is the red/white cloth with a clip important?"
      	  		"Maybe you need a map?"
				"Have you ever tried orienteering?"
				"Maybe there is a luckless one around here somewhere with a map."
				"No, it's not important. You can safely ignore it.">
         	<LTABLE 3
	  		"What about the skeleton?"
      	  		"Maybe the skeleton have a map?"
				"Have you tried examining it?"
				"It's just a joke. You don't need the map and can let Gandalf carry it for now."
				"But make sure Ford Prefect gives you a babel fish. You'll need it later to understand a foreign language.">
	 		<LTABLE 3
    		"Up a tree."
				"Really?"
	  			"What do you think you should do?"
	  			"Plunder the birds nest."
	  			"EXAMINE NEST. GET SPOON AND COIN.">
         	<LTABLE 3
	  		"The button in the house doesn't do anything?"
      	  		"It maybe control things in another room?"
				"Try entering the dungeon without pushing it first."
				"It's the lightswitch for the dungeon.">
         	<LTABLE 3
	  		"The troll won't let me enter the dungeon!"
      	  		"You need a ticket to show to the troll."
				"The troll doesn't sell tickets but you can buy them in the vending machine."
				"To buy something you need money..."
				"INSERT COIN IN MACHINE. GET TICKET. SHOW TICKET TO TROLL.">>
      	<PLTABLE
       	"Around the Dungeon"
         	<LTABLE 3
	  		"Help! I'm lost in a maze."
	  			"Try mapping it the usual way."
	  			"Have you read the brochure the troll gave you?"
				"You'll need a phone."
				"CALL 083214693"
				"Be sure to pick up the statuette before leaving the maze.">
	 		<LTABLE 3
	  		"Rambo's Lair"
	  			"Talk to the man!"
	  			"Have you noticed that he is a bit of a rasist?"
				"Try wearing the china man's disguise."
				"He's shooting! Duck for cover."
				"If you haven't been to the dragon's lair you should stop reading here."
				"Rambo is usefull if you're followed by a dragon."
				"If you wear the disguise and duck (twice), Rambo will miss you and shoot the dragon instead.">
	 		<LTABLE 3
	  		"Toilet"
	  			"What are toilets usually for?"
				"Do your thing and be done with it."
	  			"The toilet is of no use in this game.">
	 		<LTABLE 3
	  		"Dungeonmaster's Office"
	  			"The dungeonmaster isn't in at the moment."
	  			"That gives you an opportunity to search through his things."
	  			"SEARCH DESK.">>
      	<PLTABLE
       	"Bar and Bakery Area"
         	<LTABLE 3
	  		"How do I get into the bakery?"
				"Open the door and enter."
				"You need an access card (it's personel only)."
				"Have you been to the dungeonmaster's office? He may have an access card.">
			<LTABLE 3
			"What to do in the bar?"
				"Mingle?"
				"Chat?"
				"Buy alcohol?"
				"If your out of money maybe you shouldn't spent it all on the ticket?"
				"Maybe some other guest dropped some money?"
				"LOOK UNDER TABLE (in Backroom) THEN BUY DRINK.">
			<LTABLE 3
			"What are Preben & Preben about?"
				"Have you listened to them?"
				"You'll need the babel fish (if you're not fluent in danish."
				"Boy! They sure seems thirsty."
				"GIVE DRINK TO PREBEN"
				"Maybe some other guest dropped some money?">
			<LTABLE 3
			"Help! A dragon is following me."
				"No problem. The dragon can't harm you if you stay on the move."
				"Yes, I know, it's a bit impractical..."
				"There is a way to get rid of the dragon."
				"You'll need to visit Rambo's lair."
				"Be sure to have the china man's disguise at hand."
				"You can return later and picking up the telephone.">>
		<PLTABLE
		"Around the Dungeon Hall"
			<LTABLE 3
	  		"Sir Percy's Chamber"
				"Try talking to him."
				"PERCY, HELLO (remember the password)">
			<LTABLE 3
			"Help! I'm abducted by wizard"
				"What do you think he wants you to do?"
				"Help him open the door."
				"OPEN DOOR.">
			<LTABLE 3
			"Blue North-South Corridor"
				"Have you ever played STARCROSS?"
				"I you wait around a bit a space traveller will appear."
				"He seems to be looking for something."
				"If you're carrying the bunch of octagonal rods he will take them but be so excited that he drops something."
				"You can find the bunch of octagonal rods in the storage room."
				"Pick up the black rod that he dropped.">
			<LTABLE 3
			"Help! The guard won't leet me pass."
				"You'll need a password."
				"Sir Percy might have it."
				"And he find it hard to keep a secret."
				"Se hint on Sir Percy's Chamber for more information.">
			<LTABLE 3
			"I can't take the black ladder."
				"You have to distract Edmund."
				"Edmund has a burning desire to be king instead of his father."
				"Neither Edmund or his father have met many foreigners. To them all asians are the same."
				"You need the china man's disguise."
				"WEAR DISGUISE.">>
		<PLTABLE
		"Theatre District"
			<LTABLE 3
			"I don't have a ticket to enter the theatre."
				"It seems you out of money and there's no visible way to buy a ticket."
				"You can't enter the theatre this way."
				"You'll have to go backstage.">
			<LTABLE 3
			"On stage."
				"Listen to Thing-Fish."
				"Follow his instructions."
				"Be sure to raise your hands at the right moment."
				"RAISE HANDS (when Thing-Fish asks if you thing you know what he's talking about).">>
		<PLTABLE
		"Theobald's Hall"
			<LTABLE 3
			"Is there anything to do here?"
				"Yes"
				"You'll need the black rod"
				"Examine the rod"
				"Maybe there's a connection."
				"Have you ever played the Crowther and Woods ADVENTURE?">>
	    <PLTABLE
       	"Lab-Mo-Torium"
			<LTABLE 3
			"A midget with a bucket and a mop."
				"He needs to be distracted."
				"His eyesight isn't that good."
				"Have you noticed what the statuette is depicting?"
				"DROP STATUETTE."
				"But don't give him the spectacles so he notices his mistake!">
			<LTABLE 3
			"The evil prince."
				"To deal with the prince you'll need the ladder, the pastry and some tea."
				"You'll need the ladder to reach him."
				"He's both hungry and thirsty."
				"But you'll need to poison him."
				"The cologne doesn't seems too healthy."
				"DROP LADDER.U.DIP PASTRY IN COLOGNE.GIVE PASTRY TO PRINCE.GIVE TEA TO PRINCE.">
			<LTABLE 3
			"Ok. The evil prince is dead what now?"
				"You're almost finished."
				"The end game begins over at the smelly old farm.">>
		<PLTABLE
		"Heart of Gold"
         	<LTABLE 3
			"What's the switch for?"
				"Try it."
				"TURN SWITCH."
				"That was fun.">
			<LTABLE 3
			"Arthur Dent?"
				"He really needs tea."
				"But you also needs tea."
				"The machine produces tea."
				"PRESS PAD.">>
		<PLTABLE
		"Around the Smelly Old Farm"
			<LTABLE 3
			"Farmers won't let me pass."
				"They are all waiting for the entertainment and want you to join."
				"Maybe you could get the entertainment going?"
				"Try to recruit Miriam."
				"MIRIAM, SING">
			<LTABLE 3
			"Francesco's front lawn."
				"Francesco is only watching you. Pay him no attention."
				"All you have to do is enter the cardboard hut."
				"If the prince is not dead you still have things to do.">>
		<PLTABLE
		"Miscellaneous"
			<LTABLE 3
			"How All the points are scored"
				"This section should only be used as a last resort, or for your own interest after you've completed the game."
				"SCORE  ACTION"
				"   10  Entering the house"
				"   10  Entering the dungeon"
				"   10  Taking the danish pastry"
				"   10  Killing the dragon"
				"   10  Escaping the maze"
				"   10  Taking the tea"
				"   10  Taking the ladder"
				"   10  Entering lab-mo-torium"
				"   10  Killing the evil prince"
				"   10  Entering Francesco's front lawn"
				"  100   TOTAL POINTS">
			<LTABLE 3
			"Frank Zappa and other references"
				"Here's a list of Frank Zappa and other references in the game."
				"Thing-Fish: The unforgetable Thing-Fish (Ike Willis) from the 1984 Zappa album with the same name."
				"The Over-sized Chrome Spoon: Is from the song 'Muffin Man' on the 1975 Zappa & Captain Beefheart album 'Bongo Fury'."
				"The evil prince is a character (racist/theathre critic) from the 'Thing-Fish'-album."
				"Artificial pig - 'Thing-Fish' again."
				"Francesco Zappa was an Italian composer (1717-1803). He is mostly unknown but Frank Zappa played his music on the 1984 album 'Francesco Zappa'."
				"Francesco's front lawn and the cardboard hut is scene from the album 'Thing-Fish'."
				"Preben & Preben was a a standing sketch from a big saturday night entertainment block in swedish television diring the 80s."
				"The Black Adder is a british TV-series by Rowan Atkinson."
				"Various references to different adventure games. Mostly Zork I-III, The Hitchhikers Guide to the Galaxy, The Hobbit and Adventure.">
			<LTABLE 3
			"Have you tried..."
				"This section should only be used after you've completed the game."
				"Listening to the danish bakers without the babel fish? They speak a type of danish wich is understandable if you know a scandinavian language."
				"Raising your hands at the wrong moment."
				"Giving the spectacles to the midget?"
				"Drinking the tea or giving it to Arthur Dent."
				"Eating the danish pastry after it's dipped in cologne.">>
>>

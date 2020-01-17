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
    	"About Magic"
	 		<LTABLE 3
	  		"Spells"
	  			"Spells are found on scrolls."
				"Before spells can be used they have to be copied to the spell book."
				"CAST XEROX ON BRENWYN or XEROX BRENWYN."
				"Before yo can use the spell you'll have to learn it."
				"LEARN WORTA SPELL."
				"Then you can apply the spell by casting it."
				"CAST WORTA ON ME or WORTA ME.">>
      	<PLTABLE 
    	"Outside Castle"
	 		<LTABLE 3
	  		"Francesco's Front Lawn"
	  			"You can always enter the Cardboard Hut."
				"Inside the hut there's a pair of red plastic binoculars.">
         	<LTABLE 3
	  		"Kvill's Playground"
      	  		"Don't play with the equipment!"
				"Seriously, just pick up the piggy bank.">
	 		<LTABLE 3
    		"Picnic Spot"
	  			"Have you examined the rubish bin?"
	  			"Read the newspaper. There's an article about you."
	  			"PIck up the newspaper. You will need it later on.">
	 		<LTABLE 3
    		"Inside Farmhouse"
	  			"Examine everything."
	  			"Especially the distillation kit."
	  			"Farmer Maggot doesn't like you to tamper with his most valuable item so be carefull."
				"You'll have to replace the yeast scroll with something similar."
				"Maybe the newspaper?"
				"REPLACE YEAST SCROLL WITH NEWSPAPER.">
	 		<LTABLE 3
    		"Enter Castle"
	  			"Just go east from outside the gate."
	  			"Beware! You will not be able to go back."
	  			"You'll need the piggy bank and the brenwyn spell later so don't enter without them.">>
      	<PLTABLE
       	"Inside Castle"
         	<LTABLE 3
	  		"Bare Tower Room"
	  			"Don't much here to see."
	  			"Yoiu can always look at the High School."
				"If you have the binoculars you'll be albe to see better.">
	 		<LTABLE 3
	  		"Library"
	  			"It's a very small library."
	  			"There's only one book you can read."
				"And it's not a very good book.">
	 		<LTABLE 3
	  		"Small Room with rabbit cage"
	  			"Have you noticed the lever?"
				"Examine the rabbit before you pull the lever."
	  			"You'll need to set up a trap for the rabbit."
				"The portable well from Honest John will do just fine.">
	 		<LTABLE 3
	  		"Mirror Room"
	  			"It's a magic mirror."
	  			"Try touching it."
	  			"TOUCH MIRROR.">
	 		<LTABLE 3
	  		"Small Room with brick wall"
	  			"You'll have to make the hole bigger."
	  			"You'll need help to do that."
	  			"The people from the Dungeon of Despair will help with that."
				"If you get them to fight they will accidentally make the hole bigger."
				"DROP PHOTO.">
	 		<LTABLE 3
	  		"Robot Shop"
	  			"Examine Floyd."
	  			"He has a hole in him that you can insert something into."
	  			"The motor will fit."
	  			"INSERT MOTOR IN FLOYD.">
	 		<LTABLE 3
	  		"Room with strange machine"
	  			"The machine can break stuff."
				"It'll break the piggy bank."
	  			"But to do that you'll need to speed it up."
	  			"It runs on petrol."
	  			"DROP PIGGY BANK. POUR PETROL IN MACHINE.">>
      	<PLTABLE
       	"Courtyard"
         	<LTABLE 3
	  		"What to do in the courtyard?"
				"Just explore until you find something interesting."
				"There's a rock club.">
			<LTABLE 3
	  		"How do I enter the rock club?"
				"You'll need a VIP-pass."
				"Unfortunatly there's no such thing in this game."
				"You can't enter it.">>
      	<PLTABLE
       	"Toilet and Beyond"
         	<LTABLE 3
	  		"Is the motor useful?"
				"Yes."
				"You'll need it in the robot shop.">
			<LTABLE 3
	  		"Is the bucket useful?"
				"Yes."
				"It's a container."
				"You can fill it with liquid."
				"Petrol is a liquid."
				"FILL BUCKET WITH PETROL.">
			<LTABLE 3
			"Honest John"
				"Try chatting with him."
				"If you got some money he will sell you a portable well.">
			<LTABLE 3
			"Help! I'm stuck in a well!"
				"Tough luck."
				"You're stuck. There's no way out."
				"The well is to be used as a trap.">>
		<PLTABLE
		"Forest"
			<LTABLE 3
			"What to do in the forest?"
				"Explore."
				"There's a swamp there somewhere.">
			<LTABLE 3
			"What to do in the swamp?"
				"Have you seen the toad?"
				"You can always try to kiss the toad."
				"Ok. THat didn't work. You'll need stronger magic."
				"The revhol spell should work."
				"You also need to wear the dress and the wig.">>
	    <PLTABLE
       	"Dungeon of Despair"
         	<LTABLE 3
			"Is the Sub-Dungeon important?"
				"No.">
			<LTABLE 3
			"What do I do with the sinister midget with a bucket and a mop?"
				"Nothing.">
			<LTABLE 3
			"Is there anything I can do in the Dungeon?"
				"Yes."
				"The fettered persons are stage-craft that can be animated with the right spell."
				"BRRRODVEJ PERSONS."
				"If you anger them they will follow you."
				"SHOW PHOTO TO PERSONS.">>
		<PLTABLE
		"End Game"
			<LTABLE 3
			"How do I deal with Kvill?"
				"He's very vain..."
				"Do you know of a spell that would disfigure him?"
				"He also needs to be aware of his disfigurment."
				"You'll need a spell for that to."
				"WORTA KVILL. REPHLEX.">>
		<PLTABLE
		"Miscellaneous"
			<LTABLE 3
			"How All the points are scored"
				"This section should only be used as a last resort, or for your own interest after you've completed the game."
				"SCORE  ACTION"
				"   10  Enter the castle"
				"   10  Enter the toilet"
				"   10  Taking the yeast scroll"
				"   10  Taking the cologne-soaked scroll"
				"   10  Taking the new scroll"
				"   10  Taking the cerise scroll"
				"   10  Taking the pink scroll"
				"   10  Taking the coin"
				"   10  Create the large hole"
				"   10  Defeat Kvill"
				"  100   TOTAL POINTS">
			<LTABLE 3
			"Where you find all the spells"
				"This section should only be used as a last resort, or for your own interest after you've completed the game."
				"XEROX - In your spellbook."
				"WORTA - In your spellbook."
				"BRENWYN - On the yeast scroll inside the farm."
				"BRRRODVEJ - On the cerise scroll given to you by the grue."
				"TUBORG - Scribbled by yourself on the blank scroll."
				"REVHOL - On the pink scroll that Floyd gives you."
				"REPHLEX - On the cologne-soaked scroll that the prince gives you.">
			<LTABLE 3
			"Frank Zappa and other references"
				"Here's a complete list Frank Zappa and other references in the game."
				"Thing-Fish: The unforgetable Thing-Fish (Ike Willis) from the 1984 Zappa album with the same name."
				"Rance the Dungeonkeeper: Rance Mohammitz (Theodore Bikel) from the 1971 Zappa movie '200 Motels'."
				"The Over-sized Chrome Spoon: Is from the song 'Muffin Man' on the 1975 Zappa & Captain Beefheart album 'Bongo Fury'."
				"'Wind Up Working in a Gas Station' is from the 1976 album 'Zoot Allures'."
				"Francesco's front lawn and the cardboard hut is scene from the album 'Thing-Fish'."
				"'Whipping Post' is a Zappa cover of the Allman Brothers Band original on the 1984 album 'Them or Us'."
				"The thing of 'Insering a motor in yourself' is from the 1968 album 'Lumpy Gravy'."
				"'Brrrodvej' is the Thing-Fishs way of pronouncing 'Broadway'."
				"'The Torture Never Stops' is a song from both 'Zoot Allures' and 'Thing-Fish'."
				"'The Dungeon of Despair' is the place where 'The Torture Never Stops'."
				"Various references to different Infocom games. Mostly Zork I-III, Enchanter and Planetfall.">
			<LTABLE 3
			"Have you tried..."
				"The worta spell on different persons (including yourself)."
				"Wrapping the towel around your head."
				"Kissing the toad."
				"Examine the high-school when you have the binoculars."
				"Reading the article in the newspaper."
				"Reading the mouldy book."
				"Typing 'OPEN CAFE' (spelling misstake during testing when trying to type 'OPEN CAGE').">>
>>

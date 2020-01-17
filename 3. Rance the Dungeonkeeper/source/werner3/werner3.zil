"Werner's Quest, Revisited - 3. Rance the Dungeonkeeper main file"

;"Release  1 20191129: First attempt.
  Release  2 20191201: InvisiClues
  Release  3 20200108: Bugs
           4 20200109: Hints lowercase
"

<VERSION XZIP>
<CONSTANT RELEASEID 4>

"Main loop"

<CONSTANT GAME-BANNER
"||...as in a dream, you can see yourself being slapped on the back by a person with german accent, thence tumbling downa short
escalator, and then, the image of the aforementioned man producing various items from a steaming briefcase,a 30 ft. deep well,
and seven useless objects carried by an old and wise-looking, yet oddly inane man. The images are blurred, as if viewed through
a veil of some sort (probably silk). These images give way for another set of images: of you doing your homework, jogging in
the forest, washing the car, pruning the fruit trees, involved in activities including the opposite sex... in short everything
you could have been doing if you weren't playing this game. The images fade away...|
|
|
Werner's Quest, Revisited - 3. Rance the Dungeonkeeper|
Original Quill game by Jan Åberg, 1985, 1986|
Source extracted from C64-version with Unquill v0.11 and converted to ZIL by Henrik Åsman, 2019|
Type 'ABOUT' for more details about this version.">

<ROUTINE GO () 
    <CRLF>
    <INIT-STATUS-LINE>
    <V-VERSION> <CRLF>
    <PUTP PLAYER ,P?CAPACITY 50>            ;"Default SIZE of objects is 5. This limits the inventory to 10 objects." 
    <SETG HERE ,01-ESCALATOR-BOTTOM>
    <MOVE ,PLAYER ,HERE>
    <QUEUE I-EVERY-TURN -1>
    <V-LOOK>
    <TELL CR ,MESSAGE-053 CR>
    <MOVE ,28-PRINTOUT ,WINNER>
    <MAIN-LOOP>>

;"Flags"

<GLOBAL 05-WELL1-COUNTER 0>                 ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 06-WELL2-COUNTER 0>                 ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 07-PAPERBAG-COUNTER 0>              ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 08-RAVINE-COUNTER 0>                ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 11-STONE-DOOR-FLAG <>>
<GLOBAL 12-NEW-JERSEY-DOOR-FLAG T>
<GLOBAL 13-BLANKET-ON-BRUCE-FLAG <>>
<GLOBAL 14-BRUCE-SPRINGSTEEN-FLAG <>>
<GLOBAL 15-BOOK-FLAG <>>
<GLOBAL 16-TV-FLAG <>>
<GLOBAL 17-ZX-SPECTRUM-FLAG <>>
<GLOBAL 18-WELL-FLAG <>>
<GLOBAL 19-FARMHOUSE-FLAG <>>
<GLOBAL 20-PREBEN-FLAG <>>
<GLOBAL 21-DEVICE-FLAG <>>
<GLOBAL 22-ELEVATOR-FLAG T>

<GLOBAL HIT-COUNTER 0>

<GLOBAL SCORE-INSERT-SPOON-FLAG <>>
<GLOBAL SCORE-ZX-SPECTRUM-FLAG <>>
<GLOBAL SCORE-DANISH-PASTRY-FLAG <>>
<GLOBAL SCORE-SALAMI-FLAG <>>
<GLOBAL SCORE-YELLOW-STAMP-FLAG <>>
<GLOBAL SCORE-BASKETBALL-FLAG <>>
<GLOBAL SCORE-PAPERBAG-FLAG <>>
<GLOBAL SCORE-ALBUM-FLAG <>>
<GLOBAL SCORE-WAKE-MAN-FLAG <>>
<GLOBAL SCORE-PULL-LEVER-FLAG <>>

;"Messages"

<CONSTANT MESSAGE-000 "You see nothing special.">
<CONSTANT MESSAGE-001 "Taken.">
<CONSTANT MESSAGE-002 "Dropped.">
<CONSTANT MESSAGE-003 "You pull the spoon out of the rock.">
<CONSTANT MESSAGE-004 "You reach for the bag, but the person dodges your grip.">
<CONSTANT MESSAGE-005 "You remove the bag from the head of the seemingly unconscious person. Your suspicion is comfirmed: It's the Thing-Fish. \"Peek-a-boo, boy, peek-a-boo!\", he says, \"Ya sho'nuff didn't expect me to be in a cute place like dis, didja? I'll tell ya one thing: Dat deahhh froot joos bidniz wuz jes' a gimmick. De trooth is dat I has dicovuhd sum really really comprommuhtatim stuff 'bouts y'all, an' as soon as de appropriot measures has been taken, I'll sho'nuff be back, wit avengance!\" He takes a pause to gesticulate. \"Hah! I sho'nuff doesn't forgets easily, does I? See ya latuh, boy!\" He disappears in a puff of stage-craft.">
<CONSTANT MESSAGE-006 "The clothes line is securely tied.">
<CONSTANT MESSAGE-007 "You take the blanket off Bruce Springsteen. The sound of \"Cover Me\" can once again be heard clearly.">
<CONSTANT MESSAGE-008 "As you approach the pedestal to take the Philatelist's Stone, you are immediately and inexplicably incinerated, and there is now one more severely-burnt skeleton in the room.">
<CONSTANT MESSAGE-009 "You are now wearing the bag over your head. You can see quite well through the peep-holes, but in spite of this you feel very silly.">
<CONSTANT MESSAGE-010 "You remove the bag. This makes you feel somewhat less silly.">
<CONSTANT MESSAGE-011 "You lean the ladder against the toadstool, enabling you to climb it.">
<CONSTANT MESSAGE-012 "In the rock there is a slot.">
<CONSTANT MESSAGE-013 "The plastic gnome is about 4 ft high and holds its right index finger stretched out. On its head is positioned an antenna, and it's wheel-equipped feet are mounted on the railway.">
<CONSTANT MESSAGE-014 "It's in as good shape as one could expect from a Spectrum that has been buried among rot and garbage for a while, or, by the way, from any Spectrum: slippery, mouldy and with a keyboard that reminds you of a bunch of well-worn erasers.">
<CONSTANT MESSAGE-015 "He's old and wise-looking, but still there's something oddly inane about him, just as in your vision.">
<CONSTANT MESSAGE-016 "He's old and wise-looking, but still there's something oddly inane about him. He's also fast asleep.">
<CONSTANT MESSAGE-017 "He's wearing a pair of Levi's 501 (of course) and a white T-shirt, and he's singing \"Cover Me\".">
<CONSTANT MESSAGE-018 "If you hadn't known who it was, you could never have guessed that it's Bruce Springsteen, because he's covered with a blanket, which muffles his song.">
<CONSTANT MESSAGE-019 "The wheel-mounted gnome's index finger is pointing at the open white door.">
<CONSTANT MESSAGE-020 "It look just like an ordinary stone.">
<CONSTANT MESSAGE-021 "\"All ye who go around saying unto famous music personalities: Hello Taylor; verily, for thee it shouldst be easier to complete thy quest; thou shouldst be rewardeth with one of the items upon thine computer printout\"">
<CONSTANT MESSAGE-022 "In the book you find a green 3 skilling banco stamp.">
<CONSTANT MESSAGE-023 "It's a form of sausage which smells horrible.">
<CONSTANT MESSAGE-024 "\"Hello Adventurer!|| To complete this quest, you must gather the following objects:||  A Danish Pastry|  A Paper Bag (brown, with peepholes)|  A Yellow 3 Skilling Banco Stamp|  A Duran Duran Album|  A Salami Sausage|  A Basketball|  A ZX Spectrum (oh, that lovely computer!(joke))|| When you are in possession of these, you must find the Werner Dungeon Adventure Player Inspector, who will show you to the Final Conquest.|| Bye for now,| Rance the Dungeonkeeper\"">
<CONSTANT MESSAGE-025 "The Danish pastry is a Danish cookie with chocolate in the middle.">
<CONSTANT MESSAGE-026 "The album is called \"Duran Duran\" and is with the group of the same name.">
<CONSTANT MESSAGE-027 "It appears to be a very expensive yacht. On the deck is standing John Taylor, who's occupied with ribs, rigging and all the other whatchammacallits of an average yacht.">
<CONSTANT MESSAGE-028 "It's small, black, thumb-shaped and equipped with a large red button labelled \"Large Red Button\".">
<CONSTANT MESSAGE-029 "The toad is green and repellent.">
<CONSTANT MESSAGE-030 "The TV set has two buttons marked \"1\" and \"2\" respectively. It is currently showing two intemperate Danish pastry cooks who seem to have vast difficulties to get started baking Danish pastries.">
<CONSTANT MESSAGE-031 "The TV set has two buttons marked \"1\" and \"2\" respectively. It is currently showing what appears to be some kind of nature programme, as the screen shows a canyon bottom.">
<CONSTANT MESSAGE-032 "The imposing stone door is closed.">
<CONSTANT MESSAGE-033 "The escalator goes downwards, and so you aren't really going anywhere. You return to Werner's Quest III.">
<CONSTANT MESSAGE-034 "As you insert the spoon in the rock, the stone doors swing open with an \"Eep\", a \"Boing\" and a \"Falukropp\" respectively.">
<CONSTANT MESSAGE-035 "You put the spoon back into the rock.">
<CONSTANT MESSAGE-036 "The door is closed.">
<CONSTANT MESSAGE-037 "The door is open.">
<CONSTANT MESSAGE-038 "Opened.||The sound of Bruce Springsteen singing \"Cover Me\" drifts through the door. The old man says: \"No! Not more heavy metal music!\"">
<CONSTANT MESSAGE-039 "Opened.||The sound of Bruce Springsteen (albeit somewhat muffled) drifts through the door. The old man wakes up and screams: \"HELP! ASSAULT! EXPLOSION! FIRE! What? Oh no! Heavy metal music again!\"">
<CONSTANT MESSAGE-040 "The door is already open.">
<CONSTANT MESSAGE-041 "Closed.">
<CONSTANT MESSAGE-042 "Closed.||The sound of Bruce Springsteen can still be heard, although somewhat muffled. The old man says: \"Smart, young man! But I can still hear that horrible heavy metal music!\"">
<CONSTANT MESSAGE-043 "Closed.||The room is now quiet, and the old man falls asleep.">
<CONSTANT MESSAGE-044 "The door is already closed.">
<CONSTANT MESSAGE-045 "Opened.">
<CONSTANT MESSAGE-046 "You cover Bruce Springsteen with the blanket, and the sound of his song is muffled.">
<CONSTANT MESSAGE-047 "The old man says: \"Oh, I can't get any sleep because of that rind in there and his heavy metal music!\". He points at the door.">
<CONSTANT MESSAGE-048 "Among the assorted rot and decay you find a thing that doesn't differ very much from the rest of the floor: a ZX Spectrum.">
<CONSTANT MESSAGE-049 "The now-familiar troll enters. With his large axe, he chops you into a multitude of pieces, which evaporate.">
<CONSTANT MESSAGE-050 "The spoon appears to be stuck in your hand. How strange.">
<CONSTANT MESSAGE-051 "As you raise the spoon to strike, the now-familiar troll enters, brandishing an axe which he swings at you. Just before it reaches its goal, Rance the Dungeonkeeper materializes from thin air, grabbing to troll's wrist, thereby stopping him from completing his deed. Rance says: \"No! In zis parzicular zituation it iz aczilly allowed to perform zat aczion. It iz vithin ze conceptual framevork of this computerized event. Look here!\" He produces the long listing from his steaming briefcase and shows it to the troll. After studying the listing the troll leaves, murmuring not-so-kind things about Rance depriving him of his livelihood. Rance remarks to you: \"Now, conzinue vat you vere doing!\" You hit the bag-wearing person with the spoon, seemingly battering him into unconsciousness. Rance the Dungeonkeeper disappears in a puff of stage-craft.">
<CONSTANT MESSAGE-052 "Suddenly, the oversized, chrome spoon appears in your hand, wildly glowing.">
<CONSTANT MESSAGE-053 "Rance the Dungeonkeeper comes gliding down the hand-rail. He reaches into his steaming briefcase and produces a long computer printout. He examines the printout and says to you: \"Vell, according to zis here assembly language listing, you vill, to komplete zis kvest, have to collect some items: A Danish pastry, a brovn paper bag viz peepholes in it, a Swedish yellow 3 skilling banco stamp, a Duran Duran album, a salami sausage and a basketball.\" He tears off a piece of the printout and hands it to you. He then disappears in a puff of stage-craft.">
<CONSTANT MESSAGE-054 "You hear a voice overhead: \"Hey you zown zere!\" You look up and notice Rance the Dungeonkeeper gazing into the well. He's wearing braces and a silly straw hat, and he's carrying the steaming briefcase. He says: \"It is I, Rance ze Dungeonkeeper! I'm not very good at zis dungeonkeeping bizniz, but according to zis here assembly language listing\" he says, producing the listing from the briefcase, \"I vill appear now, zressed up like a simple farm hand, and zrow youze clothes line. Vait a moment.\" He leaves.">
<CONSTANT MESSAGE-055 "Rance the Dungeonkeeper re-appears at the top of the well with the clothes line, which he throws into the well. \"Oh zear\", he says, \"how ztupid of me. I should of course have kept one of the ends up here. I zink I vill have to poke into ze very programme to get you out of zere.\" He reaches into the briefcase from which can be heard faint clicking, the only result being the disappearance of the clothes line.">
<CONSTANT MESSAGE-056 "Rance gazes down into the well and says: \"You're still zere, are you not? Too bad. I'll do some more poking.\" He reaches into the briefcase again. Suddenly, strange things happen. The well begins to transform; slowly, the stones of its wall seem to melt away, and are replaced by the surroundings of another place...">
<CONSTANT MESSAGE-057 "Before you can even start to descend the well, Rance the Dungeonkeeper dashes out of the farmhouse, shouting: \"No! Not ze vell again!\" He ushers you into the tool shed.">
<CONSTANT MESSAGE-058 "From outside the tool shed you can hear the voice of Rance the Dungeonkeeper: \"Nasty person! Now stay in zere until you've learnt not to cauze me a lot of zrouble!\"">
<CONSTANT MESSAGE-059 "Rance looks up and notices you. He says: \"Get out! You are not allowed to be here! Ze very Dungeonkeeper's headquarters are situated in zis farmhouse. Zcram!\" He leads you out of the farmhouse.">
<CONSTANT MESSAGE-060 "Rance the Dungeonkeeper looks up and says: \"Hello zere, Thing-Fish!\"">
<CONSTANT MESSAGE-061 "Rance turns to you and says: \"By ze way, here I have a basketball.\" He produces one from the steaming briefcase. \"Take it and conzeal it in a safe plaze.\" He gives the basketball to you. Having done this, he takes a closer look at you, and notices that you're not the Thing-Fish. He removes the bag from your head with a triumphating smile. \"Ha! Thought you could fool me, did you not?\" You are thrown out and the paperbag with you.">
<CONSTANT MESSAGE-062 "You remove the bag. Rance, seeing this, shouts: \"Vat? You here? Get out at once, you nasty person!\" He ushers you out of the farmhouse.">
<CONSTANT MESSAGE-063 "You say \"Hello Taylor\". John Taylor hears this and raises his hands to wave at you. Doing this, he lets go of the ribs, railing and whatchammacallits with which he was fiddling. As a result of this, the whole rigging falls down on the deck with a loud thump. This thump has obviously startled Simon LeBon, who has been resting (or something) below the deck. He dashes up onto the deck, thereby stumbling on the pieces of string that lie scattered on the deck and falls overboard. Well, almost. His right foot gets stuck in the bulwark rail and he describes a beautiful arch, his head hitting the hull right above the waterline. Seeing this, Taylor breaks into uncontrollable laughter. His paroxysms, along with the gesticulating of LeBon, set the boat rocking. In fact, it rocks so much that it capsizes and sinks, accompanied by Taylor's laughter">
<CONSTANT MESSAGE-064 "and LeBon's profundities. Very little wreckage floats ashore, in fact only one item.">
<CONSTANT MESSAGE-065 "Pressed. You think that you see movement below, buy you're not sure about it.">
<CONSTANT MESSAGE-066 "The screen changes: It now shows some kind of nature program.">
<CONSTANT MESSAGE-067 "The screen changes: It now shows the interior of a Danish bakery.">
<CONSTANT MESSAGE-068 "Nothing happens.">
<CONSTANT MESSAGE-069 "You touch the screen and find yourself transported to another place...">
<CONSTANT MESSAGE-070 "Preben says: \"JA, HIER HABEN WIR ABER EINEN KLEINEN EINEN! DEN SOLLEN WIR TRINKEN STASSEN GEMASSEN SEIN!\" Preben leans over to Preben and whispers: \"Zat vas not Danish, you potato-headed jigaboo! It vas German!\" Preben whispers back: \"Wut? Goiman? Weren't dat no Danish? How embarrassim! We'd bettuh shurrup den, hadn't we?\"|\"Zat iz correct\", Preben replies, \"let's just hope zat he doesn't suspect anyzing.\"">
<CONSTANT MESSAGE-071 "The bargnome takes the coin and says: \"The same as usual, aye?\" You take a closer look at him and see that it's the same gnome as in Werner's Quest I. He hands you a drink.">
<CONSTANT MESSAGE-072 "You have no money.">
<CONSTANT MESSAGE-073 "Preben & Preben say nothing, but they stop you from taking the bottles.">
<CONSTANT MESSAGE-074 "Preben & Preben take the drink and hand you a Danish pastry. They then remove their disguises and you see that it is the Thing-Fish and Rance the Dungeonkeeper respectively. The Thing-Fish says: \"Owaah! Thought ya was back in Werner's Quest I dere, din'tja? Whoe no! What time iddit?\" He reaches into Rance's briefcase and produces a grandfather clock, at which he gazes warily. \"Oh deahh! Ah'm late! I must go now an' arrange fo' de revengement I've been planning fo' ya!\" He disappears in a puff of stage-craft. Rance says: \"Vat? Vat about my clock? Vell, never mind! Let's get back to ze dungeon again!\" He pushes one of the walls gently, but nothing happens. He says: \"How strange! It vorked zis morning. Vell, anyvay, ve can poke a little.\" He reaches into his briefcase, and the room begins to change...">
<CONSTANT MESSAGE-075 "The chute is too steep to ascend.">
<CONSTANT MESSAGE-076 "Rance the Dungeonkeeper materializes from thin air. He says: \"Oh! Zere you are! Do you zink zis is some form of nostalgy zrip? Now, let's get back to zedungeon again.\" He gently pushes one of the walls and...">
<CONSTANT MESSAGE-077 "Time passes...">
<CONSTANT MESSAGE-078 "The sandstone block is blocking your way down.">
<CONSTANT MESSAGE-079 "You hear a grinding sound; the walls are moving, and you are being shuffled around by them. Finally, they stop.">
<CONSTANT MESSAGE-080 "There is a grinding sound, and the walls begin to move. When they stop, they've formed a corridor leading south.">
<CONSTANT MESSAGE-081 "Your surroundings shift...">
<CONSTANT MESSAGE-082 "The device emits an eep. Maybe it's broken.">
<CONSTANT MESSAGE-083 "The opening is too high to reach.">
<CONSTANT MESSAGE-084 "The door closes and the elevator starts to vibrate. After a while, the vibrations stop and the door opens.">
<CONSTANT MESSAGE-085 "You have walked into a steel door.">
<CONSTANT MESSAGE-086 "You saw a round hole in the floor. Unfortunately, you stand in the middle of it. Therefore, you fall down through the hole and land on a pedestal in the room below. The planks disappear by the magic of stage-craft.">
<CONSTANT MESSAGE-087 "As you leave the pedestal, you are immediately incinerated and join the severely-burnt skeletons.">
<CONSTANT MESSAGE-088 "As you touch the stamp with the stone, its colour changes to yellow.">
<CONSTANT MESSAGE-089 "The stamp is a yellow 3 skilling banco stamp already.">
<CONSTANT MESSAGE-090 "You shouldn't finger at stamps, it might hurt the teeth.">
<CONSTANT MESSAGE-091 "The old man wakes up, obviously startled. He stares at you, then he takes out a steaming briefcase from under his sheets. He produces a long printout from it and gazes at it briefly. Then he says: \"Oh! You! That's right! Down here!\" He opens a concealed trap door in the floor and you gently descend the stairway below it. As you dot his, the old man runs past you down the stairs, changing clothes while running. He transforms from an old man via Rance the Dungeonkeeper to a small man with a three-piece suit, a bowtie and glasses. Finally, you reach the bottom of the staircase...">
<CONSTANT MESSAGE-092 "The man isn't asleep, so it would be hard to wake him up.">
<CONSTANT MESSAGE-093 "You are in a small office at the bottom of the stairs. The small man is here. He eyes your possessions and produces the long listing from the ever-present steaming briefcase. After consulting this, he says: \"Well, it seems like you haven't got all the objects. Try again some other time.\" The walls turn and...">
<CONSTANT MESSAGE-094 "You are in a small office at the end of the staircase. The small man is here. He examines your possessions and says: \"Well, I think you've passed the test.\" The walls turn and...">
<CONSTANT MESSAGE-095 "As you pull the lever, the room is filled with dwarves, hobbits, wizards, elves, martians, venusians, farmers, trolls, ogres and Rance the Dungeonkeeper. Rance says: \"Vell done! You've completed Werner's Kvest III. But zere's still a slight problem; what shall we do wiz you now? Ve have no problems left for you to tackle.\" An extremely fat wizard steps forward. He introduces himself as Bulbouse, headmaster of the Necromancers' High School. He says: \"OK, OK, I'll take him, though I doubt he'll ever make a good necromancer...\"|And so you've come to study at the Necromancers' High School...">
<CONSTANT MESSAGE-096 "You push the wall, which slides forward. You follow it. Behind you other walls change position.">
<CONSTANT MESSAGE-097 "You push one of the walls, but nothing happens.">
<CONSTANT MESSAGE-098 "You connect the ZX Spectrum to the TV set and start it up. The sight of the startup message, however, makes you sick, and so you turn it off again.">
<CONSTANT MESSAGE-099 "You can't reach the toad.">
<CONSTANT MESSAGE-100 "You kiss the toad. Nothing happens. The toad croaks: \"Thanks, sailor! But it's too strong a curse to be lifted by a kiss. Come back when you're a necromancer or something. I'll probably be in the Ivetofta Swamp by then.\"">
<CONSTANT MESSAGE-101 "The toad looks at you flirtily.">
<CONSTANT MESSAGE-102 "You hang the blanket on the clothes line.">
<CONSTANT MESSAGE-103 "Aah! That was a nice drink.">
<CONSTANT MESSAGE-104 "That was a very nice Danish pastry.">
<CONSTANT MESSAGE-105 "The salami tastes horrible, but you manage to consume it all.">
<CONSTANT MESSAGE-106 "Rance the dungeonkeeper appears. He takes the wizard by the arm and leads him off, saying: \"Questions, questions, questions, flooding into ze mind of ze conzerned young person zoday...\"">
<CONSTANT MESSAGE-107 "A wizard appeats, carrying a zipper. He takes a speaker out of the zipper, looks at you and asks eagerly: \"Where can I go to get my speakers fixed?\"">
<CONSTANT MESSAGE-108 "A wizard appears, carrying a zipper. He takes a pair of jeans out of the zipper, looks at you and asks eagerly: \"Where can I go to get my jeans embroidered?\"">
<CONSTANT MESSAGE-109 "A wizard appears, carrying a zipper. He looks very sick as he looks at you and asks porridgily: \"Where can I go to get my stomach pumped?\"">
<CONSTANT MESSAGE-110 "A wizard appears, carrying a zipper. He takes a poodle out of the zipper and asks you: \"Where can I go to get my poodle clipped in this dungeon?\"">
<CONSTANT MESSAGE-111 "A wizard appears, carrying a zipper. He looks at you and asks: \"Where can I go to get organic vaseline?\"">
<CONSTANT MESSAGE-112 "A wizard appears, carrying a broken zipper out of which fall various items, among them a pair of jeans, a poodle and a pair of speakers. These items immediately disappear through the magic of stage-craft. He is almost ready to burst into tears as he asks you: \"Where can I go to get my zipper repaired?\"">
<CONSTANT MESSAGE-113 "You enter the ocean. John Taylor steers the yacht nearer and picks you up. He looks you up and down for a while before he discards you and throws you into the ocean again. You scramble out of the water.">
<CONSTANT MESSAGE-114 "You enter the ocean and splash around for a while, but nothing exciting happens, and so you get out of the water.">
<CONSTANT MESSAGE-115 "He whispers: \"Do what ya shudd instead of disturbing woikin' people!\"">

<CONSTANT SYSMESSAGE-000 "">
<CONSTANT SYSMESSAGE-001 "You can see:">
<CONSTANT SYSMESSAGE-002 "What next? ">
<CONSTANT SYSMESSAGE-003 "What next? ">
<CONSTANT SYSMESSAGE-004 "What next? ">
<CONSTANT SYSMESSAGE-005 "What next? ">
<CONSTANT SYSMESSAGE-006 "What kind of talk is that? I'm not Encyclopedia Britannia y'know.">
<CONSTANT SYSMESSAGE-007 "You can't move in that direction.">
<CONSTANT SYSMESSAGE-008 "That's impossible.">
<CONSTANT SYSMESSAGE-009 "Concealed upon your person are:">
<CONSTANT SYSMESSAGE-010 "(worn over your head, which makes you feel silly)">
<CONSTANT SYSMESSAGE-011 "A complete and utter absence of belongings.">
<CONSTANT SYSMESSAGE-012 "Quit? That could be a severe mistake. Are you sure?">
<CONSTANT SYSMESSAGE-013 "               The End.||Are you going to make another pitiful attempt?">
<CONSTANT SYSMESSAGE-014 "OK. That will probably be the best.">
<CONSTANT SYSMESSAGE-015 "OK.">
<CONSTANT SYSMESSAGE-016 "More...">
<CONSTANT SYSMESSAGE-017 "You have taken ">
<CONSTANT SYSMESSAGE-018 " turn">
<CONSTANT SYSMESSAGE-019 "s">
<CONSTANT SYSMESSAGE-020 ".">
<CONSTANT SYSMESSAGE-021 "You have scored">
<CONSTANT SYSMESSAGE-022 "%25">
<CONSTANT SYSMESSAGE-023 "You're not wearing it.">
<CONSTANT SYSMESSAGE-024 "Your hands are full.">
<CONSTANT SYSMESSAGE-025 "You already have it.">
<CONSTANT SYSMESSAGE-026 "The item to which you're referring isn't present.">
<CONSTANT SYSMESSAGE-027 "Your load is too heavy.">
<CONSTANT SYSMESSAGE-028 "That item isn't carried by you.">
<CONSTANT SYSMESSAGE-029 "You're already wearing it.">
<CONSTANT SYSMESSAGE-030 "Y">
<CONSTANT SYSMESSAGE-031 "N">
<CONSTANT SYSMESSAGE-032 "Disc or Tape?">
<CONSTANT SYSMESSAGE-033 "Type in filename.">
<CONSTANT SYSMESSAGE-034 "Start the tape.">

;"-----------------------------------------------------------------------------"
;" ZILF Library and extensions"
;" REPLACE-DEFINITION - Overriding parser-routines "
;"-----------------------------------------------------------------------------"

<INSERT-FILE "zillib/parser">
<INSERT-FILE "extensions/parser-extension">
<INSERT-FILE "extensions/verbs-extension">
<INSERT-FILE "hints">

<GLOBAL WIZARD-ACTION
	<LTABLE 
		,MESSAGE-107
		,MESSAGE-108
		,MESSAGE-109
		,MESSAGE-110
		,MESSAGE-111
		,MESSAGE-112>>

<GLOBAL GAME_VERSION_CLASSIC <>>                    ;"Should the game be played in CLASSIC or NEW mode? (NEW won't kill quite as swift as in CLASSIC mode)"

;"-----------------------------------------------------------------------------
; ROOMS
; -----------------------------------------------------------------------------"

;"Room: ESCALATOR BOTTOM ------------------------------------------------------"
<ROOM 01-ESCALATOR-BOTTOM
    (DESC "Bottom of Escalator")
    (IN ROOMS)
    (LDESC 
"You are standing at the bottom of a short escalator, which is going downwards. A passage leads south.")
    (SOUTH TO 02-ROUND-ROOM)
    (UP ,MESSAGE-033)
    (FLAGS LIGHTBIT)
    (THINGS (SHORT) (ESCALATOR) STANDARD-F)>

;"Room: ROUND ROOM ------------------------------------------------------------"
<ROOM 02-ROUND-ROOM
    (DESC "Round Room")
    (IN ROOMS)
    (LDESC 
"You are in a round room with imposing stone doors leading east, west and south. A passage leads north.")
    (NORTH TO 01-ESCALATOR-BOTTOM)
    (SOUTH TO 04-GREAT-HALL-N IF 11-STONE-DOOR-FLAG ELSE ,MESSAGE-032)
    (EAST TO 25-BEDROOM IF 11-STONE-DOOR-FLAG ELSE ,MESSAGE-032)
    (WEST TO 16-REMARKABLE-SPOT IF 11-STONE-DOOR-FLAG ELSE ,MESSAGE-032)
    (FLAGS LIGHTBIT)
    (THINGS (IMPOSING STONE) (DOOR DOORS) STONE-DOOR-F)>

<ROUTINE STONE-DOOR-F ()
    <COND (<AND <VERB? EXAMINE> <NOT ,11-STONE-DOOR-FLAG>>
        <TELL ,MESSAGE-032 CR>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: GREAT HALL NW ---------------------------------------------------------"
<ROOM 03-GREAT-HALL-NW
    (DESC "Northwest Corner of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the northwest corner of the great hall. To the southeast is a large triangular structure. Rails stretch from south to east.")
    (EAST TO 04-GREAT-HALL-N)
    (SOUTH TO 06-GREAT-HALL-W)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL N ----------------------------------------------------------"
<ROOM 04-GREAT-HALL-N
    (DESC "North End of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the northern end of a great hall. To the south stands a large triangular structure. What appears to be a railway stretches from east to west.")
    (NORTH TO 02-ROUND-ROOM)
    (SOUTH TO 07-GREAT-HALL-C)
    (EAST TO 05-GREAT-HALL-NE)
    (WEST TO 03-GREAT-HALL-NW)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL NE ---------------------------------------------------------"
<ROOM 05-GREAT-HALL-NE
    (DESC "Northeast Corner of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the northeast corner of the great hall. To the southwest is a large triangular structure. There is a giant mushroom here, upon which is seated a toad.
Therefore, you conclude, it's not so much a mushroom as a toadstool. In its stem is set a white door. The rails stretch from west to south.")
    (WEST TO 04-GREAT-HALL-N)
    (SOUTH TO 08-GREAT-HALL-E)
    (IN PER GREAT-HALL-NE-IN-EXIT)
    (UP PER GREAT-HALL-NE-UP-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F
            (GIANT) (MUSHROOM TOADSTOOL) TOADSTOOL-F
            (WHITE) (DOOR) TOADSTOOL-DOOR-F
            (<>) (TOAD FROG) TOAD-F)>

<ROUTINE GREAT-HALL-NE-IN-EXIT ()
    <COND (<=? <LOC ,21-PLASTIC-GNOME> ,HERE> <RETURN ,46-TOADSTOOL>)>
    <TELL ,MESSAGE-036 CR>
    <RFALSE>
>

<ROUTINE GREAT-HALL-NE-UP-EXIT ()
    <COND (<=? <LOC ,33-LADDER-AGAINST-TOADSTOOL> ,HERE> <RETURN ,12-ON-TOADSTOOL>)>
    <TELL ,SYSMESSAGE-007 CR>
    <RFALSE>
>

<ROUTINE TOADSTOOL-F ()
    <COND (<VERB? WALK ENTER>
        <DO-WALK P?IN>
        <RTRUE>
    )>
    <STANDARD-F>
>

<ROUTINE TOADSTOOL-DOOR-F ()
    <COND (<VERB? WALK ENTER>
        <DO-WALK P?IN>
        <RTRUE>
    )>
    <COND (<VERB? EXAMINE> 
        <COND (<=? <LOC ,21-PLASTIC-GNOME> ,HERE>
            <TELL ,MESSAGE-037 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-036 CR>
            <RTRUE>
        )>
    )>
    <STANDARD-F>
>

<ROUTINE TOAD-F ()
    <COND (<VERB? EXAMINE> 
        <TELL ,MESSAGE-029 CR>
        <RTRUE>
    )>
    <COND (<VERB? KISS> 
        <COND (<=? ,HERE ,05-GREAT-HALL-NE>
            <TELL ,MESSAGE-099 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-100 CR>
            <RTRUE>
        )>
    )>
    <STANDARD-F>
>

;"Room: GREAT HALL W ----------------------------------------------------------"
<ROOM 06-GREAT-HALL-W
    (DESC "West End of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the west end of the great hall. The large triangular structure lies to the east. Some rails are lying here, by some reason
arranged in the north-southern direction.")
    (NORTH TO 03-GREAT-HALL-NW)
    (SOUTH TO 09-GREAT-HALL-SW)
    (EAST TO 07-GREAT-HALL-C)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL C ----------------------------------------------------------"
<ROOM 07-GREAT-HALL-C
    (DESC "Center of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are standing at the foot of the triangular structure in the middle of the great hall. Stairs lead up the hypotenuse of the triangle.")
    (NORTH TO 04-GREAT-HALL-N)
    (SOUTH TO 10-GREAT-HALL-S)
    (EAST TO 08-GREAT-HALL-E)
    (WEST TO 06-GREAT-HALL-W)
    (UP TO 13-VERTEX)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL E ----------------------------------------------------------"
<ROOM 08-GREAT-HALL-E
    (DESC "East End of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the great hall, east of the triangular structure. The railway is at this point stretching from the north to the south.")
    (NORTH TO 05-GREAT-HALL-NE)
    (SOUTH TO 11-GREAT-HALL-SE)
    (WEST TO 07-GREAT-HALL-C)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL SW ---------------------------------------------------------"
<ROOM 09-GREAT-HALL-SW
    (DESC "Southwest Corner of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the southwest corner of the great hall, in the middle of which stands a large triangular structure. The now-familiar
railway turns north and east.")
    (NORTH TO 06-GREAT-HALL-W)
    (EAST TO 10-GREAT-HALL-S)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL S ---------------------------------------------------------"
<ROOM 10-GREAT-HALL-S
    (DESC "South End of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are at the southern part of the great hall. To the north lies the large triangular structure. The railway situation: east-west.")
    (NORTH TO 07-GREAT-HALL-C)
    (EAST TO 11-GREAT-HALL-SE)
    (WEST TO 09-GREAT-HALL-SW)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: GREAT HALL SE --------------------------------------------------------"
<ROOM 11-GREAT-HALL-SE
    (DESC "Southeast Corner of the Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the southeast corner of the great hall. To the northwest you can see the large triangular structure. Oh, I forgot to
mention: The rails at this particular point stretch from north to west.")
    (NORTH TO 08-GREAT-HALL-E)
    (WEST TO 10-GREAT-HALL-S)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE TRIANGULAR) (STRUCTURE) STANDARD-F
            (<>) (RAIL RAILS RAILWAY) STANDARD-F)>

;"Room: ON TOADSTOOL --------------------------------------------------------"
<ROOM 12-ON-TOADSTOOL
    (DESC "On Toadstool")
    (IN ROOMS)
    (LDESC 
"You are sitting on the toadstool beside the toad.")
    (DOWN TO 05-GREAT-HALL-NE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (TOAD FROG) TOAD-F)>
     
;"Room: VERTEX ----------------------------------------------------------------"
<ROOM 13-VERTEX
    (DESC "Standing On Vertex of Structure")
    (IN ROOMS)
    (LDESC 
"You are standing on one leg on the pin-sharp vertex of the triangular structure. Inexplicably suspended in mid-air are eight
buttons marked from 1 to 8.")
    (DOWN TO 07-GREAT-HALL-C)
    (ACTION VERTEX-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BUTTON BUTTONS) VERTEX-BUTTON-F)>

<ROUTINE VERTEX-F (RARG)
    <COND (<AND <=? .RARG ,M-BEG> <VERB? PUSH>>
        <COND (<=? ,P-NUMBER 1>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,09-GREAT-HALL-SW>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 2>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,06-GREAT-HALL-W>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 3>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,03-GREAT-HALL-NW>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 4>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,04-GREAT-HALL-N>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 5>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <MOVE ,21-PLASTIC-GNOME ,05-GREAT-HALL-NE>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 6>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,08-GREAT-HALL-E>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 7>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,11-GREAT-HALL-SE>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,P-NUMBER 8>
            <TELL ,MESSAGE-065 CR>
            <MOVE ,04-PLASTIC-GNOME ,10-GREAT-HALL-S>
            <MOVE ,21-PLASTIC-GNOME ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<=? ,PRSO ,NUMBER>
            <TELL "You don't see that here." CR>
            <RTRUE>
        )>
    )>    
>

<ROUTINE VERTEX-BUTTON-F ()
    <COND (<VERB? PUSH> <TELL "You need to be more specific." CR> <RTRUE>)>
    <STANDARD-F>
>

;"Room: PLAIN CUTE ------------------------------------------------------------"
<ROOM 14-PLAIN-CUTE
    (DESC "Plain Cute")
    (IN ROOMS)
    (LDESC 
"You are at another part of Plain Cute, but the cuteness remains: flowers, butterflies and rabbits.")
    (EAST TO 15-PLAIN-CUTE)
    (SOUTH TO 17-PLAIN-CUTE)
    (ACTION PLAIN-CUTE-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (FLOWER FLOWERS BUTTERFLIE BUTTERFLIES RABBIT RABBITS) STANDARD-F)>

<ROUTINE PLAIN-CUTE-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <=? <LOC ,06-THING-FISH> ,HERE> <NOT <HELD? 03-CHROME-SPOON>>>
        <TELL CR ,MESSAGE-052 CR>
        <MOVE ,03-CHROME-SPOON ,WINNER>
        <MOVE ,02-LARGE-ROCK-WITH-SPOON ,LOCAL-GLOBALS>
        <MOVE ,01-LARGE-ROCK ,02-ROUND-ROOM>
        <RTRUE>
    )>
>

;"Room: PLAIN CUTE ------------------------------------------------------------"
<ROOM 15-PLAIN-CUTE
    (DESC "Plain Cute")
    (IN ROOMS)
    (LDESC 
"You are at Plain Cute. It's a large meadow full of flowers, butterflies and cute little bunny rabbits. The cuteness continues
to the south and west.")
    (EAST TO 16-REMARKABLE-SPOT)
    (WEST TO 14-PLAIN-CUTE)
    (SOUTH TO 18-PLAIN-CUTE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (FLOWER FLOWERS BUTTERFLIE BUTTERFLIES RABBIT RABBITS) STANDARD-F)>

;"Room: REMARKABLE SPOT -------------------------------------------------------"
<ROOM 16-REMARKABLE-SPOT
    (DESC "Remarkable Spot")
    (IN ROOMS)
    (LDESC 
"This is a remarkable spot in the dungeon. Remarkable, that is, because of its total lack of room description. More well-described
locations can be found to the east, west or south.")
    (EAST TO 02-ROUND-ROOM)
    (WEST TO 15-PLAIN-CUTE)
    (SOUTH TO 20-OLD-FARM)
    (FLAGS LIGHTBIT)>

;"Room: PLAIN CUTE ------------------------------------------------------------"
<ROOM 17-PLAIN-CUTE
    (DESC "Plain Cute")
    (IN ROOMS)
    (LDESC 
"You are almost choked by the cuteness as you walk in this seemingly endless meadow. However, a somewhat less cute place
appears to lie to the south.")
    (NORTH TO 14-PLAIN-CUTE)
    (SOUTH TO 21-SHORE)
    (EAST TO 18-PLAIN-CUTE)
    (FLAGS LIGHTBIT)>
     
;"Room: PLAIN CUTE ------------------------------------------------------------"
<ROOM 18-PLAIN-CUTE
    (DESC "Plain Cute")
    (IN ROOMS)
    (LDESC 
"You gaze across the meadow to find something ugly, or at least mediocre, but it is hopeless; the cuteness stretches in
all directions.")
    (NORTH TO 15-PLAIN-CUTE)
    (SOUTH TO 22-PLAIN-CUTE)
    (EAST TO 17-PLAIN-CUTE)
    (FLAGS LIGHTBIT)>

;"Room: FARMHOUSE -------------------------------------------------------------"
<ROOM 19-FARMHOUSE
    (DESC "Farmhouse")
    (IN ROOMS)
    (LDESC 
"You are in the farmhouse which contains Rance the Dungeonkeeper's headquarters. The house is cramped with monitors, headphones
and other electronic equipment with which he has complete superintendence over every room in the dungeon. On the walls are hanging
a multitude of disguises, which he uses when he's inspecting your eventual progresses. Rance is sitting at the table, probably
figuring out new problems for you to tackle. The exit lies to the east.")
    (EAST TO 20-OLD-FARM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (EQUIPMENT DISGUISES TABLE) STANDARD-F)>

;"Room: OLD FARM --------------------------------------------------------------"
<ROOM 20-OLD-FARM
    (DESC "Old Farm")
    (IN ROOMS)
    (LDESC 
"You are standing in an old farm, which by some peculiar reason is situated in the dungeon. The farm house lies to the west and to
the south lies a tool shed. In the middle of the yard is an approximately 30 ft. deep well.")
    (NORTH TO 16-REMARKABLE-SPOT)
    (SOUTH TO 23-TOOLSHED)
    (WEST PER OLD-FARM-WEST-EXIT)
    (DOWN PER OLD-FARM-DOWN-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WELL TOOLSHED SHED) STANDARD-F)>

<ROUTINE OLD-FARM-WEST-EXIT ()
    <COND (<AND <FSET? ,09-PAPERBAG ,WORNBIT> <NOT ,19-FARMHOUSE-FLAG>> <SETG ,07-PAPERBAG-COUNTER 5>)>
    <RETURN ,19-FARMHOUSE>
>

<ROUTINE OLD-FARM-DOWN-EXIT ()
    <COND (,18-WELL-FLAG 
        <TELL ,MESSAGE-057 CR CR>
        <SETG ,06-WELL2-COUNTER 1>
        <RETURN ,23-TOOLSHED>
    )
    (T
        <SETG ,05-WELL1-COUNTER 4>
        <RETURN ,50-WELL-BOTTOM>
    )>
    <RETURN ,19-FARMHOUSE>
>

;"Room: SHORE -----------------------------------------------------------------"
<ROOM 21-SHORE
    (DESC "At the Shore")
    (IN ROOMS)
    (LDESC 
"You are standing at the shore of a presumably large ocean. As this is a shore, and not an island, the water does not prevent
motion to the north or east.")
    (NORTH TO 17-PLAIN-CUTE)
    (EAST TO 22-PLAIN-CUTE)
    (IN PER SHORE-EXIT)
    (ACTION SHORE-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WATER OCEAN SEA) OCEAN-F)>

<ROUTINE SHORE-EXIT () <PERFORM V?SWIM> <RFALSE>>

<ROUTINE OCEAN-F ()
    <COND (<VERB? ENTER>
        <PERFORM V?SWIM>
        <RTRUE>
    )>
    <STANDARD-F>
>

<ROUTINE SHORE-F (RARG)
    <COND (<AND <=? .RARG ,M-BEG> <VERB? SWIM>>
        <COND (<=? <LOC ,31-YACHT> ,HERE>
            <TELL ,MESSAGE-113 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-114 CR>
            <RTRUE>
        )>
    )>    
>

;"Room: PLAIN CUTE ------------------------------------------------------------"
<ROOM 22-PLAIN-CUTE
    (DESC "Plain Cute")
    (IN ROOMS)
    (LDESC 
"You grit your teeth at the sight of more butterflies, flowers and bunny rabbits; you're still on Plain Cute.")
    (NORTH TO 18-PLAIN-CUTE)
    (WEST TO 21-SHORE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (FLOWER FLOWERS BUTTERFLIE BUTTERFLIES RABBIT RABBITS) STANDARD-F)>

;"Room: TOOLSHED --------------------------------------------------------------"
<ROOM 23-TOOLSHED
    (DESC "Toolshed")
    (IN ROOMS)
    (LDESC 
"You are in a toolshed at a farm. The exit lies to the north.")
    (NORTH TO 20-OLD-FARM)
    (FLAGS LIGHTBIT)>

;"Room: LIVING ROOM -----------------------------------------------------------"
<ROOM 24-LIVING-ROOM
    (DESC "Living Room")
    (IN ROOMS)
    (LDESC 
"You are in the old man's living room, which is furnished with a sofa, a table, a couple of armchairs and a TV set. The exit
lies to the south.")
    (SOUTH TO 25-BEDROOM)
    (ACTION LIVING-ROOM-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SOFA TABLE ARMCHAIR ARMCHAIRS) STANDARD-F)>

<ROUTINE LIVING-ROOM-F (RARG)
    <COND (<AND <=? .RARG ,M-BEG> <VERB? PUSH>>
        <COND (<AND <=? ,P-NUMBER 1> ,16-TV-FLAG>
            <TELL ,MESSAGE-067 CR>
            <SETG ,16-TV-FLAG <>>
            <RTRUE>
        )>
        <COND (<AND <=? ,P-NUMBER 1> <NOT ,16-TV-FLAG>>
            <TELL ,MESSAGE-068 CR>
            <RTRUE>
        )>
        <COND (<AND <=? ,P-NUMBER 2> ,16-TV-FLAG>
            <TELL ,MESSAGE-068 CR>
            <RTRUE>
        )>
        <COND (<AND <=? ,P-NUMBER 2> <NOT ,16-TV-FLAG>>
            <TELL ,MESSAGE-066 CR>
            <SETG ,16-TV-FLAG T>
            <RTRUE>
        )>
        <COND (<=? ,PRSO ,NUMBER>
            <TELL "You don't see that here." CR>
            <RTRUE>
        )>
    )>    
>

;"Room: BEDROOM ---------------------------------------------------------------"
<ROOM 25-BEDROOM
    (DESC "Bedroom")
    (IN ROOMS)
    (LDESC 
"You are in a bedroom carved out of the rock. There's a bed and a bedside table here. Passages lead north, south and west, and
a door leads east.")
    (NORTH TO 24-LIVING-ROOM)
    (SOUTH TO 27-BAR-AREA)
    (WEST TO 02-ROUND-ROOM)
    (EAST TO 26-NEW-JERSEY IF 12-NEW-JERSEY-DOOR-FLAG ELSE ,MESSAGE-036)
    (ACTION BEDROOM-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BED TABLE) STANDARD-F
            (<>) (DOOR) BEDROOM-DOOR-F)>

<ROUTINE BEDROOM-F (RARG)
    <COND (<=? .RARG ,M-BEG>
        ;"Adjust soundlevel..."
        <COND (<AND <NOT ,12-NEW-JERSEY-DOOR-FLAG> <NOT ,13-BLANKET-ON-BRUCE-FLAG>>
            ;"Door closed and no blanket"
            <MOVE ,34-SOUND ,LOCAL-GLOBALS>
            <MOVE ,35-MUFFLED-SOUND ,HERE>
            <MOVE ,15-OLD-MAN ,HERE>
            <MOVE ,16-OLD-MAN-SLEEPING ,LOCAL-GLOBALS>
            <RFALSE>
        )>
        <COND (<AND <NOT ,12-NEW-JERSEY-DOOR-FLAG> ,13-BLANKET-ON-BRUCE-FLAG>
            ;"Door closed and blanket"
            <MOVE ,34-SOUND ,LOCAL-GLOBALS>
            <MOVE ,35-MUFFLED-SOUND ,LOCAL-GLOBALS>
            <MOVE ,15-OLD-MAN ,LOCAL-GLOBALS>
            <MOVE ,16-OLD-MAN-SLEEPING ,HERE>
            <RFALSE>
        )>
        <COND (<AND ,12-NEW-JERSEY-DOOR-FLAG <NOT ,13-BLANKET-ON-BRUCE-FLAG>>
            ;"Door open and no blanket"
            <MOVE ,34-SOUND ,HERE>
            <MOVE ,35-MUFFLED-SOUND ,LOCAL-GLOBALS>
            <MOVE ,15-OLD-MAN ,HERE>
            <MOVE ,16-OLD-MAN-SLEEPING ,LOCAL-GLOBALS>
            <RFALSE>
        )>
        <COND (<AND ,12-NEW-JERSEY-DOOR-FLAG ,13-BLANKET-ON-BRUCE-FLAG>
            ;"Door open and blanket"
            <MOVE ,34-SOUND ,LOCAL-GLOBALS>
            <MOVE ,35-MUFFLED-SOUND ,HERE>
            <MOVE ,15-OLD-MAN ,HERE>
            <MOVE ,16-OLD-MAN-SLEEPING ,LOCAL-GLOBALS>
            <RFALSE>
        )>
    )>
    <COND (<AND <=? .RARG ,M-END> <NOT ,14-BRUCE-SPRINGSTEEN-FLAG>>
        <TELL CR ,MESSAGE-047 CR>
        <SETG ,14-BRUCE-SPRINGSTEEN-FLAG T>
        <RTRUE>
    )>
>

<ROUTINE BEDROOM-DOOR-F ()
    <COND (<VERB? OPEN>
        <COND (<AND <NOT ,12-NEW-JERSEY-DOOR-FLAG> <NOT ,13-BLANKET-ON-BRUCE-FLAG>>
            <TELL ,MESSAGE-038 CR>
            <MOVE ,35-MUFFLED-SOUND ,LOCAL-GLOBALS>
            <MOVE ,34-SOUND ,HERE>
            <SETG ,12-NEW-JERSEY-DOOR-FLAG T>
            <RTRUE>
        )>
        <COND (<AND <NOT ,12-NEW-JERSEY-DOOR-FLAG> ,13-BLANKET-ON-BRUCE-FLAG>
            <TELL ,MESSAGE-039 CR>
            <MOVE ,35-MUFFLED-SOUND ,HERE>
            <MOVE ,16-OLD-MAN-SLEEPING ,LOCAL-GLOBALS>
            <MOVE ,15-OLD-MAN ,HERE>
            <SETG ,12-NEW-JERSEY-DOOR-FLAG T>
            <RTRUE>
        )>
        <COND (,12-NEW-JERSEY-DOOR-FLAG
            <TELL ,MESSAGE-040 CR>
            <RTRUE>
        )>
    )>
    <COND (<VERB? CLOSE>
        <COND (<AND ,12-NEW-JERSEY-DOOR-FLAG <NOT ,13-BLANKET-ON-BRUCE-FLAG>>
            <TELL ,MESSAGE-042 CR>
            <MOVE ,35-MUFFLED-SOUND ,HERE>
            <MOVE ,34-SOUND ,LOCAL-GLOBALS>
            <SETG ,12-NEW-JERSEY-DOOR-FLAG <>>
            <RTRUE>
        )>
        <COND (<AND ,12-NEW-JERSEY-DOOR-FLAG ,13-BLANKET-ON-BRUCE-FLAG>
            <TELL ,MESSAGE-043 CR>
            <MOVE ,35-MUFFLED-SOUND ,LOCAL-GLOBALS>
            <MOVE ,16-OLD-MAN-SLEEPING ,HERE>
            <MOVE ,15-OLD-MAN ,LOCAL-GLOBALS>
            <SETG ,12-NEW-JERSEY-DOOR-FLAG <>>
            <RTRUE>
        )>
        <COND (<NOT ,12-NEW-JERSEY-DOOR-FLAG>
            <TELL ,MESSAGE-044 CR>
            <RTRUE>
        )>
    )>
    <COND (<VERB? EXAMINE> 
        <COND (,12-NEW-JERSEY-DOOR-FLAG
            <TELL ,MESSAGE-037 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-036 CR>
            <RTRUE>
        )>
    )>
>

;"Room: NEW JERSEY ------------------------------------------------------------"
<ROOM 26-NEW-JERSEY
    (DESC "New Jersey")
    (IN ROOMS)
    (LDESC 
"You are in New Jersey. A door to the west leads to a bedroom in the Werner Dungeon (very peculiar indeed).")
    (WEST TO 25-BEDROOM IF 12-NEW-JERSEY-DOOR-FLAG ELSE ,MESSAGE-036)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (DOOR) NEW-JERSEY-DOOR-F)>

<ROUTINE NEW-JERSEY-DOOR-F ()
    <COND (<VERB? OPEN>
        <COND (,12-NEW-JERSEY-DOOR-FLAG
            <TELL ,MESSAGE-040 CR>
            <RTRUE>
        )>
        <COND (<NOT ,12-NEW-JERSEY-DOOR-FLAG>
            <TELL ,MESSAGE-045 CR>
            <SETG ,12-NEW-JERSEY-DOOR-FLAG T>
            <RTRUE>
        )>
    )>
    <COND (<VERB? CLOSE>
        <COND (,12-NEW-JERSEY-DOOR-FLAG
            <TELL ,MESSAGE-041 CR>
            <SETG ,12-NEW-JERSEY-DOOR-FLAG <>>
            <RTRUE>
        )>
        <COND (<NOT ,12-NEW-JERSEY-DOOR-FLAG>
            <TELL ,MESSAGE-044 CR>
            <MOVE ,35-MUFFLED-SOUND ,LOCAL-GLOBALS>
        )>
    )>
    <COND (<VERB? EXAMINE> 
        <COND (,12-NEW-JERSEY-DOOR-FLAG
            <TELL ,MESSAGE-037 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-036 CR>
            <RTRUE>
        )>
    )>
>

;"Room: BAR AREA --------------------------------------------------------------"
<ROOM 27-BAR-AREA
    (DESC "Bar Area")
    (IN ROOMS)
    (LDESC 
"You are in a the bar area of the dungeon. This big cave is full of bars, all of which are tended by gnomes. You can go
north and south.")
    (NORTH TO 25-BEDROOM)
    (SOUTH TO 28-NS-PASSAGE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BAR BARS GNOME GNOMES) STANDARD-F)>

;"Room: NORTH-SOUTH PASSAGE ---------------------------------------------------"
<ROOM 28-NS-PASSAGE
    (DESC "North-South Passage")
    (IN ROOMS)
    (LDESC 
"You are in a north-south passage. To the east is a pompous doorway over which hangs a sign reading: \"The Werner Dungeon Museum
of Philately\".")
    (NORTH TO 27-BAR-AREA)
    (SOUTH TO 29-FOGGY-ROOM)
    (EAST TO 30-MUSEUM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (DOOR DOORWAY SIGN) STANDARD-F)>

;"Room: FOGGY ROOM ------------------------------------------------------------"
<ROOM 29-FOGGY-ROOM
    (DESC "Foggy Room")
    (IN ROOMS)
    (LDESC 
"You are in room filled with pea soup-like fog, which makes it impossible to see things further away than about 43 inches.")
    (NORTH TO 28-NS-PASSAGE)
    (SOUTH TO 32-ELEVATOR-CERISE IF 22-ELEVATOR-FLAG ELSE ,MESSAGE-085)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (FOG) STANDARD-F)>     

;"Room: MUSEUM  ---------------------------------------------------------------"
<ROOM 30-MUSEUM
    (DESC "Werner Dungeon Museum of Philately")
    (IN ROOMS)
    (LDESC 
"You are in the Werner Dungeon Museum of Philately, which has now been plundered and vandalised almost beyond recognition. The
only intact item is a pedestal in the center of the room, around which lies a large number of severely-burnt skeletons. On the
pedestal there is a plaque reading: \"The Philatelist's Stone, which turns ordinary stamps into yellow 3 skilling banco.\".
You notice that the ceiling is made of wooden planks. To the west lies a pompous doorway and a smaller door leads south.")
    (WEST TO 28-NS-PASSAGE)
    (SOUTH TO 31-ROYAL-PUZZLE-ENTRANCE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (PEDESTAL SKELETON SKELETONS PLAQUE DOOR DOORWAY CEILING) STANDARD-F)>  

;"Room: ROYAL PUZZLE ENTRANCE -------------------------------------------------"
<ROOM 31-ROYAL-PUZZLE-ENTRANCE
    (DESC "Royal Puzzle Entrance")
    (IN ROOMS)
    (LDESC 
"You are at the Royal Puzzle entrance, standing by a hole in the floor, which in all probability leads down to the Royal Puzzle.
To the north there is a door through which you can see the museum. In the ceiling, too high to reach, is an opening.")
    (NORTH TO 30-MUSEUM)
    (UP ,MESSAGE-083)
    (DOWN PER ROYAL-PUZZLE-ENTRANCE-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (HOLE FLOOR DOOR CEILING OPENING) STANDARD-F)> 

<ROUTINE ROYAL-PUZZLE-ENTRANCE-EXIT ()
    <COND (<NOT <=? <LOC ,36-SANDSTONE-BLOCK> ,HERE>> <RETURN ,38-ROYAL-PUZZLE>)>
    <TELL ,MESSAGE-078 CR>
    <RFALSE>
>

;"Room: ELEVATOR-CERISE -------------------------------------------------------"
<ROOM 32-ELEVATOR-CERISE
    (DESC "Elevator")
    (IN ROOMS)
    (LDESC 
"You are in an elevator. On the wall are three buttons in the unlikely colours cerise, ochre and purple. The cerise button is
glowing with a sickening glow.")
    (NORTH TO 29-FOGGY-ROOM)
    (FLAGS LIGHTBIT)> 

<OBJECT CERISE-ELEVATOR-BUTTON
	(IN 32-ELEVATOR-CERISE)
	(SYNONYM BUTTON)
    (ADJECTIVE CERISE)
	(DESC "cerise button")
    (ACTION CERISE-BUTTON-F)
    (FLAGS NDESCBIT)>

<OBJECT OCHRE-ELEVATOR-BUTTON
	(IN 32-ELEVATOR-CERISE)
	(SYNONYM BUTTON)
    (ADJECTIVE OCHRE)
	(DESC "ochre button")
    (ACTION OCHRE-BUTTON-F)
    (FLAGS NDESCBIT)>

<OBJECT PURPLE-ELEVATOR-BUTTON
	(IN 32-ELEVATOR-CERISE)
	(SYNONYM BUTTON)
    (ADJECTIVE PURPLE)
	(DESC "purple button")
    (ACTION PURPLE-BUTTON-F)
    (FLAGS NDESCBIT)>

<ROUTINE CERISE-BUTTON-F ()
    <COND (<AND <VERB? PUSH> <=? ,HERE ,32-ELEVATOR-CERISE>>
        <TELL ,MESSAGE-068 CR>
        <RTRUE>
    )
    (T
        <TELL ,MESSAGE-084 CR CR>
        <SETG ,22-ELEVATOR-FLAG T>
        <MOVE ,CERISE-ELEVATOR-BUTTON ,32-ELEVATOR-CERISE>
        <MOVE ,OCHRE-ELEVATOR-BUTTON ,32-ELEVATOR-CERISE>
        <MOVE ,PURPLE-ELEVATOR-BUTTON ,32-ELEVATOR-CERISE>
        <GOTO ,32-ELEVATOR-CERISE>
        <RTRUE>
    )>
>

<ROUTINE OCHRE-BUTTON-F ()
    <COND (<AND <VERB? PUSH> <=? ,HERE ,33-ELEVATOR-OCHRE>>
        <TELL ,MESSAGE-068 CR>
        <RTRUE>
    )
    (T
        <TELL ,MESSAGE-084 CR CR>
        <SETG ,22-ELEVATOR-FLAG <>>
        <MOVE ,CERISE-ELEVATOR-BUTTON ,33-ELEVATOR-OCHRE>
        <MOVE ,OCHRE-ELEVATOR-BUTTON ,33-ELEVATOR-OCHRE>
        <MOVE ,PURPLE-ELEVATOR-BUTTON ,33-ELEVATOR-OCHRE>
        <GOTO ,33-ELEVATOR-OCHRE>
        <RTRUE>
    )>
>

<ROUTINE PURPLE-BUTTON-F ()
    <COND (<AND <VERB? PUSH> <=? ,HERE ,34-ELEVATOR-PURPLE>>
        <TELL ,MESSAGE-068 CR>
        <RTRUE>
    )
    (T
        <TELL ,MESSAGE-084 CR CR>
        <SETG ,22-ELEVATOR-FLAG <>>
        <MOVE ,CERISE-ELEVATOR-BUTTON ,34-ELEVATOR-PURPLE>
        <MOVE ,OCHRE-ELEVATOR-BUTTON ,34-ELEVATOR-PURPLE>
        <MOVE ,PURPLE-ELEVATOR-BUTTON ,34-ELEVATOR-PURPLE>
        <GOTO ,34-ELEVATOR-PURPLE>
        <RTRUE>
    )>
>

;"Room: ELEVATOR-OCHRE --------------------------------------------------------"
<ROOM 33-ELEVATOR-OCHRE
    (DESC "Elevator")
    (IN ROOMS)
    (LDESC 
"You are in an elevator. On the wall are three buttons in the unlikely colours cerise, ochre and purple. The ochre button is
glowing with a sickening glow.")
    (NORTH TO 35-SMALL-ROOM)
    (FLAGS LIGHTBIT)> 

 ;"Room: ELEVATOR-CERISE ------------------------------------------------------"
<ROOM 34-ELEVATOR-PURPLE
    (DESC "Elevator")
    (IN ROOMS)
    (LDESC 
"You are in an elevator. On the wall are three buttons in the unlikely colours cerise, ochre and purple. The purple button is
glowing with a sickening glow.")
    (NORTH TO 36-VOLCANO-CHAMBER)
    (FLAGS LIGHTBIT)> 

;"Room: SMALL ROOM ------------------------------------------------------------"
<ROOM 35-SMALL-ROOM
    (DESC "Small Room")
    (IN ROOMS)
    (LDESC 
"You are in a small room whose floor consists of wooden planks. To the south lies an elevator.")
    (SOUTH TO 33-ELEVATOR-OCHRE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (ELEVATOR) STANDARD-F
            (WOODEN WOOD) (FLOOR PLANK PLANKS) FLOOR-F)>     

<ROUTINE FLOOR-F ()
    <COND (<VERB? SAW>
        <COND (<=? ,PRSI ,14-SAW>
            <TELL ,MESSAGE-086 CR CR>
            <GOTO ,37-PEDESTAL>
            <RTRUE>
        )>
    )>
    <STANDARD-F>
>

;"Room: VOLCANO CHAMBER -------------------------------------------------------"
<ROOM 36-VOLCANO-CHAMBER
    (DESC "Volcano Chamber")
    (IN ROOMS)
    (LDESC 
"You are in a chamber carved out of the wall of a volcano. To the north is an opening through which you can see the
aforementioned volcano, and to the south lies the elevator.")
    (SOUTH TO 34-ELEVATOR-PURPLE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (ELEVATOR VOLCANO OPENING) STANDARD-F)>    

;"Room: PEDESTAL --------------------------------------------------------------"
<ROOM 37-PEDESTAL
    (DESC "On Pedestal")
    (IN ROOMS)
    (LDESC 
"You are on the pedestal in the Werner Dungeon Museum of Philately. All around you, on the floor, are severely-burnt skeletons and there's a hole in the wooden ceiling.")
    (UP ,MESSAGE-083)
    (DOWN PER PEDESTAL-DOWN-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (HOLE CEILING PEDESTAL SKELETON SKELETONS) STANDARD-F)> 

<ROUTINE PEDESTAL-DOWN-F ()
    <JIGS-UP ,MESSAGE-087>
>

;"Room: ROYAL PUZZLE ----------------------------------------------------------"
<ROOM 38-ROYAL-PUZZLE
    (DESC "Royal Puzzle")
    (IN ROOMS)
    (LDESC 
"You are in the Royal Puzzle: a small room with sandstone walls. On one of the walls are two buttons;
a red one, marked \"Game\", and a green one, marked \"Demo\".|In the ceiling, too high to reach, is an opening.")
    (UP ,MESSAGE-083)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WALL WALLS CEILING OPENING) STANDARD-F)> 

<OBJECT GAME-BUTTON
	(IN 38-ROYAL-PUZZLE)
	(SYNONYM BUTTON)
    (ADJECTIVE RED GAME)
	(DESC "red button")
    (ACTION GAME-BUTTON-F)
    (FLAGS NDESCBIT)>

<OBJECT DEMO-BUTTON
	(IN 38-ROYAL-PUZZLE)
	(SYNONYM BUTTON)
    (ADJECTIVE GREEN DEMO)
	(DESC "green button")
    (ACTION DEMO-BUTTON-F)
    (FLAGS NDESCBIT)>

<ROUTINE GAME-BUTTON-F ()
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-079 CR CR>
        <GOTO ,39-ROYAL-PUZZLE>
        <RTRUE>
    )>
    <STANDARD-F>
>

<ROUTINE DEMO-BUTTON-F ()
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-080 CR CR>
        <MOVE ,36-SANDSTONE-BLOCK ,31-ROYAL-PUZZLE-ENTRANCE>
        <GOTO ,40-ROYAL-PUZZLE>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: ROYAL PUZZLE ----------------------------------------------------------"
<ROOM 39-ROYAL-PUZZLE
    (DESC "Royal Puzzle")
    (IN ROOMS)
    (LDESC 
"You are in the Royal Puzzle, surrounded by sandstone walls.")
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WALL WALLS) STANDARD-F)> 

;"Room: ROYAL PUZZLE ----------------------------------------------------------"
<ROOM 40-ROYAL-PUZZLE
    (DESC "Royal Puzzle")
    (IN ROOMS)
    (LDESC 
"You are in the Royal Puzzle, now arranged to form a north-south sandstone corridor, in whose northern end you stand.")
    (SOUTH TO 41-ROYAL-PUZZLE)
    (FLAGS LIGHTBIT)> 

;"Room: ROYAL PUZZLE ----------------------------------------------------------"
<ROOM 41-ROYAL-PUZZLE
    (DESC "Royal Puzzle")
    (IN ROOMS)
    (LDESC 
"You are at the southern end of the north-south corridor formed by the Royal Puzzle. A ladder leads up.")
    (NORTH TO 40-ROYAL-PUZZLE)
    (UP TO 49-SOUTH-END-NARROW-PASSAGE)
    (FLAGS LIGHTBIT)> 

;"Room: DANISH BAKERY ---------------------------------------------------------"
<ROOM 42-DANISH-BAKERY
    (DESC "Danish Bakery")
    (IN ROOMS)
    (LDESC 
"You are in the Danish Bakery. In the southern wall is set a large window, through which you can see a large number of trolls, ogres, dwarves,
peasants and adventure game players gazing into the room. The southern wall also features a handle-less door. Preben & Preben,
the two inebriate Danish pastry cooks, are here. You notice a vast quantity of bottles positioned near the two Danes.")
    (FLAGS LIGHTBIT)
    (ACTION DANISH-BAKERY-F)
    (THINGS (<>) (WINDOW TROLLS OGRES DWARFES PEASANT PLAYERS DOOR) STANDARD-F
            (<>) (BOTTLE BOTTLES) BOTTLE-F)> 

<ROUTINE BOTTLE-F ()
    <COND (<VERB? TAKE>
        <TELL ,MESSAGE-073 CR>
        <RTRUE>
    )>
    <STANDARD-F>
>

<ROUTINE DANISH-BAKERY-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <NOT ,20-PREBEN-FLAG>>
        <TELL CR ,MESSAGE-070 CR>
        <SETG ,20-PREBEN-FLAG T>
        <RTRUE>
    )>
>

;"Room: NORTHERN RAVINE -------------------------------------------------------"
<ROOM 43-NORTHERN-RAVINE
    (DESC "Northern End of Ravine")
    (IN ROOMS)
    (LDESC 
"You are at the northern end of the ravine. To the east lies a small cave.")
    (EAST TO 44-SMALL-CAVE)
    (SOUTH TO 45-SOUTHERN-RAVINE)
    (FLAGS LIGHTBIT)> 

;"Room: SMALL CAVE ------------------------------------------------------------"
<ROOM 44-SMALL-CAVE
    (DESC "Small Cave")
    (IN ROOMS)
    (LDESC 
"You are in the small cave. From the sentence scribbled on one of the walls, \"Arthur Dent was here\", you conclude that Arthur Dent
has been here, and that this might be the cave in which he lived during his visit to pre-historic earth. In one corner lies a pile
of furs, among which no trace of freak worm-holes in the space-time fabric can be found.")
    (WEST TO 43-NORTHERN-RAVINE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WALL WALLS FURS) STANDARD-F)> 

;"Room: SOUTHERN RAVINE -------------------------------------------------------"
<ROOM 45-SOUTHERN-RAVINE
    (DESC "Southern End of Ravine")
    (IN ROOMS)
    (LDESC 
"You are at the southern end of a ravine. To the west there is a hole in the rock wall.")
    (NORTH TO 43-NORTHERN-RAVINE)
    (WEST ,MESSAGE-075)
    (FLAGS LIGHTBIT)> 

;"Room: TOADSTOOL -------------------------------------------------------------"
<ROOM 46-TOADSTOOL
    (DESC "Inside Toadstool")
    (IN ROOMS)
    (LDESC 
"As this is Werner's Quest III, not Trinity, you aren't at any atom bomb test site, but inside the toadstool. The floor here
is covered with old leaves, inedible roots, edible roots (rotten), decay, rot, mould and general yeachhhiness.")
    (OUT TO 05-GREAT-HALL-NE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (FLOOR LEAVES ROOTS DECAY ROT YEACHHHINESS) TOADSTOOL-FLOOR-F)> 

<ROUTINE TOADSTOOL-FLOOR-F ()
    <COND (<AND <VERB? EXAMINE SEARCH> <NOT ,17-ZX-SPECTRUM-FLAG>>
        <TELL ,MESSAGE-048 CR>
        <MOVE ,05-ZX-SPECTRUM ,HERE>
        <SETG ,17-ZX-SPECTRUM-FLAG T>
        <THIS-IS-IT ,05-ZX-SPECTRUM>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: CUBICAL ROOM ----------------------------------------------------------"
<ROOM 47-CUBICAL-ROOM
    (DESC "Cubical Room")
    (IN ROOMS)
    (LDESC 
"You are in cubical room. A lever protrudes from one wall, and above hangs a sign reading: \"The Final Conquest\"")
    (FLAGS LIGHTBIT)
    (THINGS (<>) (LEVER) LEVER-F)> 

<ROUTINE LEVER-F ()
    <COND (<VERB? PULL>
        <COND (<NOT ,SCORE-PULL-LEVER-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-PULL-LEVER-FLAG T>)>
        <JIGS-UP ,MESSAGE-095>
        <RTRUE>
    )>
    <TELL ,MESSAGE-068 CR>
    <RTRUE>
>

;"Room: AT HOLE IN FLOOR ------------------------------------------------------"
<ROOM 48-AT-HOLE-IN-FLOOR
    (DESC "At Hole In Floor")
    (IN ROOMS)
    (LDESC 
"You are standing at a hole in the floor, through which you can see the entrance to the Royal Puzzle.")
    (SOUTH TO 49-SOUTH-END-NARROW-PASSAGE)
    (DOWN TO 31-ROYAL-PUZZLE-ENTRANCE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (OPENING FLOOR) STANDARD-F)> 

;"Room: SOUTH END NARROW PASSAGE ----------------------------------------------"
<ROOM 49-SOUTH-END-NARROW-PASSAGE
    (DESC "Southern End of Narrow North-South Passage")
    (IN ROOMS)
    (LDESC 
"You are in the southern end of a narrow north-south passage. At your feet is an opening throgh which a ladder emerges.")
    (NORTH TO 48-AT-HOLE-IN-FLOOR)
    (DOWN TO 41-ROYAL-PUZZLE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (OPENING LADDER) STANDARD-F)> 

;"Room: WELL BOTTOM -----------------------------------------------------------"
<ROOM 50-WELL-BOTTOM
    (DESC "At Hole In Floor")
    (IN ROOMS)
    (LDESC 
"You are at the bottom of the 30 ft. deep well, standing in 5 inches of lukewarm water.")
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WELL WATER) STANDARD-F)> 

;"-----------------------------------------------------------------------------
; OBJECTS
; -----------------------------------------------------------------------------"

;"Object: WALL ----------------------------------------------------------------"
<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS)
    (ADJECTIVE NORTH SOUTH EAST WEST N S E W)
	(DESC "surrounding wall")
    (ACTION WALL-F)
    (FLAGS NDESCBIT)>

<ROUTINE WALL-F ()
    <COND (<VERB? PUSH>
        <COND (<=? ,HERE ,39-ROYAL-PUZZLE>
            <TELL ,MESSAGE-096 CR>
            <RTRUE>
        )>
        <TELL ,MESSAGE-097 CR>
        <RTRUE>
    )>
    <STANDARD-F>
>    

;"Object: TV ------------------------------------------------------------------"
<OBJECT TV
	(IN 24-LIVING-ROOM)
	(SYNONYM TV SCREEN)
	(DESC "TV")
    (ACTION TV-F)
    (FLAGS NDESCBIT TOOLBIT)>

<ROUTINE TV-F ()
    <COND (<VERB? EXAMINE>
        <COND (,16-TV-FLAG
            <TELL ,MESSAGE-031 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-030 CR>
            <RTRUE>
        )>
    )>
    <COND (<VERB? TOUCH>
        <COND (,16-TV-FLAG
            <TELL ,MESSAGE-069 CR CR>
            <SETG ,08-RAVINE-COUNTER 15>
            <GOTO ,45-SOUTHERN-RAVINE>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-069 CR CR>
            <GOTO ,42-DANISH-BAKERY>
            <RTRUE>
        )>
    )>
>

;"Object: PREBEN & PREBEN -----------------------------------------------------"
<OBJECT PREBEN
	(IN 42-DANISH-BAKERY)
	(SYNONYM PREBEN COOK COOKS DANE DANES BAKER BAKERS)
    (ADJECTIVE DANISH PASTRY)
	(DESC "Preben & Preben")
    (ACTION PREBEN-F)
	(FLAGS NDESCBIT PERSONBIT NARTICLEBIT)>

<ROUTINE PREBEN-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,PREBEN>
        <TELL "You are plainly ignored." CR>
        <RTRUE>
    )>
>

;"Object: JOHN TAYLOR ---------------------------------------------------------"
<OBJECT JOHN-TAYLOR
	(IN 21-SHORE)
	(SYNONYM JOHN TAYLOR)
	(DESC "John Taylor")
    (ACTION JOHN-TAYLOR-F)
	(FLAGS NDESCBIT PERSONBIT NARTICLEBIT)>

<ROUTINE JOHN-TAYLOR-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<OR <=? ,WINNER ,JOHN-TAYLOR> <=? ,PRSO ,JOHN-TAYLOR>>
        <COND (<VERB? HELLO>
            <TELL ,MESSAGE-063 " " ,MESSAGE-064 CR>
            <MOVE ,31-YACHT ,LOCAL-GLOBALS>
            <MOVE ,JOHN-TAYLOR ,LOCAL-GLOBALS>
            <MOVE ,30-ALBUM ,HERE>
            <RTRUE>
        )>
        <COND (<=? ,WINNER ,JOHN-TAYLOR>
            <TELL "You are plainly ignored." CR>
            <RTRUE>
        )>
    )>
>

;"Object: LARGE ROCK ----------------------------------------------------------"
<OBJECT 01-LARGE-ROCK
	(IN 02-ROUND-ROOM)
	(SYNONYM ROCK SLOT)
    (ADJECTIVE LARGE)
	(DESC "large rock")
    (TEXT ,MESSAGE-012)
    (FLAGS CONTBIT)>

;"Object: LARGE ROCK WITH SPOON -----------------------------------------------"
<OBJECT 02-LARGE-ROCK-WITH-SPOON
	(IN LOCAL-GLOBALS)
	(SYNONYM ROCK)
    (ADJECTIVE LARGE)
	(DESC "large rock, in which is embedded an over-sized, chrome spoon")>

;"Object: CHROME SPOON --------------------------------------------------------"
<OBJECT 03-CHROME-SPOON
	(IN 01-ESCALATOR-BOTTOM)
	(SYNONYM SPOON)
    (ADJECTIVE OVER-SIZED OVERSIZED CHROME)
	(DESC "your old friend, the over-sized, chrome spoon")
    (ACTION SPOON-F)
    (FLAGS TAKEBIT NARTICLEBIT)>

<ROUTINE SPOON-F ()
    <COND (<AND <VERB? INSERT> <=? ,PRSI <> <=? <LOC ,01-LARGE-ROCK> ,HERE>>>
        <TELL "[in the large rock]" CR> 
        <SETG ,PRSI ,01-LARGE-ROCK>
        <COND (<NOT ,SCORE-INSERT-SPOON-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-INSERT-SPOON-FLAG T>)>
    )>
    <COND (<AND <VERB? INSERT> <=? ,PRSI ,01-LARGE-ROCK>>
        <COND (,11-STONE-DOOR-FLAG
            <TELL ,MESSAGE-035 CR>
        )
        (T
            <TELL ,MESSAGE-034 CR>
        )>
        <MOVE ,01-LARGE-ROCK ,LOCAL-GLOBALS>
        <MOVE ,03-CHROME-SPOON ,HERE>
        <FSET ,03-CHROME-SPOON ,NDESCBIT>
        <MOVE ,02-LARGE-ROCK-WITH-SPOON ,02-ROUND-ROOM>
        <SETG ,11-STONE-DOOR-FLAG T>
        <RTRUE>
    )>
    <COND (<AND <VERB? TAKE> <=? <LOC ,02-LARGE-ROCK-WITH-SPOON> ,HERE>>
        <MOVE ,02-LARGE-ROCK-WITH-SPOON ,LOCAL-GLOBALS>
        <MOVE ,01-LARGE-ROCK ,HERE>
        <MOVE ,03-CHROME-SPOON ,WINNER>
        <FCLEAR ,03-CHROME-SPOON ,NDESCBIT>
        <TELL ,MESSAGE-003 CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? DROP> <=? <LOC ,06-THING-FISH> ,HERE> <HELD? ,03-CHROME-SPOON>>
        <TELL ,MESSAGE-050 CR>
        <RTRUE>
    )>
>

;"Object: PLASTIC GNOME -------------------------------------------------------"
<OBJECT 04-PLASTIC-GNOME
	(IN 06-GREAT-HALL-W)
	(SYNONYM GNOME)
    (ADJECTIVE PLASTIC)
	(DESC "wheel-equipped plastic gnome, its index finger stretched out, which is posed on the rails")
    (TEXT ,MESSAGE-013)>

;"Object: ZX SPECTRUM ---------------------------------------------------------"
<OBJECT 05-ZX-SPECTRUM
	(IN LOCAL-GLOBALS)
	(SYNONYM SPECTRUM COMPUTER)
    (ADJECTIVE ZX)
	(DESC "ZX Spectrum")
    (TEXT ,MESSAGE-014)
    (ACTION SPECTRUM-F)
    (FLAGS TAKEBIT)>

<ROUTINE SPECTRUM-F ()
    <COND (<AND <VERB? CONNECT> <HELD? ,05-ZX-SPECTRUM> <=? ,HERE ,24-LIVING-ROOM>>
        <TELL ,MESSAGE-098 CR>
        <RTRUE>
    )>
    <COND (<VERB? TAKE>
        <COND (<NOT ,SCORE-ZX-SPECTRUM-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ZX-SPECTRUM-FLAG T>)>
        <RFALSE>
    )>
>

;"Object: THING-FISH ----------------------------------------------------------"
<OBJECT 06-THING-FISH
	(IN 14-PLAIN-CUTE)
	(SYNONYM THING-FISH THINGFISH PERSON)
	(DESC "thing that breaks the monotone cuteness of this place: A vaguely familiar person, wearing a skirt, large white gloves and a napkin is standing here, wearing a brown paperbag with peepholes over his head")
    (ACTION THING-FISH-F)
    (FLAGS PERSONBIT ATTACKBIT)>

<ROUTINE THING-FISH-F ()
    <COND (<VERB? ATTACK>
        <TELL ,MESSAGE-051 CR>
        <MOVE ,06-THING-FISH ,LOCAL-GLOBALS>
        <MOVE ,07-UNCONSCIOUS-THING-FISH ,HERE>
        <MOVE ,09-PAPERBAG ,HERE>
    )>
>

;"Object: UNCONSCIOUS THING-FISH ----------------------------------------------"
<OBJECT 07-UNCONSCIOUS-THING-FISH
	(IN LOCAL-GLOBALS)
	(SYNONYM THING-FISH THINGFISH PERSON)
	(DESC "The bag-wearing person, lying in the grass, seemingly unconscious")
    (ACTION UNCONSCIOUS-THING-FISH-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE UNCONSCIOUS-THING-FISH-F ()
    <COND (<VERB? WAKE>
        <TELL ,MESSAGE-115 CR>
        <RTRUE>
    )>
>

;"Object: BASKETBALL ----------------------------------------------------------"
<OBJECT 08-BASKETBALL
	(IN LOCAL-GLOBALS)
	(SYNONYM BASKETBALL BALL)
	(DESC "basketball")
    (FLAGS TAKEBIT)>

;"Object: PAPERBAG ------------------------------------------------------------"
<OBJECT 09-PAPERBAG
	(IN 14-PLAIN-CUTE)
	(SYNONYM BAG PAPERBAG)
	(DESC "brown paperbag with peepholes in it")
    (ACTION PAPERBAG-F)
    (FLAGS NDESCBIT)>

<ROUTINE PAPERBAG-F ()
    <COND (<AND <VERB? TAKE> <=? <LOC ,06-THING-FISH> ,HERE>>
        <TELL ,MESSAGE-004 CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? TAKE> <=? <LOC ,07-UNCONSCIOUS-THING-FISH> ,HERE>>
        <TELL ,MESSAGE-005 CR>
        <MOVE ,07-UNCONSCIOUS-THING-FISH ,LOCAL-GLOBALS>
        <FCLEAR ,09-PAPERBAG ,NDESCBIT>
        <FSET ,09-PAPERBAG ,TAKEBIT>
        <MOVE ,09-PAPERBAG ,WINNER>
        <COND (<NOT ,SCORE-PAPERBAG-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-PAPERBAG-FLAG T>)>
        <RTRUE>
    )>
    <COND (<AND <VERB? WEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT>>
        <TELL ,SYSMESSAGE-029 CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? WEAR> <HELD? ,PRSO> <NOT <FSET? ,PRSO ,WORNBIT>> <NOT <FSET? ,PRSO ,NDESCBIT>>>
        <TELL ,MESSAGE-009 CR>
        <FSET ,09-PAPERBAG ,WORNBIT>
        <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT> <=? ,HERE ,19-FARMHOUSE>>
        <FCLEAR ,09-PAPERBAG ,WORNBIT>
        <TELL ,MESSAGE-062 CR>
        <SETG ,07-PAPERBAG-COUNTER 0>
        <SETG ,19-FARMHOUSE-FLAG <>>
        <GOTO ,20-OLD-FARM>
        <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <NOT <FSET? ,PRSO ,WORNBIT>>>
        <TELL ,SYSMESSAGE-023 CR>
         <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT>>
        <FCLEAR ,09-PAPERBAG ,WORNBIT>
        <TELL ,MESSAGE-010 CR>
         <RTRUE>
    )>
>

;"Object: CLOTHLINE -----------------------------------------------------------"
<OBJECT 10-CLOTHLINE
	(IN 20-OLD-FARM)
	(SYNONYM LINE CLOTHLINE)
	(DESC "clothes line stretching from the farmhouse to the tool shed. On the clothesline is hanging a blanket")
    (ACTION CLOTHLINE-F)>

<ROUTINE CLOTHLINE-F ()
    <COND (<VERB? TAKE>
        <TELL ,MESSAGE-006 CR>
        <RTRUE>
    )>
>

;"Object: BLANKET -------------------------------------------------------------"
<OBJECT 11-BLANKET
	(IN 20-OLD-FARM)
	(SYNONYM BLANKET)
	(DESC "blanket")
    (ACTION BLANKET-F)
    (FLAGS TAKEBIT NDESCBIT)>

<ROUTINE BLANKET-F ()
    <COND (<AND <VERB? TAKE> <=? <LOC ,10-CLOTHLINE> ,HERE>>
        <MOVE ,10-CLOTHLINE ,LOCAL-GLOBALS>
        <MOVE ,11-BLANKET ,HERE>
        <FCLEAR ,11-BLANKET ,NDESCBIT>
        <MOVE ,12-EMPTY-CLOTHLINE ,HERE>
    )> 
    <COND (<AND <VERB? TAKE> <=? <LOC ,18-COVERED-BRUCE-SPRINGSTEEN> ,HERE>>
        <MOVE ,18-COVERED-BRUCE-SPRINGSTEEN ,LOCAL-GLOBALS>
        <MOVE ,17-BRUCE-SPRINGSTEEN ,HERE>
        <TELL ,MESSAGE-007 CR>
        <MOVE ,11-BLANKET ,WINNER>
        <FCLEAR ,11-BLANKET ,NDESCBIT>
        <MOVE ,35-MUFFLED-SOUND ,LOCAL-GLOBALS>
        <MOVE ,34-SOUND ,25-BEDROOM>
        <MOVE ,16-OLD-MAN-SLEEPING ,LOCAL-GLOBALS>
        <MOVE ,15-OLD-MAN ,25-BEDROOM>
        <SETG ,13-BLANKET-ON-BRUCE-FLAG <>>
        <RTRUE>
    )> 
    <COND (<AND <VERB? PUT-ON> <=? ,PRSI ,17-BRUCE-SPRINGSTEEN>>
        <TELL ,MESSAGE-046 CR>
        <MOVE ,17-BRUCE-SPRINGSTEEN ,LOCAL-GLOBALS>
        <MOVE ,18-COVERED-BRUCE-SPRINGSTEEN ,HERE>
        <MOVE ,11-BLANKET ,HERE>
        <FSET ,11-BLANKET ,NDESCBIT>
        <MOVE ,34-SOUND ,LOCAL-GLOBALS>
        <MOVE ,35-MUFFLED-SOUND ,25-BEDROOM>
        <SETG ,13-BLANKET-ON-BRUCE-FLAG T>
        <RTRUE>
    )> 
    <COND (<AND <VERB? PUT-ON> <=? ,PRSI ,12-EMPTY-CLOTHLINE>>
        <TELL ,MESSAGE-102 CR>
        <MOVE ,11-BLANKET ,HERE>
        <FSET ,11-BLANKET ,NDESCBIT>
        <MOVE ,12-EMPTY-CLOTHLINE ,LOCAL-GLOBALS>
        <MOVE ,10-CLOTHLINE ,HERE>
        <RTRUE>
    )> 
>

;"Object: EMPTY CLOTHLINE -----------------------------------------------------"
<OBJECT 12-EMPTY-CLOTHLINE
	(IN LOCAL-GLOBALS)
	(SYNONYM LINE CLOTHLINE)
	(DESC "clothes line stretching from the farmhouse to the tool shed")
    (ACTION CLOTHLINE-F)
    (FLAGS SURFACEBIT)>

;"Object: LADDER --------------------------------------------------------------"
<OBJECT 13-LADDER
	(IN 23-TOOLSHED)
	(SYNONYM LADDER)
	(DESC "ladder")
    (ACTION LADDER-F)
    (FLAGS TAKEBIT)>

<ROUTINE LADDER-F ()
    <COND (<AND <VERB? DROP> <=? ,HERE ,05-GREAT-HALL-NE>>
        <MOVE ,13-LADDER ,LOCAL-GLOBALS>
        <MOVE ,33-LADDER-AGAINST-TOADSTOOL ,HERE>
        <TELL ,MESSAGE-011 CR>
    )>
>

;"Object: SAW -----------------------------------------------------------------"
<OBJECT 14-SAW
	(IN 23-TOOLSHED)
	(SYNONYM SAW)
	(DESC "saw")
    (FLAGS TAKEBIT TOOLBIT)>

;"Object: OLD MAN -------------------------------------------------------------"
<OBJECT 15-OLD-MAN
	(IN 25-BEDROOM)
	(SYNONYM MAN)
	(DESC "The old man from your vision in the beginning of the game, lying in the bed")
    (TEXT ,MESSAGE-015)
    (ACTION OLD-MAN-F)
    (FLAGS NARTICLEBIT PERSONBIT)>

<ROUTINE OLD-MAN-F ()
    <COND (<VERB? WAKE>
        <TELL ,MESSAGE-092 CR>
        <RTRUE>
    )>
>

;"Object: OLD MAN SLEEPING ----------------------------------------------------"
<OBJECT 16-OLD-MAN-SLEEPING
	(IN LOCAL-GLOBALS)
	(SYNONYM MAN)
	(DESC "The old man, lying in the bed, fast asleep")
    (TEXT ,MESSAGE-016)
    (ACTION OLD-MAN-SLEEPING-F)
    (FLAGS NARTICLEBIT PERSONBIT)>

<ROUTINE OLD-MAN-SLEEPING-F ()
    <COND (<VERB? WAKE>
        <COND (<AND <HELD? ,05-ZX-SPECTRUM> 
                    <HELD? ,08-BASKETBALL>
                    <HELD? ,09-PAPERBAG>
                    <HELD? ,26-YELLOW-STAMP>
                    <HELD? ,27-SALAMI>
                    <HELD? ,29-DANISH-PASTRY>
                    <HELD? ,30-ALBUM>>
            <TELL ,MESSAGE-091 CR CR ,MESSAGE-094 CR CR>
            <GOTO ,47-CUBICAL-ROOM>
            <COND (<NOT ,SCORE-WAKE-MAN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-WAKE-MAN-FLAG T>)>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-091 CR CR ,MESSAGE-093 CR CR>
            <GOTO ,02-ROUND-ROOM>
            <COND (<NOT ,SCORE-WAKE-MAN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-WAKE-MAN-FLAG T>)>
            <RTRUE>
        )>
        <RTRUE>
    )>
>

;"Object: BRUCE SPRINGSTEEN ---------------------------------------------------"
<OBJECT 17-BRUCE-SPRINGSTEEN
	(IN 26-NEW-JERSEY)
	(SYNONYM BRUCE SPRINGSTEEN)
	(DESC "Bruce Springsteen, singing \"Cover Me\"")
    (TEXT ,MESSAGE-017)
    (FLAGS NARTICLEBIT PERSONBIT SURFACEBIT)>

;"Object: COVERED BRUCE SPRINGSTEEN -------------------------------------------"
<OBJECT 18-COVERED-BRUCE-SPRINGSTEEN
	(IN LOCAL-GLOBALS)
	(SYNONYM BRUCE SPRINGSTEEN)
	(DESC "Bruce Springsteen, covered with a blanket which somewhat muffles his song")
    (TEXT ,MESSAGE-018)
    (FLAGS NARTICLEBIT PERSONBIT)>

;"Object: COIN ----------------------------------------------------------------"
<OBJECT 19-COIN
	(IN 50-WELL-BOTTOM)
	(SYNONYM COIN ZORKMID MONEY)
	(DESC "0.038 zorkmid coin")
    (FLAGS TAKEBIT)>

;"Object: DRINK ---------------------------------------------------------------"
<OBJECT 20-DRINK
	(IN 27-BAR-AREA)
	(SYNONYM DRINK)
	(DESC "drink")
    (ACTION DRINK-F)
    (FLAGS NDESCBIT)>

<ROUTINE DRINK-F ()
    <COND (<AND <VERB? BUY> <HELD? ,19-COIN>>
        <TELL ,MESSAGE-071 CR>
        <MOVE ,19-COIN ,LOCAL-GLOBALS>
        <MOVE ,20-DRINK ,WINNER>
        <FSET ,20-DRINK ,TAKEBIT>
        <FCLEAR ,20-DRINK ,NDESCBIT>
        <RTRUE>
    )>
    <COND (<AND <VERB? DRINK> <HELD? ,PRSO>>
        <TELL ,MESSAGE-103 CR>
        <MOVE ,20-DRINK ,LOCAL-GLOBALS>
        <RTRUE>
    )>
    <COND (<VERB? GIVE> 
        <COND (<HELD? ,PRSO>
            <COND (<AND <=? ,HERE ,42-DANISH-BAKERY> <=? ,PRSI ,PREBEN>>
                <TELL ,MESSAGE-074 CR CR>
                <MOVE ,20-DRINK ,LOCAL-GLOBALS>
                <MOVE ,29-DANISH-PASTRY ,PLAYER>
                <COND (<NOT ,SCORE-DANISH-PASTRY-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-DANISH-PASTRY-FLAG T>)>
                <GOTO ,02-ROUND-ROOM>
                <RTRUE>
            )>
        )>
    )>
   <COND (<AND <VERB? EXAMINE> <FSET? ,PRSO ,NDESCBIT>> 
        <TELL "You don't see that here." CR>
        <RTRUE>
    )>
>

;"Object: PLASTIC GNOME -------------------------------------------------------"
<OBJECT 21-PLASTIC-GNOME
	(IN LOCAL-GLOBALS)
	(SYNONYM GNOME)
    (ADJECTIVE PLASTIC)
	(DESC "The plastic gnome, standing on the rails, its oustretched index finger pointing at the white door in the stem of the toadstool, which is open")
    (TEXT ,MESSAGE-019)
    (FLAGS NARTICLEBIT)>
 
;"Object: STONE ON PEDESTAL ----------------------------------------------------"
<OBJECT 22-STONE-ON-PEDESTAL
	(IN 30-MUSEUM)
	(SYNONYM STONE)
    (ADJECTIVE PHILATELIST\'S)
	(DESC "stone, lying on the pedestal")
    (TEXT ,MESSAGE-020)
    (ACTION STONE-ON-PEDESTAL-F)
    (FLAGS TAKEBIT)>

<ROUTINE STONE-ON-PEDESTAL-F ()
    <COND (<VERB? TAKE>
        <JIGS-UP ,MESSAGE-008>
        <RTRUE>
    )>
>

;"Object: STONE ---------------------------------------------------------------"
<OBJECT 23-STONE
	(IN 37-PEDESTAL)
	(SYNONYM STONE)
    (ADJECTIVE PHILATELIST\'S)
	(DESC "stone")
    (TEXT ,MESSAGE-020)
    (ACTION STONE-F)
    (FLAGS TAKEBIT)>

<ROUTINE STONE-F ()
    <COND (<VERB? TAKE>
        <MOVE ,22-STONE-ON-PEDESTAL ,LOCAL-GLOBALS>
    )>
    <COND (<AND <VERB? DROP> <=? ,HERE ,37-PEDESTAL> <HELD? ,PRSO>>
        <MOVE ,22-STONE-ON-PEDESTAL ,30-MUSEUM>
        <RFALSE>
    )>
    <COND (<VERB? TOUCH-WITH>
        <COND (<=? ,PRSO ,23-STONE>
            <COND (<=? ,PRSI ,25-GREEN-STAMP>
                <TELL ,MESSAGE-088 CR>
                <MOVE ,25-GREEN-STAMP ,LOCAL-GLOBALS>
                <MOVE ,26-YELLOW-STAMP ,WINNER>
                <COND (<NOT ,SCORE-YELLOW-STAMP-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-YELLOW-STAMP-FLAG T>)>
                <RTRUE>
            )>
            <COND (<=? ,PRSI ,26-YELLOW-STAMP>
                <TELL ,MESSAGE-089 CR>
                <RTRUE>
            )>
        )>
    )>
>

;"Object: CERISE BOOK ---------------------------------------------------------"
<OBJECT 24-CERISE-BOOK
	(IN 36-VOLCANO-CHAMBER)
	(SYNONYM BOOK)
    (ADJECTIVE CERISE)
	(DESC "cerise book")
    (ACTION CERISE-BOOK-F)
    (FLAGS TAKEBIT READBIT)>

<ROUTINE CERISE-BOOK-F ()
    <COND (<VERB? EXAMINE READ>
        <COND (,15-BOOK-FLAG
            <TELL ,MESSAGE-021 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-021 CR CR ,MESSAGE-022 CR>
            <MOVE ,25-GREEN-STAMP ,HERE>
            <SETG ,15-BOOK-FLAG T>
            <RTRUE>
        )>
    )>
>

;"Object: GREEN STAMP ---------------------------------------------------------"
<OBJECT 25-GREEN-STAMP
	(IN LOCAL-GLOBALS)
	(SYNONYM STAMP BANCO)
    (ADJECTIVE GREEN SKILLING)
	(DESC "green 3 skilling banco stamp")
    (ACTION STAMP-F)
    (FLAGS TAKEBIT)>

<ROUTINE STAMP-F ()
    <COND (<AND <VERB? TOUCH-WITH> <=? ,PRSI ,23-STONE>> <PERFORM V?TOUCH-WITH ,PRSI ,PRSO> <RTRUE>)>
    <COND (<AND <VERB? TOUCH> <HELD? ,23-STONE>> <TELL "[with the stone]" CR> <PERFORM V?TOUCH-WITH ,23-STONE ,PRSO> <RTRUE>)>
    <COND (<AND <VERB? TOUCH TOUCH-WITH> <OR <=? ,PRSO ,25-GREEN-STAMP> <=? ,PRSO ,26-YELLOW-STAMP>>> <TELL ,MESSAGE-090 CR> <RTRUE>)>
>

;"Object: YELLOW STAMP --------------------------------------------------------"
<OBJECT 26-YELLOW-STAMP
	(IN LOCAL-GLOBALS)
	(SYNONYM STAMP BANCO)
    (ADJECTIVE YELLOW SKILLING)
	(DESC "yellow 3 skilling banco stamp")
    (ACTION STAMP-F)
    (FLAGS TAKEBIT)>

;"Object: SALAMI --------------------------------------------------------------"
<OBJECT 27-SALAMI
	(IN 41-ROYAL-PUZZLE)
	(SYNONYM SALAMI SAUSAGE)
	(DESC "salami sausage")
    (TEXT ,MESSAGE-023)
    (ACTION SALAMI-F)
    (FLAGS TAKEBIT EDIBLEBIT)>

<ROUTINE SALAMI-F ()
    <COND (<AND <VERB? EAT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-105 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <RTRUE>
    )>
    <COND (<VERB? TAKE>
        <COND (<NOT ,SCORE-SALAMI-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-SALAMI-FLAG T>)>
        <RFALSE>
    )>
>

;"Object: PRINTOUT ------------------------------------------------------------"
<OBJECT 28-PRINTOUT
	(IN LOCAL-GLOBALS)
	(SYNONYM PRINTOUT LISTING)
	(DESC "printout")
    (TEXT ,MESSAGE-024)
    (FLAGS TAKEBIT READBIT)>

;"Object: DANISH PASTRY -------------------------------------------------------"
<OBJECT 29-DANISH-PASTRY
	(IN LOCAL-GLOBALS)
	(SYNONYM PASTRY COOKIE)
    (ADJECTIVE DANISH)
	(DESC "Danish pastry")
    (TEXT ,MESSAGE-025)
    (ACTION DANISH-PASTRY-F)
    (FLAGS TAKEBIT EDIBLEBIT)>

<ROUTINE DANISH-PASTRY-F ()
    <COND (<AND <VERB? EAT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-104 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <RTRUE>
    )>
>

;"Object: ALBUM ---------------------------------------------------------------"
<OBJECT 30-ALBUM
	(IN LOCAL-GLOBALS)
	(SYNONYM ALBUM)
    (ADJECTIVE DURAN)
	(DESC "Duran Duran album")
    (TEXT ,MESSAGE-026)
    (ACTION ALBUM-F)
    (FLAGS TAKEBIT)>

<ROUTINE ALBUM-F ()
    <COND (<VERB? TAKE>
        <COND (<NOT ,SCORE-ALBUM-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ALBUM-FLAG T>)>
        <RFALSE>
    )>
>
;"Object: YACHT ---------------------------------------------------------------"
<OBJECT 31-YACHT
	(IN 21-SHORE)
	(SYNONYM YACHT BOAT)
    (TEXT ,MESSAGE-027)
	(DESC "yacht, on which stands John Taylor of Duran Duran")>

;"Object: DEVICE --------------------------------------------------------------"
<OBJECT 32-DEVICE
	(IN 44-SMALL-CAVE)
	(SYNONYM DEVICE)
    (ADJECTIVE SMALL BLACK)
	(DESC "small black device")
    (TEXT ,MESSAGE-028)
    (FLAGS TAKEBIT)>

<OBJECT RED-BUTTON
	(IN LOCAL-GLOBALS)
	(SYNONYM BUTTON)
    (ADJECTIVE LARGE RED)
	(DESC "large red button")
    (ACTION RED-BUTTON-F)
    (FLAGS NDESCBIT)>

<ROUTINE RED-BUTTON-F ()
    <COND (<AND <VERB? PUSH> <HELD? ,32-DEVICE>>
        <COND (,21-DEVICE-FLAG
            <TELL ,MESSAGE-082 CR>
        )
        (T
            <TELL ,MESSAGE-081 CR CR>
            <SETG ,21-DEVICE-FLAG T>
            <MOVE-INVENTORY ,PLAYER ,02-ROUND-ROOM>         ;"Move all in inventory to Round Room"
            <GOTO ,02-ROUND-ROOM>
        )>
    )>
>

<ROUTINE MOVE-INVENTORY (SRC DST "AUX" X N)
    <SET X <FIRST? .SRC>>
    <REPEAT ()
        <COND (.X
            <SET N <NEXT? .X>>
            <MOVE .X .DST>
            <SET X .N>
        )
        (T
            <RETURN>
        )>
    >
>

;"Object: LADDER AGAINST TOADSTOOL --------------------------------------------"
<OBJECT 33-LADDER-AGAINST-TOADSTOOL
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(DESC "The ladder, leaning against the toadstool")
    (ACTION LADDER-AGAINST-TOADSTOOL-F)
    (FLAGS TAKEBIT NARTICLEBIT)>

<ROUTINE LADDER-AGAINST-TOADSTOOL-F ()
    <COND (<AND <VERB? TAKE> <=? <LOC ,33-LADDER-AGAINST-TOADSTOOL> ,HERE>>
        <MOVE ,33-LADDER-AGAINST-TOADSTOOL ,LOCAL-GLOBALS>
        <MOVE ,13-LADDER ,WINNER>
        <TELL ,MESSAGE-001 CR>
        <RTRUE>
    )>
>

;"Object: SOUND ---------------------------------------------------------------"
<OBJECT 34-SOUND
	(IN 25-BEDROOM)
	(SYNONYM SOUND)
	(DESC "The sound of Bruce Springsteen singing \"Cover Me\" drifts in through the door")
    (FLAGS NARTICLEBIT)>

;"Object: MUFFLED SOUND -------------------------------------------------------"
<OBJECT 35-MUFFLED-SOUND
	(IN LOCAL-GLOBALS)
	(SYNONYM SOUND)
    (ADJECTIVE MUFFLED)
	(DESC "Through the door, albeit somewhat muffled, drifts the unmistakable voice of Bruce Springsteen")
    (FLAGS NARTICLEBIT)>

;"Object: SANDSTONE BLOCK -----------------------------------------------------"
<OBJECT 36-SANDSTONE-BLOCK
	(IN LOCAL-GLOBALS)
	(SYNONYM BLOCK)
    (ADJECTIVE SANDSTONE)
	(DESC "sandstone block, blocking the hole")>

;"-----------------------------------------------------------------------------
; ACTIONS
; -----------------------------------------------------------------------------"

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

<ROUTINE STANDARD-F ()
    <COND (<VERB? EXAMINE> 
        <V-EXAMINE>
        <RTRUE>
    )>
>

;"-----------------------------------------------------------------------------
; INTERRUPTIONS
; -----------------------------------------------------------------------------"

<ROUTINE I-EVERY-TURN ()

    ;"Check Rance's reaction in Farmhouse"
    <COND (<AND <=? ,HERE ,19-FARMHOUSE> <NOT <FSET? ,09-PAPERBAG ,WORNBIT>>> 
        <TELL CR ,MESSAGE-059 CR CR>
        <GOTO ,20-OLD-FARM>
        <RTRUE>
    )>
    <COND (<AND <=? ,HERE ,19-FARMHOUSE> ,19-FARMHOUSE-FLAG> 
        <TELL CR ,MESSAGE-059 CR CR>
        <GOTO ,20-OLD-FARM>
        <RTRUE>
    )>
    <COND (<AND <=? ,HERE ,19-FARMHOUSE> <=? ,07-PAPERBAG-COUNTER 5>>
        <TELL CR ,MESSAGE-060 CR>
        <SETG ,07-PAPERBAG-COUNTER 4>
        <RTRUE>
    )>
    <COND (<AND <=? ,HERE ,19-FARMHOUSE> <=? ,07-PAPERBAG-COUNTER 1>>
        <TELL CR ,MESSAGE-061 CR CR>
        <MOVE ,08-BASKETBALL ,WINNER>
        <FCLEAR ,09-PAPERBAG ,WORNBIT>
        <MOVE ,09-PAPERBAG ,20-OLD-FARM>
        <SETG ,19-FARMHOUSE-FLAG T>
        <SETG ,07-PAPERBAG-COUNTER 0>
        <COND (<NOT ,SCORE-BASKETBALL-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-BASKETBALL-FLAG T>)>
        <GOTO ,20-OLD-FARM>
        <RTRUE>
    )>

    ;"Return from Ravine?"
    <COND (<=? ,08-RAVINE-COUNTER 1>
        <TELL CR ,MESSAGE-076 CR CR>
        <SETG ,08-RAVINE-COUNTER 0>
        <GOTO ,02-ROUND-ROOM>
        <RTRUE>
    )>

    ;"Well interruptions"
    <COND (<=? ,05-WELL1-COUNTER 3>
        <TELL CR ,MESSAGE-054 CR>
        <SETG ,05-WELL1-COUNTER 2>
        <RTRUE>
    )>
    <COND (<=? ,05-WELL1-COUNTER 2>
        <TELL CR ,MESSAGE-055 CR>
        <SETG ,05-WELL1-COUNTER 1>
        <RTRUE>            
    )>
    <COND (<=? ,05-WELL1-COUNTER 1>
        <TELL CR ,MESSAGE-056 CR CR>
        <MOVE ,10-CLOTHLINE ,LOCAL-GLOBALS>
        <COND (<AND <=? <LOC ,11-BLANKET> ,20-OLD-FARM> <FSET? ,11-BLANKET ,NDESCBIT> <NOT ,GAME_VERSION_CLASSIC>> <FCLEAR ,11-BLANKET ,NDESCBIT>)>
        <COND (<FSET? ,11-BLANKET ,NDESCBIT> <MOVE ,11-BLANKET ,LOCAL-GLOBALS>)>
        <MOVE ,12-EMPTY-CLOTHLINE ,LOCAL-GLOBALS>
        <SETG ,05-WELL1-COUNTER 0>
        <SETG ,18-WELL-FLAG T>
        <GOTO ,20-OLD-FARM>
        <RTRUE>
    )>
    <COND (<=? ,06-WELL2-COUNTER 1>
        <TELL CR ,MESSAGE-058 CR>
        <SETG ,06-WELL2-COUNTER 0>
        <RTRUE>
    )>

    ;"Decrease counters"
    <COND (<NOT <=? ,05-WELL1-COUNTER 0>> <SETG ,05-WELL1-COUNTER <- ,05-WELL1-COUNTER 1>>)>
    <COND (<NOT <=? ,06-WELL2-COUNTER 0>> <SETG ,06-WELL2-COUNTER <- ,06-WELL2-COUNTER 1>>)>
    <COND (<NOT <=? ,07-PAPERBAG-COUNTER 0>> <SETG ,07-PAPERBAG-COUNTER <- ,07-PAPERBAG-COUNTER 1>>)>
    <COND (<NOT <=? ,08-RAVINE-COUNTER 0>> <SETG ,08-RAVINE-COUNTER <- ,08-RAVINE-COUNTER 1>>)>

    ;"Toad interruptions"
    <COND (<AND <L=? <RANDOM 100> 10> <=? ,HERE ,05-GREAT-HALL-NE ,12-ON-TOADSTOOL>>
        <TELL CR ,MESSAGE-101 CR>
        <RTRUE>
    )>

    ;"Wizard action"
    <COND (<AND <L=? <RANDOM 100> 5> <NOT <=? <LOC ,PLAYER> ,13-VERTEX ,19-FARMHOUSE ,25-BEDROOM ,47-CUBICAL-ROOM ,50-WELL-BOTTOM>>>
        <TELL CR <PICK-ONE-R ,WIZARD-ACTION> CR CR ,MESSAGE-106 CR>
        <RTRUE>
    )>

        ;"Move large red button to device if device is carried"
    <COND (<HELD? ,32-DEVICE>
        <MOVE ,RED-BUTTON ,HERE>
    )
    (T
        <MOVE ,RED-BUTTON ,LOCAL-GLOBALS>
    )>

>

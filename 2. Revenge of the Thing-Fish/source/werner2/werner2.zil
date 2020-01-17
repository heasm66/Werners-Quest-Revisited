"Werner's Quest, Revisited - 2. Revenge of the Thing-Fish main file"

;"Release  1 20191108: First attempt.
           2 20191129: INFO ==> ABOUT, MODERN/CLASSIC
                       Compile to .z5 (XZIP). This is default for Inform and therefore the most tested format.
           3 20191223: InvisiClues+bugs.
           4 20200108: Bugs
           5 20200109: Hints to lowercase
"

<VERSION XZIP>
<CONSTANT RELEASEID 5>

<SETG EXTRA-FLAGS
    (
    MAZEBIT                 ;"Room is part of maze" 
    TIEABLEBIT              ;"Object is tieable"
    )>

"Main loop"

<CONSTANT GAME-BANNER
"||As you might remember, part I of Werner's Quest ended with Gandalf and the rest of the pack carrying you off into the sunset.
Well, they finally got tired of dragging you around, and so they dumped you in a conveniently-placed barrow and went
off to get some ale before the pubs closed...|
|
|
Werner's Quest, Revisited - 2. Revenge of the Thing-Fish|
Original Quill game by Jan Åberg, 1985, 1986|
Source extracted from C64-version with Unquill v0.11 and converted to ZIL by Henrik Åsman, 2019|
Type 'ABOUT' for more details about this version.">

<ROUTINE GO () 
    <CRLF>
    <INIT-STATUS-LINE>
    <V-VERSION> <CRLF>
    <PUTP PLAYER ,P?CAPACITY 50>            ;"Default SIZE of objects is 5. This limits the inventory to 10 objects." 
    <SETG HERE ,01-INSIDE-BARROW>
    <MOVE ,PLAYER ,HERE>
    <QUEUE I-EVERY-TURN -1>
    <V-LOOK>
    <MAIN-LOOP>>

;"Flags"

<GLOBAL 12-DWARF-SKELETON-FLAG <>>
<GLOBAL 13-CLOAK-FLAG <>>
<GLOBAL 14-JELL-O-FLAG <>>
<GLOBAL 15-SOFT-RUG-FLAG <>>
<GLOBAL 16-ROSETTA-FLAG <>>
<GLOBAL 17-L9-FLAG <>>
<GLOBAL 18-RIDDLE-FLAG <>>
<GLOBAL 19-DEVICE-FLAG <>>
<GLOBAL 20-MIDGET-FLAG <>>

<GLOBAL HIT-COUNTER 0>

<GLOBAL SCORE-FREE-WIZARD-FLAG <>>
<GLOBAL SCORE-GET-VELVET-FLAG <>>
<GLOBAL SCORE-GET-SATIN-FLAG <>>
<GLOBAL SCORE-GET-RADIO-FLAG <>>
<GLOBAL SCORE-SLEEP-FLAG <>>
<GLOBAL SCORE-BATTERY-FLAG <>>
<GLOBAL SCORE-NARROW-LEDGE-FLAG <>>
<GLOBAL SCORE-ESCAPE-BUILDING-FLAG <>>
<GLOBAL SCORE-PETE-AUSTIN-FLAG <>>
<GLOBAL SCORE-SOLVE-GAME-FLAG <>>

;"Messages"

<CONSTANT MESSAGE-000 "You see nothing special.">
<CONSTANT MESSAGE-001 "Taken.">
<CONSTANT MESSAGE-002 "Dropped.">
<CONSTANT MESSAGE-003 "Without great effort, you drag the oversized, chrome spoon out of the muffin. The spoon begins to glow with a sickening, green light. Suddenly, the walls turn and the Thing-Fish enters. As he snatches the spoon out of your grip he says: \"Boy! Whattya doim wit dat spoon? Don't ya know dis be a low-budget 'ventchuh? We can't 'ford to achilly embed de spoon in dis heaah phony, ovuh-dimensiumated muffim, when it are gwine come out all by itseff jes a lil bit latuh! Now, leave dat item 'lone!\". He sticks the spoon back into the muffin and disappears in a puff of stagecraft.">
<CONSTANT MESSAGE-004 "You place the beam conveniently over the opening.">
<CONSTANT MESSAGE-005 "Taken.||Mr Lamberth walks up beside you. He remarks to you: \"An attempted shop-lifting, aye? This is extremely nasty! Put that cushion back immediately, if you would be so very nice!\". With that, he tears the cushion out of your hands and puts it back.">
<CONSTANT MESSAGE-006 "The odd angel doesn't wish to hand the transistor radio to you, with the motivation: \"Noooo! Don't snatch my radio, maaan! It doesn't work anywaaay!\"">
<CONSTANT MESSAGE-007 "This is the potatoes that the Thing-Fish gave you in the end of Werner's Quest part I.">
<CONSTANT MESSAGE-008 "The map is as curious now as it was in Werner's Quest part I, bearing a large number of red circles and lines.">
<CONSTANT MESSAGE-009 "Embedded within the muffin is an over-sized, chrome spoon.">
<CONSTANT MESSAGE-010 "In the muffin there is a hole.">
<CONSTANT MESSAGE-011 "It's a 0.038 Zorkmid coin.">
<CONSTANT MESSAGE-012 "As you look through the glass, the items at which you gaze are magnified. No wonder, you think, that it's referred to as a magnifying glass.">
<CONSTANT MESSAGE-013 "The sword is made of plastic and in Taiwan.">
<CONSTANT MESSAGE-014 "The lamp is plastic, non-functional and made in Taiwan.">
<CONSTANT MESSAGE-015 "The bottle is made of transparent plastic, empty and marked \"Made in Taiwan\".">
<CONSTANT MESSAGE-016 "It is an about 5 ft. long Theobaldian Multi-Purpose Wooden Beam.">
<CONSTANT MESSAGE-017 "The repellent is meant to be sprayed all over your body to scare off eventual grues.">
<CONSTANT MESSAGE-018 "The wizard is tied up in Theobaldian Auto-Knotting Rope. You notice that he isn't carrying his magic wand.">
<CONSTANT MESSAGE-019 "The cake is marked in tiny letters, too small to be read by the unaided eye. However, straining your eyes, you can distinguish a capital \"E\".">
<CONSTANT MESSAGE-020 "Gazing at the cake through the magnifying glass, you can make out the text; it reads: \"Enema\".">
<CONSTANT MESSAGE-021 "On one of the shelves of the bookcase is a tiny button.">
<CONSTANT MESSAGE-022 "It looks just like an ordinary legendary three-headed giant mutant dachshund-guard of the southern exit.">
<CONSTANT MESSAGE-023 "The thing that's odd about this angel is the fact that it has two heads, and that is isn't really an angel, rather Zaphod Beeblebrox dressed up as one.">
<CONSTANT MESSAGE-024 "The dwarf skeleton is remarkably well-preserved, probably from the conservating effect of the Jell-O. As you nudge it, a battery falls out of its hand.">
<CONSTANT MESSAGE-025 "The battery is bearing the legend: \"Teobaldian Magic Batteries Inc.\"">
<CONSTANT MESSAGE-026 "The midget looks very sinister, and his clean-shaven chin shows his great skill with the razor.">
<CONSTANT MESSAGE-027 "The poster bears your picture, and the text reads:|||    The Werner Dungeon Enema Bandit|||               WANTED||for enforcing a vicious Enema unto a|most Noble and Innocent member of the|Midget kin.||       REWARD: 10000 Zorkmids">
<CONSTANT MESSAGE-028 "The device is black and thumb-shaped. It has a large red button labelled: \"Large Red Button\".">
<CONSTANT MESSAGE-029 "The leaflet is, by some peculiar reason, glued to the table.">
<CONSTANT MESSAGE-030 "The Thing-Fish is, as you might know, a sinister-looking being with potato-head, ducklips, big white gloves and a napkin. In addition to that, he is wearing a stupid, pointed hat with astrological signs all over it. In his hand he holds what appears to be a magic wand.">
<CONSTANT MESSAGE-031 "As you rummage through the furs, a duck scurries out from them and runs out of the cave, followed by a bulgarian antropologist. Moments later, a sofa leaps out from under a fur. Seated upon the sofa is fat gentleman holding a cup of tea. The fat man says \"Vapor-lock?\", and with that, the sofa bounces out of sight. Further examination of the furs reveals the opening out of which the above-mentioned items have emerged: a freak wormhole in the space-time fabric.">
<CONSTANT MESSAGE-032 "Among the furs is a freak wormhole in the space-time fabric.">
<CONSTANT MESSAGE-033 "The leaflet reads:|\"Crufty, stupid, dim adventure| You'll procede to WQ III| Only if you want to be| Dreaming on cushions| Of velvet and satin| By music by magic| By people that happen| To enter the room| Of a strange purple Jell-O| Your dreams as they are now| Are all mellow yellow| Unbind your mind| There is no time| To lick your stamps| And paste them in| Complete this game| And you will win| Diamonds on velvet| On goldens on vixen">
<CONSTANT MESSAGE-034 " On comet on cupid| On Donner &  Blitzen| A-up & a-way & a-far & a-musement| Stop reading this bunch| Of poetic confusement\"">
<CONSTANT MESSAGE-035 "\"Grue Repellent          1 whlbrw zmds. | Wooden Beam             1 whlbrw zmds. | Wrench                  1 whlbrw zmds. | Shovel                     0.038 zmds. | Little Adventurer Kit      0.038 zmds.\"">
<CONSTANT MESSAGE-036 "In one of the cloaks you find a shiny coin.">
<CONSTANT MESSAGE-037 "In the Jello-O you find the skeleton of a dwarf.">
<CONSTANT MESSAGE-038 "As you press the button, the clock starts to vibrate. Suddenly, the vibrations stop.">
<CONSTANT MESSAGE-039 "You stick your hands into the rug and grope around. You find, and discard, 1 hedgehog family, 1 trodden-on jam sandwich, 2 pool balls, 3 herrings, 1 fish-monger, 1 full volume of MAD Magazine, 1 Amstrad and a thing that probably once was a sock before you find something interesting; a velvet cushion.">
<CONSTANT MESSAGE-040 "You have no money.">
<CONSTANT MESSAGE-041 "You can't afford that.">
<CONSTANT MESSAGE-042 "The ogre examines the wheelbarrow of money and says: \"Uh, sorry 'squire, but I can't give back on such a large amount of money.\"">
<CONSTANT MESSAGE-043 "The ogre takes the money and hands you the merchandise.">
<CONSTANT MESSAGE-044 "In the box you find the essential eqipment for an adventurer: a sword, a lantern, and a bottle. The box disappears through the magic of stagecraft.">
<CONSTANT MESSAGE-045 "The stone door is securely locked.">
<CONSTANT MESSAGE-046 "Suddenly, the walls turn and the Thing-Fish appears. He gescticulates wildly and says: \"Owaah! Easy dere, boy! Thought you cudd just drop out on me an'get away wit it! Oh no! I'll go find me de wizudd of Frobninz an' snatch de magic wand fum him! An' den I'll come upwit some nasty tricks to make yo' life even mo' mizzabul den it already are! Revenge!\" He dashes off.">
<CONSTANT MESSAGE-047 "As you enter the room, the spoon from the junction appears in your hand, wildly glowing.">
<CONSTANT MESSAGE-048 "The muffin man, taking the spoon, gathers a quantity of dried muffin remnants. He turns to you and speaks: \"Some folks like cupcakes better. I, for one, care less for them.\" Arrogantly twisting the sterile canvas snout of a fully-charged icing utensil, he puts forth a large green rosette and hands you the spoon.">
<CONSTANT MESSAGE-049 "Pete Austin, spying you, looks up from his desk, saying: \"Jolly good! Just the type I need for the cover of my now trilogy! Sword and lamp and everything!\" He pulls forth a camera and starts to take pictures of you. Having finished this, he says: \"And now for the payment! Will a wheelbarrow of money do?\". He hands you that. Sniggering for himself, he adds: \"That sucker won't know any difference between real money and those phony zorkmids. He he he!\".">
<CONSTANT MESSAGE-050 "The wizard of Frobozz stands and says, his face cerise with anger: \"Oh, that Thing-Fish! He's so annoying! I feel like calling him by a really bad name, like 'that naughty person' or something!\". He dashes off to the north.">
<CONSTANT MESSAGE-051 "The rope goes up into the air but, finding nothing to knot itself around, returns to your hand again.">
<CONSTANT MESSAGE-052 "The rope goes up into the air and through the opening in the ceiling, where it knots itself around the beam. Taking a deep breath, you swing across. Halfways, the beam breaks and falls down into the ravine. So do you. As you plummet downwards, Arthur Dent flies past you. Seeing this, you get so confused you forget that you're falling. Without noticing it yourself you fly up and land safely on the other side.">
<CONSTANT MESSAGE-053 "The stone door swings open with a resounding Eep.">
<CONSTANT MESSAGE-054 "You connect the two letters \"Q\" and \"P\" on the map. Suddenly, an insane laughter echoes through the dungeon. The Thing-Fish enters through turning walls. He's wearing a pointed hat with stars and similar symbols on it, and he's carryinga wand. He yells: \"Boy! What has you done! Have you connectiumated dose two lettuhs on de map? Do ya realize dat ya has jes' released de Evil Error, Internal Error # 65535, down in de maze in de basement? We must stop de Error fum reachim de microprocessuh and cause dis program to crash! Quick! Hain me a erasuh! What! Ya don't has a erasuh? Oh no!\" He runs off. You can't see any slhhgsngld here. Midget undulating says \"What's this?\" djgn wtdkx fjh The Thing-Fish re-enters. He says: \"Phew! Dat sure were close! Don't evuh do dat 'gin\" He disappears in a puff of stagecraft.">
<CONSTANT MESSAGE-055 "The troll from WQI appears. He says: \"What? Deliberate vandalism. Very serious indeed!\" With that, he turns you into force-meat with his axe.">
<CONSTANT MESSAGE-056 "You put the rosette on the middle head. Seeing this, the two other heads appear quite agitated, as they attack the middle head. The middle head makes a beeline to the west, thereby dragging the other two heads, and the rest of the body, with it.">
<CONSTANT MESSAGE-057 "The odd angel accepts the rope, takes out a lighter and starts to smoke the rope. Moments later it flies away, remarking \"Oooooooh man! That sure was some kinda joint!\". You notice that he has left his radio behind.">
<CONSTANT MESSAGE-058 "You insert the battery.">
<CONSTANT MESSAGE-059 "The radio doesn't seem to function properly, perhaps from the lack of battery.">
<CONSTANT MESSAGE-060 "\"Mellow Yellow\" by Donovan pours out of the radio.">
<CONSTANT MESSAGE-061 "You breathe a sigh of release as Donovan is turned off.">
<CONSTANT MESSAGE-062 "It looks like a good, strong hemp rope.">
<CONSTANT MESSAGE-063 "As you pull the lever, a trap-door opens beneath your feet. While you are suspended in midair in a cartoonish way, the troll from WQI enters. He grabs you in the last moment and says: \"Aha! Fiddlingwith the lever! You pulled it, didn't you? Now let's see...\" He reads the sign. \"Oh dear! Nothing about pulling! Well, I guess I'll have to let go of you...\" He does so, and you slide down a chute...">
<CONSTANT MESSAGE-064 "The troll from WQI enters. He disembowels you with his axe, remarking: \"Fiddling with the lever, aye?\"">
<CONSTANT MESSAGE-065 "The chute is too steep to ascend.">
<CONSTANT MESSAGE-066 "The hound growls at you, and you decide not to do it.">
<CONSTANT MESSAGE-067 "The midget fends you off with his razor.">
<CONSTANT MESSAGE-068 "The device must be broken, since it just emits a few eeps.">
<CONSTANT MESSAGE-069 "The bookcase swings forward and reveals a secret passage leading west. In the secret passage you can see Sherlock Holmes and Watson sitting in the same armchair, gazing longingly into each other's eyes. As they notice you, they get up, take the inflatable armchair and scurry away.">
<CONSTANT MESSAGE-070 "The midget accepts the cake and consumes it. Suddenly, his face turns white, and, after a while, red. He then dashes off, both hands at his bottom.">
<CONSTANT MESSAGE-071 "A midget enters, carrying a poster. He attaches the poster to the wall and leaves, whistling merrily.">
<CONSTANT MESSAGE-072 "Suddenly, the Thing-Fish appears in the room. He says: \"Boy! Whatya doim in dis heaah ol' ventchuh? Let's get back to bidniz thru de magic o' stage-kraff!\" He tries to turn one of the walls, but nothing happens. He says: \"Oh deaah! How embarrasim! Dis be a severely ol' 'venchuh, an de stage-kraff seem to has rusted stuck!\"">
<CONSTANT MESSAGE-073 "You throw the rope, which knots itself around the beams above. The Thing-Fish says: \"Dat sho'nuff wasn't no stoopid idea! Let's climb de rope!\" You do so...">
<CONSTANT MESSAGE-074 "You see that the building has no roof, and that it is only stage-craft. You also see beams high above.">
<CONSTANT MESSAGE-075 "You are sitting on a beam right under the ceiling of a large warehouse. Below you is a vast quantity of items from different adventures, such as the sand wich from Colossal Caves and the spheres from Zork II. The Thing-Fish climbs up the rope. He says: \"Dat dere be room zero. Dat is de room where we put all de items that no longer exist in the 'venchuh! But now, let's get back to de ol' dunyum 'gin!\" The walls turn and...">
<CONSTANT MESSAGE-076 "The gnome leaps up, screaming: \"If you say 'mattress' to mr Lamberth he puts a bucket over his head!\" Then he goes back to sleep.">
<CONSTANT MESSAGE-077 "Mr. Lamberth puts a bucket over his head.">
<CONSTANT MESSAGE-078 "It appears to be approximately 1 wheelbarrow of Zorkmids.">
<CONSTANT MESSAGE-079 "You lie down and somehow you manage to fall asleep.||...and in your dreams, you can see a large number op hippopotami performing various acts within the field of naval aviation... You wake up.">
<CONSTANT MESSAGE-080 "You lie down on the comfortable cushions, and, despite the fact that the music is terrible, you drift into sleep....||and in your dreams, you can see yourself as prophet completing the quest... The word from your lips (\"CROOK\")...You just can't believe it was that simple... You wake up.">
<CONSTANT MESSAGE-081 "Rance says: \"Okay, zat vill probably do. Juzt follow me...\" He opens the door. Suddenly, a telephone rings. Rance reaches into his briefcase and takes outa telephone in which he speaks a few words. Then he says: \"Vell, it appearz zat ze Thing-Fish has by some peculiar reazon turned inzo a glass of fruit-juize and zen, in a moment of zirst, consumed himzelf. Zis means zat I vill from now on be your supervizor. Please step zis way...\" He guides you through the door to the top of a short escalator, going downwards. \"Zown zere\", he says, \"Iz Werners Kvest III. Good luck!\" He slaps you on the back, and as a result of this you tumble down the escalator and land in WQIII. Rance shouts after you: \"If you haven't already noticed, you've just completed Werners Kvest II!\"">
<CONSTANT MESSAGE-082 "Rance stops you, saying: \"You're not qualified to enter zis extremely complicated advenzure yet!\"">
<CONSTANT MESSAGE-083 "Nothing happens.">
<CONSTANT MESSAGE-084 "The Thing-Fish enters. He is wearing an ugly hat with astrological signs all over it. He's carrying a wand, with which he gesticulates wildly.">
<CONSTANT MESSAGE-085 "He says: \"F... F... Fairies!\" A large number of persons, who all look like Boy George, enter. Seeing the Thing-Fish, they emit a pleasurable yell and rush towards him. He dashes off, hotly pursued by the perverts.">
<CONSTANT MESSAGE-086 "He says: \"F... F... Food!\" An amount of mashed potatoes appears about four inches above his head. It hovers there for a moment before it lands on top of the potatohead. Grumbling, the Thing-Fish departs.">
<CONSTANT MESSAGE-087 "He says: \"F... F... Fish!\" The section of the room in which the Thing-Fish stands is filled with kipped herrings. He wades out of the pile of fish, throws the wand on the floor and jumps on it. Then he leaves. The herrings disappear in a puff of stagecraft.">
<CONSTANT MESSAGE-088 "He says: \"F... F... Fart!\" An odor fills the room. It seems to come from the Thing-Fish. Looking embarrassed, he leaves.">
<CONSTANT MESSAGE-089 "The sound of a fight can be heard in the distance, followed by the sound of someone being tied up in Theobaldian Auto-Knotting Rope.">
<CONSTANT MESSAGE-090 "The Thing-Fish says: \"Why don'tya come up wit sum way to get outa heeah instead?\"">
<CONSTANT MESSAGE-091 "Pete Austin says: \"Please be quiet! I'm constructing an advanced parser!\"">
<CONSTANT MESSAGE-092 "He says: \"Yeeeaah! That's heaveee maan!\"">
<CONSTANT MESSAGE-093 "You are plainly ignored.">
<CONSTANT MESSAGE-094 "They look extremely nasty.">
<CONSTANT MESSAGE-095 "It tastes very strange. You feel a strong urge to go to the bathroom. You run around the dungeon in search of one, but suddenly you remember that the toilets are in Werner's Quest I. You do something very embarrassing and die of shame.">
<CONSTANT MESSAGE-096 "It is sweet and sticky.">
<CONSTANT MESSAGE-097 "Suddenly, a dead goblin falls down through a hole in the ceiling. Two goblins carrying a stretcher enter. They lift their unfortunate colleague, put him on the stretcher and leave.">
<CONSTANT MESSAGE-098 "You spray the grue repellent all over your body, which now stinks. The can disappears through the magic of stage-craft.">
<CONSTANT MESSAGE-099 "Dig? Without an appropriate tool?">
<CONSTANT MESSAGE-100 "Yeah! I really dig that! Heavy, man! (Joke. Actually, the ground is not suitable for digging here, but that's not half as funny.)">
<CONSTANT MESSAGE-101 "The Thing-Fish says: \"Dat functium have been out of order for many years.\"">
<CONSTANT MESSAGE-102 "Yeuch!">
<CONSTANT MESSAGE-103 "Inserted.">

<CONSTANT SYSMESSAGE-000 "">
<CONSTANT SYSMESSAGE-001 "You can see:">
<CONSTANT SYSMESSAGE-002 "What next? ">
<CONSTANT SYSMESSAGE-003 "What next? ">
<CONSTANT SYSMESSAGE-004 "What next? ">
<CONSTANT SYSMESSAGE-005 "What next? ">
<CONSTANT SYSMESSAGE-006 "What kind of talk is that? I'm not Encyclopedia Britannia y'know.">
<CONSTANT SYSMESSAGE-007 "That is a direction in which you are quite unable to move.">
<CONSTANT SYSMESSAGE-008 "That is not possible.">
<CONSTANT SYSMESSAGE-009 "You have picked up, stolen, bought or otherwise obtained the following:">
<CONSTANT SYSMESSAGE-010 "(all over your body)">
<CONSTANT SYSMESSAGE-011 "Nil.">
<CONSTANT SYSMESSAGE-012 "Quit? Now? Would that really be wise?">
<CONSTANT SYSMESSAGE-013 "               The End.||Would you, perchance, care to make another attempt?">
<CONSTANT SYSMESSAGE-014 "OK! OK! I don't care! I can find me another adventurer!">
<CONSTANT SYSMESSAGE-015 "OK.">
<CONSTANT SYSMESSAGE-016 "More...">
<CONSTANT SYSMESSAGE-017 "You have taken ">
<CONSTANT SYSMESSAGE-018 " turn">
<CONSTANT SYSMESSAGE-019 "s">
<CONSTANT SYSMESSAGE-020 ".">
<CONSTANT SYSMESSAGE-021 "You have scored">
<CONSTANT SYSMESSAGE-022 "%25">
<CONSTANT SYSMESSAGE-023 "You're not wearing it.">
<CONSTANT SYSMESSAGE-024 "You're carrying too much.">
<CONSTANT SYSMESSAGE-025 "You already have it.">
<CONSTANT SYSMESSAGE-026 "That object is not present.">
<CONSTANT SYSMESSAGE-027 "You're carrying too much.">
<CONSTANT SYSMESSAGE-028 "You're not carrying that item.">
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

<GLOBAL THING-FISH-ACTION
	<LTABLE 
		,MESSAGE-085
		,MESSAGE-086
		,MESSAGE-087
		,MESSAGE-088>>

<GLOBAL GAME_VERSION_CLASSIC <>>                    ;"Should the game be played in CLASSIC or NEW mode? (NEW won't kill quite as swift as in CLASSIC mode)"

;"-----------------------------------------------------------------------------
; ROOMS
; -----------------------------------------------------------------------------"

;"Room: INSIDE BARROW ---------------------------------------------------------"
<ROOM 01-INSIDE-BARROW
    (DESC "Inside Barrow")
    (IN ROOMS)
    (LDESC 
"You are inside an old barrow deep within the forest. To the south there is a cracked and deterioated marble archway
over which is posed a sign reading: \"Werner's Dungeon - Western Annexe\".")
    (SOUTH TO 03-JUNCTION)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SIGN) STANDARD-F)>

;"Room: CLOAK ROOM ------------------------------------------------------------"
<ROOM 02-CLOAK-ROOM
    (DESC "Cloak Room")
    (IN ROOMS)
    (LDESC 
"You are in the cloak-room of the western annexe. As you might have guessed, this is the room in which the visitors are
supposed to hang their cloaks. As you are wearing no such apparel, you are unable to use this room for its intended
purpose. Other visitors, however, have done so, and thus there are some cloaks hanging on the walls. The sole exit
is to the east.")
    (EAST TO 03-JUNCTION)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (CLOAK CLOAKS) CLOAK-F)>

<ROUTINE CLOAK-F ()
    <COND (<VERB? EXAMINE SEARCH> 
        <COND (,13-CLOAK-FLAG
            <TELL ,MESSAGE-000 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-036 CR>
            <MOVE ,06-COIN ,HERE>
            <SETG 13-CLOAK-FLAG T>
            <THIS-IS-IT ,06-COIN>
            <RTRUE>
        )>
    )>
>

;"Room: JUNCTION --------------------------------------------------------------"
<ROOM 03-JUNCTION
    (DESC "Junction")
    (IN ROOMS)
    (LDESC 
"You are at a junction in the western annexe of Werner's Dungeon. Passages lead in all directions.")
    (NORTH TO 01-INSIDE-BARROW)
    (SOUTH TO 08-LOBBY)
    (EAST TO 04-GIFT-SHOP)
    (WEST TO 02-CLOAK-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (OVERSIZED CHROME) (SPOON) SPOON-IN-MUFFIN-F)>

<ROUTINE SPOON-IN-MUFFIN-F ()
    <COND (<VERB? TAKE> 
        <COND (<IN? ,03-MUFFIN-WITH-SPOON ,HERE>
            <TELL ,MESSAGE-003 CR>
            <RTRUE>)
        >)
    >
>

;"Room: GIFT SHOP -------------------------------------------------------------"
<ROOM 04-GIFT-SHOP
    (DESC "Gift Shop")
    (IN ROOMS)
    (LDESC 
"You are in the gift shop of the western annexe. This gift shop is, unlike the one in Werner's Quest part I, not
deserted; an ogre is sitting behind the counter, eyeing you suspiciously. Taped to the counter is a note.
A passage leads west.")
    (WEST TO 03-JUNCTION)
    (ACTION GIFT-SHOP-F)
    (FLAGS LIGHTBIT)
    (THINGS (TAPED) (NOTE) NOTE-F)>

<ROUTINE NOTE-F ()
    <COND (<VERB? EXAMINE READ>
        <TELL "The note reads:" CR>
        <FIXED-FONT-ON> 
        <TELL ,MESSAGE-035 CR>
        <FIXED-FONT-OFF>
        <RTRUE>
     )>
>

<ROUTINE GIFT-SHOP-F (RARG)
    <COND (<AND <VERB? BUY> <=? .RARG ,M-BEG>>
        <COND (<AND <OR <=? ,PRSO ,08-ADVENTURE-KIT> <=? ,PRSO ,15-SHOVEL>> <HELD? ,12-MONEY>>
            <TELL ,MESSAGE-042 CR>
            <RTRUE>
        )>
        <COND (<AND <OR <=? ,PRSO ,08-ADVENTURE-KIT> <=? ,PRSO ,15-SHOVEL>> <HELD? ,06-COIN>>
            <TELL ,MESSAGE-043 CR>
            <MOVE ,06-COIN ,LOCAL-GLOBALS>
            <MOVE ,PRSO ,PLAYER>
            <FCLEAR ,PRSO ,NDESCBIT>
            <FSET ,PRSO ,TAKEBIT>
            <RTRUE>
        )>
        <COND (<AND <OR <=? ,PRSO ,13-BEAM> <=? ,PRSO ,14-CAN> <=? ,PRSO ,16-WRENCH>> <HELD? ,06-COIN>>
            <TELL ,MESSAGE-041 CR>
            <RTRUE>
        )>
        <COND (<AND <OR <=? ,PRSO ,13-BEAM> <=? ,PRSO ,14-CAN> <=? ,PRSO ,16-WRENCH>> <HELD? ,12-MONEY>>
            <TELL ,MESSAGE-043 CR>
            <MOVE ,12-MONEY ,LOCAL-GLOBALS>
            <MOVE ,PRSO ,PLAYER>
            <FCLEAR ,PRSO ,NDESCBIT>
            <FSET ,PRSO ,TAKEBIT>
            <RTRUE>
        )>
    )>
>

;"Room: MAP ROOM --------------------------------------------------------------"
<ROOM 05-MAP-ROOM
    (DESC "Map Room")
    (IN ROOMS)
    (LDESC 
"You are in a small room carved out of the rock. All four walls are covered with adventure game maps. One map particularly
catches your eye: A large one with only two squares, one marked \"P\", the other marked \"Q\". A ladder leads down.")
    (DOWN TO 11-TURNING-PASSAGE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (MAP MAPS) STANDARD-F)>

;"Room: SQUARE ROOM -----------------------------------------------------------"
<ROOM 06-SQUARE-ROOM
    (DESC "Square Room")
    (IN ROOMS)
    (LDESC 
"You are in a square room with yellow, translucent walls. On the eastern wall is a large, faintly gray circle, as if
there once had been a large black circle which now is erased. A ladder leads up.")
    (UP TO 11-TURNING-PASSAGE)
    (FLAGS LIGHTBIT)
    (THINGS (GRAY BLACK FAINTLY) (CIRCLE) STANDARD-F
            (YELLOW) (WALL WALLS) STANDARD-F)>

;"Room: LIBRARY ---------------------------------------------------------------"
<ROOM 07-LIBRARY
    (DESC "Library")
    (IN ROOMS)
    (LDESC 
"You are in a small library which, not unexpectedly, contains bookcases, which, not unexpectedly, contain books. On one
wall hangs a sign reading: \"The Werner library of the world's thinnest books\". The books have titles like: \"Prominent
Norwegians\", \"Scottish Charity Funds\", \"Good Spectrum Games\" and the like. A leaflet, entitled \"Poems which help you
complete Werner's Quest II\" is lying on a small table. The exit is to the east.")
    (EAST TO 08-LOBBY)
    (WEST PER LIBRARY-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BOOKCASE BOOKCASES CASE) BOOKCASE-F
            (<>) (LEAFLET) LEAFLET-F
            (<>) (BOOK SIGN) STANDARD-F)>


<OBJECT TINY-BUTTON
	(IN LOCAL-GLOBALS)
	(SYNONYM BUTTON)
    (ADJECTIVE TINY)
	(DESC "tiny button")
    (ACTION TINY-BUTTON-F)
    (FLAGS NDESCBIT)>

<ROUTINE LIBRARY-EXIT ()
    <COND (<IN? ,17-SECRET-PASSAGE ,HERE>
        <RETURN ,36-NORTH-EAST-PASSAGE>
    )
    (T
        <TELL ,SYSMESSAGE-007 CR>
        <RFALSE>
    )>
>

<ROUTINE BOOKCASE-F ()
    <COND (<VERB? EXAMINE SEARCH>
        <TELL ,MESSAGE-021 CR>
        <MOVE ,TINY-BUTTON ,HERE>
    )>
>

<ROUTINE LEAFLET-F ()
    <COND (<VERB? EXAMINE READ>
        <TELL ,MESSAGE-033 CR>
        <TELL ,MESSAGE-034 CR>
        <RTRUE>
    )>
    <COND (<VERB? TAKE>
        <TELL ,MESSAGE-029 CR>
        <RTRUE>
    )>
>

<ROUTINE TINY-BUTTON-F ()
    <COND (<VERB? PUSH> 
        <COND (<NOT <=? <LOC ,17-SECRET-PASSAGE> ,HERE>>
            <TELL ,MESSAGE-069 CR>
            <MOVE ,17-SECRET-PASSAGE ,HERE>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-083 CR>
            <RTRUE>
        )>
    )>
    <STANDARD-F>
>

;"Room: LOBBY -----------------------------------------------------------------"
<ROOM 08-LOBBY
    (DESC "Lobby")
    (IN ROOMS)
    (LDESC 
"You are in the lobby of the western annexe. Passages lead in all directions.The lobby is furnished with large plush sofas
and an eminent grandfather clock, which is big enough to enter. On one wall hangs a once-neon-lit sign, which is now out of
order and cannot be read.")
    (NORTH TO 03-JUNCTION)
    (SOUTH TO 13-CIRCULAR-ROOM)
    (EAST TO 10-LOST-AND-FOUND)
    (WEST TO 07-LIBRARY)
    (IN TO 09-GRANDFATHER-CLOCK)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SIGN) STANDARD-F
            (GRANDFATHER) (CLOCK) GRANDFATHER-CLOCK-F)>

<ROUTINE GRANDFATHER-CLOCK-F ()
    <COND (<VERB? WALK ENTER>
        <DO-WALK P?IN>
        <RTRUE>)
    >
    <STANDARD-F>
>

;"Room: GRAND-FATHER CLOCK -----------------------------------------------------"
<ROOM 09-GRANDFATHER-CLOCK
    (DESC "Inside Grand-father Clock")
    (IN ROOMS)
    (LDESC 
"You are standing inside a large grand-father clock. A red button is right in front of your face, almost asking you to press it.")
    (OUT TO 08-LOBBY)
    (FLAGS LIGHTBIT)
    (THINGS (RED) (BUTTON) RED-BUTTON-1-F)>

<ROUTINE RED-BUTTON-1-F () 
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-038 CR>
        <MOVE ,PLAYER ,52-GRANDFATHER-CLOCK>
        <FSET ,52-GRANDFATHER-CLOCK ,TOUCHBIT>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: LOST & FOUND ----------------------------------------------------------"
<ROOM 10-LOST-AND-FOUND
    (DESC "Lost & Found Dept.")
    (IN ROOMS)
    (LDESC 
"You are in the Lost & Found dept. of the western annexe. The walls are covered with dusty shelves, all of which are empty.
The exit is to the the west.")
    (WEST TO 08-LOBBY)
    (FLAGS LIGHTBIT)>     

;"Room: TURNING PASSAGE -------------------------------------------------------"
<ROOM 11-TURNING-PASSAGE
    (DESC "Turning Passage")
    (IN ROOMS)
    (LDESC 
"You are in a passage turning south and east. A ladder leads up through a hole in the ceiling and down through a similar
hole in the floor.")
    (SOUTH TO 19-STAIRCASE-BOTTOM)
    (EAST TO 12-EAST-WEST-PASSAGE)
    (UP TO 05-MAP-ROOM)
    (DOWN TO 06-SQUARE-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (LADDER HOLE CEILING) STANDARD-F)>

;"Room: EAST WEST PASSAGE -----------------------------------------------------"
<ROOM 12-EAST-WEST-PASSAGE
    (DESC "East-West Passage")
    (IN ROOMS)
    (LDESC 
"You are in an east-west passage. To the south is a magnificient mahogany doorway over which is hung an equally magnificient
mahogany sign bearing the somewhat less magnificient inscription: \"Broom Closet\".")
    (SOUTH TO 16-BROOM-CLOSET)
    (EAST TO 13-CIRCULAR-ROOM)
    (WEST TO 11-TURNING-PASSAGE)
    (FLAGS LIGHTBIT)
    (THINGS (MAHOGANY) (DOORWAY SIGN) STANDARD-F
            (<>) (INSCRIPTION) STANDARD-F)>
     
;"Room: CIRCULAR ROOM ---------------------------------------------------------"
<ROOM 13-CIRCULAR-ROOM
    (DESC "Circular Room")
    (IN ROOMS)
    (LDESC 
"You are in a circular room with doorways leading in all directions. A note taped to one of the walls reads: ||
\"De room-spinnuh are regrettubly out of order.
|
|     De Thing-Fish\"")
    (NORTH TO 08-LOBBY)
    (SOUTH TO 17-ENTRY-HALL)
    (EAST TO 14-RIDDLE-ROOM)
    (WEST TO 12-EAST-WEST-PASSAGE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (NOTE) STANDARD-F)>

;"Room: RIDDLE ROOM -----------------------------------------------------------"
<ROOM 14-RIDDLE-ROOM
    (DESC "Riddle Room")
    (IN ROOMS)
    (LDESC 
"You are in a room whose only remarkable feature is a large stone door over which is it written:|
    \"What Is It,|
       That Some Folks|
         Like Better|
           But For Which|
             The Muffin Man,|
               For One,|
                 Cares Less?\"|
The exit lies to the west.")
    (WEST TO 13-CIRCULAR-ROOM)
    (EAST TO 15-TEA-ROOM IF 18-RIDDLE-FLAG ELSE ,MESSAGE-045)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE STONE) (DOOR) STONE-DOOR-F)>

<ROUTINE STONE-DOOR-F ()
    <COND (<VERB? OPEN>
        <COND (<NOT ,18-RIDDLE-FLAG>
           <TELL ,MESSAGE-045 CR>
        )
        (T
            <TELL "The door is already open." CR>
        )>
        <RTRUE>
    )>
    <COND (<VERB? CLOSE>
        <COND (<NOT ,18-RIDDLE-FLAG>
            <TELL "The door is already closed." CR>
        )
        (T
           <TELL ,SYSMESSAGE-008 CR>
        )>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: TEA ROOM --------------------------------------------------------------"
<ROOM 15-TEA-ROOM
    (DESC "Tea Room")
    (IN ROOMS)
    (LDESC 
"You are in the tea room of an obviously-deranged hatter. You know this because a large sign on one wall
reads: \"The tea room of an obviously-deranged hatter\". The exit is west and the only piece of furniture
is an oblong table.")
    (WEST TO 14-RIDDLE-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE) (SIGN) STANDARD-F
    (OBLONG) (TABLE) STANDARD-F)>

;"Room: BROOM CLOSET ----------------------------------------------------------"
<ROOM 16-BROOM-CLOSET
    (DESC "Broom Closet")
    (IN ROOMS)
    (LDESC 
"You are in a broom closet. There are no brooms here, however, as they have been tossed out to make room for something else.
The exit is north.")
    (NORTH TO 12-EAST-WEST-PASSAGE)
    (FLAGS LIGHTBIT)>
  
;"Room: ENTRY HALL ------------------------------------------------------------"
<ROOM 17-ENTRY-HALL
    (DESC "Entry Hall")
    (IN ROOMS)
    (LDESC 
"You are in the entry hall of the Muffin Utility Research Kitchen (MURK). There is a desk here and, behind it, a sleeping
gnome, snoring loudly. A passage leads north and there is a doorway in the eastern wall.")
    (NORTH TO 13-CIRCULAR-ROOM)
    (EAST TO 18-LABORATORY)
    (ACTION ENTRY-HALL-F)
    (FLAGS LIGHTBIT)>

<ROUTINE ENTRY-HALL-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <NOT <HELD? ,05-SPOON ,PLAYER>>>
        <TELL CR ,MESSAGE-047 CR>
        <MOVE ,05-SPOON ,PLAYER>
        <MOVE ,03-MUFFIN-WITH-SPOON ,LOCAL-GLOBALS>
        <MOVE ,04-MUFFIN ,03-JUNCTION>
        <THIS-IS-IT ,05-SPOON>
    )>
>

;"Room: LABORATORY ------------------------------------------------------------"
<ROOM 18-LABORATORY
    (DESC "Laboratory")
    (IN ROOMS)
    (LDESC 
"You are in the laboratory of the Muffin Utility Research Kitchen (MURK). It is full of strange machinery mixed with common
household items. The Muffin Man is seated at a table.")
    (WEST TO 17-ENTRY-HALL)
    (FLAGS LIGHTBIT)
    (ACTION LABORATORY-F)
    (THINGS (<>) (MACHINERY ITEMS) STANDARD-F)>

<ROUTINE LABORATORY-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <HELD? ,05-SPOON> <NOT ,16-ROSETTA-FLAG>>
        <TELL CR ,MESSAGE-048 CR>
        <MOVE ,22-ROSETTE ,HERE>
        <THIS-IS-IT ,22-ROSETTE>
        <SETG 16-ROSETTA-FLAG T>
    )>
>

;"Room: STAIRCASE BOTTOM ------------------------------------------------------"
<ROOM 19-STAIRCASE-BOTTOM
    (DESC "Bottom of Staircase")
    (IN ROOMS)
    (LDESC 
"You are standing at the bottom of a huge staircase leading up. A passage leads north and a by no means insignificant crack leads east.")
    (NORTH TO 11-TURNING-PASSAGE)
    (EAST TO 20-NARROW-LEDGE-NORTH)
    (UP TO 22-STAIRCASE-TOP)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (CRACK STAIRCASE) STANDARD-F)>

;"Room: NARROW LEDGE NORTH ----------------------------------------------------"
<ROOM 20-NARROW-LEDGE-NORTH
    (DESC "North End of Narrow Ledge")
    (IN ROOMS)
    (LDESC 
"You are standing in the northern end of a narrow ledge overlooking a deep canyon. An uninsignificant crack leads west.")
    (SOUTH TO 27-NARROW-LEDGE-MIDDLE)
    (WEST TO 19-STAIRCASE-BOTTOM)
    (FLAGS LIGHTBIT)
    (THINGS (UNINSIGNIFICANT) (CRACK) STANDARD-F)>

;"Room: FEATURELESS ROOM ------------------------------------------------------"
<ROOM 21-FEATURELESS-ROOM
    (DESC "Featureless Room")
    (IN ROOMS)
    (LDESC 
"You are in a small and totally featureless room. The only break in the complete and utter monotony of this room
is the southern wall, which consists of a curtain of light.")
    (SOUTH TO 24-FURNITURE-SHOP)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (LIGHT CURTAIN LIGHTCURTAIN) STANDARD-F)>

;"Room: STAIRCASE TOP ROOM ----------------------------------------------------"
<ROOM 22-STAIRCASE-TOP
    (DESC "Top of Staircase")
    (IN ROOMS)
    (LDESC 
"You are standing on the top of an impressive staircase leading downwards. The staircase ends here in a blank wall,
obviously the result of an effort made by a severely-stupid architect. However,a recent cave-in has produced a narrow
crack to the east.")
    (EAST TO 23-SMALL-CHAMBER)
    (DOWN TO 19-STAIRCASE-BOTTOM)
    (FLAGS LIGHTBIT)
    (THINGS (NARROW) (CRACK) STANDARD-F)>

;"Room: SMALL CHAMBER ---------------------------------------------------------"
<ROOM 23-SMALL-CHAMBER
    (DESC "Small Chamber")
    (IN ROOMS)
    (LDESC 
"You are in a small chamber whose only exit is the narrow crack (which has been produced by a recent cave-in) in the
western wall. This is, of course, an extremely stupid arrangement, as nobody could enter this room before the above-mentioned
ave-in. Places like this are only found in badly structured adventure games. Therefore, to make this silly room somewhat
more logical, there is also an opening in the floor, through which you, far below, can see the bottom of a canyon.")
    (WEST TO 22-STAIRCASE-TOP)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (HOLE) STANDARD-F)>

;"Room: FURNITURE SHOP ---------------------------------------------------------"
<ROOM 24-FURNITURE-SHOP
    (DESC "Furniture Shop in Bolton")
    (IN ROOMS)
    (LDESC 
"You are in a furniture shop in Bolton. To the north there is the curtain dept., in which one curtain, namely the one through
which you entered, is especially conspicuous, as it is made of light.")
    (NORTH TO 21-FEATURELESS-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (LIGHT CURTAIN LIGHTCURTAIN) STANDARD-F)>

;"Room: VIEWING ROOM ----------------------------------------------------------"
<ROOM 25-VIEWING-ROOM
    (DESC "Viewing Room")
    (IN ROOMS)
    (LDESC 
"You are in the viewing room of the Werner Dungeon Bank. To the south is the pompous bank entrance, and to the north is a curtain
of light.")
    (NORTH TO 21-FEATURELESS-ROOM)
    (SOUTH TO 29-ENTRANCE-HALL)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (LIGHT CURTAIN LIGHTCURTAIN) STANDARD-F)>

;"Room: SOFT ROOM -------------------------------------------------------------"
<ROOM 26-SOFT-ROOM
    (DESC "Soft Room")
    (IN ROOMS)
    (LDESC 
"You are in the soft room. This room is very soft. It is much more soft than the soft room in Colossal Caves, and a fair deal
softer than the soft room in the Very Big Cave Adventure. This should be enough to make you understand that this room is indeed
very very very very soft. The rug, for example, is so soft that movement within this room should be referred to as wading rather
than walking. The entire room is equally soft, and the room description is pretty soft, too. You might be able to leave the
room by wading to the east.")
    (EAST TO 27-NARROW-LEDGE-MIDDLE)
    (FLAGS LIGHTBIT)
    (THINGS (SOFT) (RUG) SOFT-RUG-F)>

<ROUTINE SOFT-RUG-F ()
    <COND (<AND <VERB? EXAMINE SEARCH> <NOT ,15-SOFT-RUG-FLAG>>
        <TELL ,MESSAGE-039 CR>
        <MOVE ,24-VELVET-CUSHION ,HERE>
        <THIS-IS-IT ,24-VELVET-CUSHION>
        <SETG 15-SOFT-RUG-FLAG T>
        <COND (<NOT ,SCORE-GET-VELVET-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-VELVET-FLAG T>)>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: NARROW LEDGE MIDDLE ---------------------------------------------------"
<ROOM 27-NARROW-LEDGE-MIDDLE
    (DESC "Middle of Narrow Ledge")
    (IN ROOMS)
    (LDESC 
"You are standing in the middle of a narrow ledge in a ravine. On the other side of the ravine is another ledge. High above,
in the ceiling of the cave, is an opening. A passage leads west, and to the south is a location whose room description mainly
consists of a very poor pun.")
    (NORTH TO 20-NARROW-LEDGE-NORTH)
    (SOUTH TO 32-NARROW-LEDGE-SOUTH)
    (WEST TO 26-SOFT-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (HOLE OPENING) STANDARD-F)>

;"Room: NARROW LEDGE ----------------------------------------------------------"
<ROOM 28-NARROW-LEDGE
    (DESC "Narrow Ledge")
    (IN ROOMS)
    (LDESC 
"You are on a narrow ledge in a ravine. High above, you can see an opening in the rock ceiling. You can go east through a large
doorway, over which is written in ugly runes: \"The Werner Dungeon Bank\".")
    (EAST TO 29-ENTRANCE-HALL)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (HOLE OPENING) STANDARD-F)>

;"Room: ENTRANCE HALL ---------------------------------------------------------"
<ROOM 29-ENTRANCE-HALL
    (DESC "Entrance Hall of the Werner Dungeon Bank")
    (IN ROOMS)
    (LDESC 
"You are in the entrance hall of the Werner Dungeon Bank. Big portraits line the walls, and above a door leading north is a sign
in gothic lettering reading: \"Viewing Room\". The exit lies to the west and a passage leads east.")
    (NORTH TO 25-VIEWING-ROOM)
    (EAST TO 37-KEBABERUS-ROOM)
    (WEST TO 28-NARROW-LEDGE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SING PORTRAIT PORTRAITS WALL WALLS LETTERING) STANDARD-F)>     

;"Room: SMALL ROOM ------------------------------------------------------------"
<ROOM 30-SMALL-ROOM
    (DESC "Small Room")
    (IN ROOMS)
    (LDESC 
"You are in a small room which would have been featureless if there hadn't been a lever protruding from one wall, and a large sign
next to it reading: \"Any attempt to push, hit, break, get, drop, wear, doff, read, press, turn, bribe, converse with, shout at,
inhale, eat, drink, give, throw, insert, climb, enter, stand on, inflate, deflate, exhale, attack, cut, paste, plant, shoot, flush,
wash, wave, rub, twist, light or extinguish this lever will inevitably lead to THE DEATH PENALTY!\". The exit lies to the east.")
    (EAST TO 31-USELESS-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE) (SIGN) STANDARD-F
            (<>) (LEVER) LEVER-F)>  

<ROUTINE LEVER-F ()
    <COND (<VERB? PULL>
        <TELL ,MESSAGE-063 CR CR>
        <GOTO ,50-CANYON-BOTTOM-SOUTH>
        <RTRUE>        
    )
    (T
        <JIGS-UP ,MESSAGE-064>
    )>
>

;"Room: USELESS ROOM ----------------------------------------------------------"
<ROOM 31-USELESS-ROOM
    (DESC "Useless Room")
    (IN ROOMS)
    (LDESC 
"You are in another useless room, a passage, which has been thrown in only to increase the number of locations in this adventure.
This east-west unnecessity has yet another abundant corridor emerging from it, namely one to the south.")
    (SOUTH TO 33-CERISE-DOOR-ROOM)
    (EAST TO 32-NARROW-LEDGE-SOUTH)
    (WEST TO 30-SMALL-ROOM)
    (FLAGS LIGHTBIT)> 

;"Room: NARROW LEDGE SOUTH ----------------------------------------------------"
<ROOM 32-NARROW-LEDGE-SOUTH
    (DESC "South End of Narrow Ledge")
    (IN ROOMS)
    (LDESC 
"You are standing at the south end of a narrow ledge. To the west is a passage entering the bedrock. Since this room serves
no real purpose in the adventure, why not use it for a cheap Leather-Goddesses-of-Phobos-Dock-type pun: The Ledge-End Of The
Amazon Women.")
    (NORTH TO 27-NARROW-LEDGE-MIDDLE)
    (WEST TO 31-USELESS-ROOM)
    (FLAGS LIGHTBIT)> 

;"Room: CERISE DOOR ROOM ------------------------------------------------------"
<ROOM 33-CERISE-DOOR-ROOM
    (DESC "Cerise Door Room")
    (IN ROOMS)
    (LDESC 
"You are standing in front of a huge, cerise door. A passage leads north.")
    (NORTH TO 31-USELESS-ROOM)
    (SOUTH PER CERISE-DOOR-ROOM-EXIT)
    (FLAGS LIGHTBIT)>       

<ROUTINE CERISE-DOOR-ROOM-EXIT ()
    <COND (<NOT <IN? ,36-MIDGET ,HERE>>
        <RETURN ,34-JELL-O-ROOM>
    )
    (T
        <TELL ,MESSAGE-067 CR>
        <RFALSE>
    )>
>

;"Room: JELL-O ROOM -----------------------------------------------------------"
<ROOM 34-JELL-O-ROOM
    (DESC "Jell-O Room")
    (IN ROOMS)
    (LDESC 
"You are in a circular room knee-deep with a strange, purple, semi-diaphanous Jell-O. The exit, up a few steps, lies to the north.")
    (NORTH TO 33-CERISE-DOOR-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (SEMI-DIAPHANOUS) (JELL-O JELLO) JELL-O-F)>       

<ROUTINE JELL-O-F ()
    <COND (<AND <VERB? EXAMINE SEARCH> <NOT ,14-JELL-O-FLAG>>
        <TELL ,MESSAGE-037 CR>
        <MOVE ,34-DWARF-SKELETON ,HERE>
        <SETG 14-JELL-O-FLAG T>
        <RTRUE>
    )>
    <COND (<VERB? EAT> 
        <TELL ,MESSAGE-096 CR>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: HUGE DOOR ROOM --------------------------------------------------------"
<ROOM 35-HUGE-DOOR-ROOM
    (DESC "Huge Door Room")
    (IN ROOMS)
    (LDESC 
"You are standing before a huge door bearing a inscription in golden runes: \"Werner's Quest part III\". Next to the door stands
a bearded man wearing a green uniform encumbered with golden shoulder-straps and facings. Carried by the man is a large briefcase
out of which flows vast amount of white smoke. He says: \"Hello advenzurer! My name is Rance ze Dungeonkeeper. I suppose zat
you vish to enter Werner's Kvest part zree, as you have come here. Vat is ze password?\"")
    (SOUTH TO 36-NORTH-EAST-PASSAGE)
    (NORTH ,MESSAGE-082)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (INSCRIPTION RUNES) STANDARD-F)>     

;"Room: NORTH-EAST PASSAGE ----------------------------------------------------"
<ROOM 36-NORTH-EAST-PASSAGE
    (DESC "North-East Passage")
    (IN ROOMS)
    (LDESC 
"You are in a passage turning north and east. An arrow pointing north is marked: \"To Werner's Quest part III\".")
    (NORTH TO 35-HUGE-DOOR-ROOM)
    (EAST TO 07-LIBRARY)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (ARROW) STANDARD-F)>    

;"Room: KEBABERUS ROOM --------------------------------------------------------"
<ROOM 37-KEBABERUS-ROOM
    (DESC "Residence of Kebaberus")
    (IN ROOMS)
    (LDESC 
"You are in the residence of Kebaberus, the legendary three-headed giant mutant dachshund-guard of the southern exit.
A passage leads west and to the south is the southern exit.")
    (WEST TO 29-ENTRANCE-HALL)
    (SOUTH PER KEBABERUS-EXIT)
    (FLAGS LIGHTBIT)> 

<ROUTINE KEBABERUS-EXIT ()
    <COND (<NOT <IN? ,30-KEBABERUS ,HERE>>
        <RETURN ,39-ODDLY-ANGLED-ROOM>
    )
    (T
        <TELL ,MESSAGE-066 CR>
        <RFALSE>
    )>
>

;"Room: ODDLY-ANGLED ROOM MAZE ------------------------------------------------"
<ROOM 38-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which you can see
cheaters and liars.")
    (NORTH TO 38-ODDLY-ANGLED-ROOM)
    (SOUTH TO 41-ODDLY-ANGLED-ROOM)
    (EAST TO 39-ODDLY-ANGLED-ROOM)
    (WEST TO 44-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (CHEATERS LIARS) MAZE-F)> 

<ROOM 39-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see liars and thieves.")
    (NORTH TO 37-KEBABERUS-ROOM)
    (SOUTH TO 42-ODDLY-ANGLED-ROOM)
    (EAST TO 40-ODDLY-ANGLED-ROOM)
    (WEST TO 38-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (LIARS THIEVES) MAZE-F)> 

<ROOM 40-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see robbers and swindlers.")
    (NORTH TO 42-ODDLY-ANGLED-ROOM)
    (SOUTH TO 45-ODDLY-ANGLED-ROOM)
    (EAST TO 43-ODDLY-ANGLED-ROOM)
    (WEST TO 39-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (ROBBERS SWINDLERS) MAZE-F)> 

<ROOM 41-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see smooth-talking chiselers.")
    (NORTH TO 38-ODDLY-ANGLED-ROOM)
    (SOUTH TO 44-ODDLY-ANGLED-ROOM)
    (EAST TO 42-ODDLY-ANGLED-ROOM)
    (WEST TO 45-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (SMOOTH-TALKING) (CHISELERS) MAZE-F)> 

<ROOM 42-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see chumps and decievers.")
    (NORTH TO 39-ODDLY-ANGLED-ROOM)
    (SOUTH TO 40-ODDLY-ANGLED-ROOM)
    (EAST TO 43-ODDLY-ANGLED-ROOM)
    (WEST TO 41-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (CHUMPS DECIEVERS) MAZE-F)> 

<ROOM 43-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see snakes in the grass.")
    (NORTH TO 46-ODDLY-ANGLED-ROOM)
    (SOUTH TO 46-ODDLY-ANGLED-ROOM)
    (EAST TO 40-ODDLY-ANGLED-ROOM)
    (WEST TO 42-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (SNAKE SNAKES) MAZE-F)> 

<ROOM 44-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see tricksters and traitors.")
    (NORTH TO 41-ODDLY-ANGLED-ROOM)
    (SOUTH TO 45-ODDLY-ANGLED-ROOM)
    (EAST TO 45-ODDLY-ANGLED-ROOM)
    (WEST TO 44-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (TRICKSTERS TRAITORS) MAZE-F)> 

<ROOM 45-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see landrats and lifters.")
    (NORTH TO 44-ODDLY-ANGLED-ROOM)
    (SOUTH TO 46-ODDLY-ANGLED-ROOM)
    (EAST TO 40-ODDLY-ANGLED-ROOM)
    (WEST TO 41-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (LANDRATS LIFTERS) MAZE-F)> 

<ROOM 46-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room. In the floor is set a small diamond-shaped window through which
you can see arsonists in hoods.")
    (NORTH TO 43-ODDLY-ANGLED-ROOM)
    (SOUTH TO 45-ODDLY-ANGLED-ROOM)
    (EAST TO 47-ODDLY-ANGLED-ROOM)
    (WEST TO 43-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)
    (THINGS (DIAMOND DIAMOND-SHAPED) (WINDOW) STANDARD-F
            (<>) (ARSONIST ARSONISTS) MAZE-F)> 

<ROOM 47-ODDLY-ANGLED-ROOM
    (DESC "Oddly-Angled Room")
    (IN ROOMS)
    (LDESC 
"You are in an oddly-angled room.")
    (NORTH TO 46-ODDLY-ANGLED-ROOM)
    (SOUTH TO 46-ODDLY-ANGLED-ROOM)
    (EAST TO 46-ODDLY-ANGLED-ROOM)
    (WEST TO 46-ODDLY-ANGLED-ROOM)
    (FLAGS LIGHTBIT MAZEBIT)> 

<ROUTINE MAZE-F ()
    <COND (<VERB? EXAMINE>
        <TELL ,MESSAGE-094 CR>
        <RTRUE>
    )>
>

;"Room: CAVE ------------------------------------------------------------------"
<ROOM 48-CAVE
    (DESC "Cave")
    (IN ROOMS)
    (LDESC 
"You are in a cave. From some scribblings on one of the walls, reading \"Arthur Dent was here\", you conclude that Arthur
Dent has been in this cave. Upon further reflection, you assume that this is the cave in which Arthur Dent once spent five
years. In one corner lies a pile of furs. The exit is west.")
    (WEST TO 49-CANYON-BOTTOM-NORTH)
    (IN PER CAVE-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SCRIBBLINGS) STANDARD-F
            (<>) (FUR FURS) FURS-F)> 

<ROUTINE CAVE-EXIT ()
    <COND (<IN? ,41-WORMHOLE ,HERE>
        <RETURN ,51-XYZZY-ROOM>
    )
    (T
        <TELL ,SYSMESSAGE-007 CR>
        <RFALSE>
    )>
>

<ROUTINE FURS-F ()
    <COND (<VERB? EXAMINE SEARCH>
        <COND(<=? <LOC ,41-WORMHOLE> ,HERE>
            <TELL ,MESSAGE-032 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-031 CR>
            <MOVE ,41-WORMHOLE ,HERE>
            <RTRUE>
        )>
    )>
>

;"Room: CANYON BOTTOM NORTH ---------------------------------------------------"
<ROOM 49-CANYON-BOTTOM-NORTH
    (DESC "North End of Canyon Bottom")
    (IN ROOMS)
    (LDESC 
"You are in the northern end of the canyon bottom. To the east is a small cave.")
    (EAST TO 48-CAVE)
    (FLAGS LIGHTBIT)> 

;"Room: CANYON BOTTOM SOUTH ---------------------------------------------------"
<ROOM 50-CANYON-BOTTOM-SOUTH
    (DESC "South End of Canyon Bottom")
    (IN ROOMS)
    (LDESC 
"You are in the southern end of the canyon bottom. To the west is a round hole in the rock wall.")
    (NORTH TO 49-CANYON-BOTTOM-NORTH)
    (WEST ,MESSAGE-065)
    (FLAGS LIGHTBIT)
    (THINGS (ROUND) (HOLE) STANDARD-F)> 

;"Room: XYZZY ROOM ------------------------------------------------------------"
<ROOM 51-XYZZY-ROOM
    (DESC "\"XYZZY\" Room")
    (IN ROOMS)
    (LDESC 
"You are in room filled with debris washed from the ceiling. On one of the walls, the word \"XYZZY\" is carved with
crude runes. The room once had exits to the east and west, but they are now blocked by debris.")
    (FLAGS LIGHTBIT)
    (THINGS (<>) (RUNDES DEBRIS) STANDARD-F)> 

;"Room: GRAND-FATHER CLOCK -----------------------------------------------------"
<ROOM 52-GRANDFATHER-CLOCK
    (DESC "Inside Grand-father Clock")
    (IN ROOMS)
    (LDESC 
"You are standing inside a large grand-father clock. A red button is right in front of your face, almost asking you to press it.")
    (OUT TO 54-L9-OFFICE)
    (FLAGS LIGHTBIT)
    (THINGS (RED) (BUTTON) RED-BUTTON-2-F)>

<ROUTINE RED-BUTTON-2-F () 
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-038 CR>
        <MOVE ,PLAYER ,09-GRANDFATHER-CLOCK>
        <FSET ,09-GRANDFATHER-CLOCK ,TOUCHBIT>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: IN BRICK BUILDING -----------------------------------------------------"
<ROOM 53-IN-BRICK-BUILDING
    (DESC "In Small Brick Building")
    (IN ROOMS)
    (LDESC 
"You are in a small small brick building. This place gives you a faint sense of Deja Vu. You feel, however, that something is
missing. Suddenly it strikes you: The well is missing. The floor, in which the well should be positioned, consists only of
wooden planks.")
    (FLAGS LIGHTBIT)
    (ACTION BRICK-BUILDING-F)
    (THINGS (<>) (FLOOR PLANK PLANKS BEAM BEAMS) STANDARD-F)>

<ROUTINE BRICK-BUILDING-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <NOT <=? <LOC ,40-THING-FISH> ,HERE>>>
        <TELL CR ,MESSAGE-072 CR>
        <MOVE ,40-THING-FISH ,HERE>
        <RTRUE>
    )>
    <COND (<AND <=? .RARG ,M-BEG> <VERB? LOOK-UP>>
        <TELL ,MESSAGE-074 CR>
        <RTRUE>
    )>
>

;"Room: L9 OFFICE -------------------------------------------------------------"
<ROOM 54-L9-OFFICE
    (DESC "Office of Level 9 Software")
    (IN ROOMS)
    (LDESC 
"You are in the office of Level 9 Software. The walls are hung with posters depicting the packages of various L9 adventures.
A grandfather clock stands in one corner, and behind the desk sits no other than Pete Austin.")
    (IN TO 52-GRANDFATHER-CLOCK)
    (ACTION L9-ROOM-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (POSTER POSTERS) STANDARD-F
            (GRANDFATHER) (CLOCK) GRANDFATHER-CLOCK-F)>

<ROUTINE L9-ROOM-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <NOT ,17-L9-FLAG> <HELD? ,09-SWORD> <HELD? ,10-LANTERN> <HELD? ,11-BOTTLE>>
        <TELL CR ,MESSAGE-049 CR>
        <SETG 17-L9-FLAG T>
        <MOVE ,12-MONEY ,PLAYER>
        <COND (<NOT ,SCORE-PETE-AUSTIN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-PETE-AUSTIN-FLAG T>)>
        <RTRUE>
    )>
>

;"-----------------------------------------------------------------------------
; OBJECTS
; -----------------------------------------------------------------------------"

;"Object: CUPCAKE -------------------------------------------------------------"
<OBJECT CUPCAKE
	(IN GLOBAL-OBJECTS)
	(SYNONYM CUPCAKE CUPCAKES)
	(DESC "cupcake")
    (ACTION CUPCAKE-F)
	(FLAGS NDESCBIT)>

<ROUTINE CUPCAKE-F ()
    <COND (<VERB? SAY TELL-ABOUT>
        <COND (<AND <NOT ,18-RIDDLE-FLAG> <=? <LOC ,PLAYER> ,14-RIDDLE-ROOM>>
           <TELL ,MESSAGE-053 CR>
           <SETG 18-RIDDLE-FLAG T>
           <RTRUE>
        )>
    )
    (T
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Object: MATRESS -------------------------------------------------------------"
<OBJECT MATRESS
	(IN GLOBAL-OBJECTS)
	(SYNONYM MATRESS)
	(DESC "matress")
    (ACTION MATRESS-F)
	(FLAGS NDESCBIT)>

<ROUTINE MATRESS-F ()
    <COND (<VERB? SAY TELL-ABOUT>
        <COND (<IN? ,25-MR-LAMBERTH ,HERE> 
            <TELL ,MESSAGE-077 CR>
            <MOVE ,25-MR-LAMBERTH ,LOCAL-GLOBALS>
            <MOVE ,26-MR-LAMBERTH-WITH-BUCKET ,HERE>
            <COND (<NOT ,SCORE-GET-SATIN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-SATIN-FLAG T>)>
            <RTRUE>
        )>
     )
    (T
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Object: CROOK ---------------------------------------------------------------"
<OBJECT CROOK
	(IN GLOBAL-OBJECTS)
	(SYNONYM CROOK)
	(DESC "crook")
    (ACTION CROOK-F)
	(FLAGS NDESCBIT)>

<ROUTINE CROOK-F ()
    <COND (<VERB? SAY TELL-ABOUT>
        <COND (<=? ,HERE ,35-HUGE-DOOR-ROOM> 
            <COND (<NOT ,SCORE-SOLVE-GAME-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-SOLVE-GAME-FLAG T>)>
            <JIGS-UP ,MESSAGE-081>
            <RTRUE>
        )>
     )
    (T
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Object: XYZZY ---------------------------------------------------------------"
<OBJECT XYZZY
	(IN GLOBAL-OBJECTS)
	(SYNONYM XYZZY)
	(DESC "XYZZY")
    (ACTION XYZZY-F)
	(FLAGS NDESCBIT NARTICLEBIT)>

<ROUTINE XYZZY-F ()
    <COND (<VERB? SAY TELL-ABOUT>
        <COND (<=? <LOC ,PLAYER> ,51-XYZZY-ROOM>
           <GOTO ,53-IN-BRICK-BUILDING>
           <RTRUE>
        )>
        <COND (<=? <LOC ,PLAYER> ,53-IN-BRICK-BUILDING>
           <GOTO ,51-XYZZY-ROOM>
           <RTRUE>
        )>
    )
    (T
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Object: PLUGH ---------------------------------------------------------------"
<OBJECT PLUGH
	(IN GLOBAL-OBJECTS)
	(SYNONYM PLUGH PLOVER)
	(DESC "PLUGH")
    (ACTION PLUGH-F)
	(FLAGS NDESCBIT NARTICLEBIT)>

<ROUTINE PLUGH-F ()
    <COND (<VERB? SAY TELL-ABOUT>
        <COND (<=? <LOC ,40-THING-FISH> ,HERE>
           <TELL ,MESSAGE-101 CR>
           <RTRUE>
        )>
   )
    (T
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"Object: GNOME ---------------------------------------------------------------"
<OBJECT GNOME
	(IN 17-ENTRY-HALL)
	(SYNONYM GNOME)
	(DESC "gnome")
    (ACTION GNOME-F)
    (FLAGS PERSONBIT NDESCBIT)>

<ROUTINE GNOME-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-093 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
    <COND (<AND <VERB? WAKE> <=? ,PLAYER ,WINNER>>
        <TELL ,MESSAGE-076 CR>
        <RTRUE>
    )>
>

;"Object: MUFFIN MAN ----------------------------------------------------------"
<OBJECT MUFFIN-MAN
	(IN 18-LABORATORY)
	(SYNONYM MAN MUFFIN-MAN)
    (ADJECTIVE MUFFIN)
	(DESC "muffin man")
    (ACTION MUFFIN-MAN-F)
    (FLAGS PERSONBIT NDESCBIT)>

<ROUTINE MUFFIN-MAN-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-093 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
>

;"Object: PETER AUSTIN --------------------------------------------------------"
<OBJECT PETER-AUSTIN
	(IN 54-L9-OFFICE)
	(SYNONYM PETE PETER AUSTIN)
	(DESC "Peter Austin")
    (ACTION PETER-AUSTIN-F)
    (FLAGS PERSONBIT NDESCBIT NARTICLEBIT)>

<ROUTINE PETER-AUSTIN-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-091 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
>

;"Object: OGRE ----------------------------------------------------------------"
<OBJECT OGRE
	(IN 04-GIFT-SHOP)
	(SYNONYM OGRE)
	(DESC "Ogre")
    (ACTION OGRE-F)
    (FLAGS PERSONBIT NDESCBIT NARTICLEBIT)>

<ROUTINE OGRE-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-093 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
>

;"Object: RANCE THE DUNGEONKEEPER ---------------------------------------------"
<OBJECT RANCE
	(IN 35-HUGE-DOOR-ROOM)
	(SYNONYM RANCE DUNGEONKEEPER)
	(DESC "Rance ze Dungeonkeeper")
    (ACTION RANCE-F)
    (FLAGS NDESCBIT NARTICLEBIT PERSONBIT)>

<ROUTINE RANCE-F ()
    <COND (<VERB? TELL TELL-ABOUT>
        <TELL ,MESSAGE-093 CR>
        <SETG P-CONT -1>
        <RTRUE>
    )>
 >

;"Object: POINTS --------------------------------------------------------------"
<OBJECT LINE
	(IN GLOBAL-OBJECTS)
	(SYNONYM LINE P Q)
	(DESC "Line")
    (ACTION LINE-F)
    (FLAGS NDESCBIT)>

<ROUTINE LINE-F ()
    <COND (<AND <VERB? MAKE-LINE> <HELD? ,18-PENCIL> <=? ,HERE ,05-MAP-ROOM>>
        <TELL ,MESSAGE-054 CR>
        <RTRUE>
    )>
>

;"Object: POTATOES ------------------------------------------------------------"
<OBJECT 01-POTATOES
	(IN PLAYER)
	(SYNONYM POTATOES)
    (ADJECTIVE MASHED)
	(DESC "Some mashed potatoes")
    (TEXT ,MESSAGE-007)
    (ACTION POTATOES-F)
    (FLAGS TAKEBIT NARTICLEBIT EDIBLEBIT)>

<ROUTINE POTATOES-F ()
    <COND (<VERB? EAT>
        <TELL ,MESSAGE-102 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
    )>
>

;"Object: MAP -----------------------------------------------------------------"
<OBJECT 02-MAP
	(IN PLAYER)
	(SYNONYM MAP)
    (ADJECTIVE CURIOUS)
	(DESC "curious map")
    (TEXT ,MESSAGE-008)
    (FLAGS TAKEBIT READBIT)>

;"Object: MUFFIN WITH SPOON ---------------------------------------------------"
<OBJECT 03-MUFFIN-WITH-SPOON
	(IN 03-JUNCTION)
	(SYNONYM MUFFIN)
    (ADJECTIVE GIGANTIC)
	(DESC "gigantic muffin, in which is embedded an oversized, chrome spoon")
    (TEXT ,MESSAGE-009)>

;"Object: MUFFIN --------------------------------------------------------------"
<OBJECT 04-MUFFIN
	(IN LOCAL-GLOBALS)
	(SYNONYM MUFFIN)
    (ADJECTIVE GIGANTIC)
	(DESC "gigantic muffin")
    (TEXT ,MESSAGE-010)
    (FLAGS CONTBIT)>

;"Object: SPOON ---------------------------------------------------------------"
<OBJECT 05-SPOON
	(IN LOCAL-GLOBALS)
	(SYNONYM SPOON)
    (ADJECTIVE OVERSIZED CHROME)
	(DESC "oversized chrome spoon")
    (ACTION SPOON-F)
    (FLAGS TAKEBIT VOWELBIT)>

<ROUTINE SPOON-F ()
    <COND (<AND <VERB? INSERT> <=? <LOC ,04-MUFFIN> ,HERE>>
        <MOVE ,05-SPOON ,LOCAL-GLOBALS>
        <MOVE ,04-MUFFIN ,LOCAL-GLOBALS>
        <MOVE ,03-MUFFIN-WITH-SPOON ,HERE>
        <TELL ,MESSAGE-103 CR>
    )>
    <COND (<AND <VERB? DROP> <=? ,HERE ,17-ENTRY-HALL>>
        <TELL ,SYSMESSAGE-008 CR>
    )>
>

;"Object: COIN ----------------------------------------------------------------"
<OBJECT 06-COIN
	(IN LOCAL-GLOBALS)
	(SYNONYM COIN ZORKMID)
    (ADJECTIVE SHINY)
	(DESC "shiny coin")
    (TEXT ,MESSAGE-011)
    (FLAGS TAKEBIT)>

;"Object: MAGNIFYING GLASS ----------------------------------------------------"
<OBJECT 07-MAGNIFYING-GLASS
	(IN 36-NORTH-EAST-PASSAGE)
	(SYNONYM GLASS)
    (ADJECTIVE MAGNIFYING)
	(DESC "magnifying glass")
    (TEXT ,MESSAGE-012)
    (FLAGS TAKEBIT)>

;"Object: ADVENTURE-KIT -------------------------------------------------------"
<OBJECT 08-ADVENTURE-KIT
	(IN 04-GIFT-SHOP)
	(SYNONYM KIT BOX)
    (ADJECTIVE ADVENTURE LITTLE)
	(DESC "box labelled \"The Little Adventurer\"")
    (ACTION ADVENTURE-KIT-F)
    (FLAGS NDESCBIT)>

<ROUTINE ADVENTURE-KIT-F ()
    <COND (<AND <VERB? OPEN> <HELD? ,08-ADVENTURE-KIT>>
        <TELL ,MESSAGE-044 CR>
        <MOVE ,09-SWORD ,HERE>
        <MOVE ,10-LANTERN ,HERE>
        <MOVE ,11-BOTTLE ,HERE>
        <MOVE ,08-ADVENTURE-KIT ,LOCAL-GLOBALS>
        <RTRUE>
    )>
>

;"Object: SWORD ---------------------------------------------------------------"
<OBJECT 09-SWORD
	(IN LOCAL-GLOBALS)
	(SYNONYM SWORD)
    (ADJECTIVE PLASTIC)
	(DESC "plastic sword")
    (TEXT ,MESSAGE-013)
    (FLAGS TAKEBIT)>

;"Object: LANTERN -------------------------------------------------------------"
<OBJECT 10-LANTERN
	(IN LOCAL-GLOBALS)
	(SYNONYM LANTERN LAMP)
    (ADJECTIVE SMALL)
	(DESC "small lantern")
    (TEXT ,MESSAGE-014)
    (FLAGS TAKEBIT)>

;"Object: BOTTLE --------------------------------------------------------------"
<OBJECT 11-BOTTLE
	(IN LOCAL-GLOBALS)
	(SYNONYM BOTTLE)
    (ADJECTIVE EMPTY)
	(DESC "empty bottle")
    (TEXT ,MESSAGE-015)
    (FLAGS TAKEBIT VOWELBIT)>

;"Object: MONEY ---------------------------------------------------------------"
<OBJECT 12-MONEY
	(IN LOCAL-GLOBALS)
	(SYNONYM WHEELBARROW MONEY)
	(DESC "wheelbarrow of money")
    (TEXT ,MESSAGE-078)
    (FLAGS TAKEBIT)>

;"Object: BEAM ----------------------------------------------------------------"
<OBJECT 13-BEAM
	(IN 04-GIFT-SHOP)
	(SYNONYM BEAM)
    (ADJECTIVE WOODEN)
	(DESC "wooden beam")
    (TEXT ,MESSAGE-016)
    (ACTION BEAM-F)
    (FLAGS NDESCBIT)>

<ROUTINE BEAM-F ()
    <COND (<AND <VERB? DROP> <HELD? ,PRSO> <=? ,HERE ,23-SMALL-CHAMBER>>
        <MOVE ,13-BEAM ,LOCAL-GLOBALS>
        <MOVE ,23-BEAM-ACROSS-OPENING ,HERE>
        <MOVE ,28-BEAM-VISIBLE-THROUGH-HOLE ,27-NARROW-LEDGE-MIDDLE>
        <THIS-IS-IT ,23-BEAM-ACROSS-OPENING>
        <TELL ,MESSAGE-004 CR>
        <RTRUE>
    )>
>

;"Object: CAN -----------------------------------------------------------------"
<OBJECT 14-CAN
	(IN 04-GIFT-SHOP)
	(SYNONYM CAN REPELLENT)
    (ADJECTIVE AEROSOL GRUE)
	(DESC "aerosol can of Grue Repellent")
    (TEXT ,MESSAGE-017)
    (ACTION CAN-F)
    (FLAGS NDESCBIT VOWELBIT)>

<ROUTINE CAN-F ()
    <COND (<AND <VERB? SPRAY> <HELD? ,PRSO>>
        <TELL ,MESSAGE-098 CR>
        <MOVE ,14-CAN ,LOCAL-GLOBALS>
        <MOVE ,42-REPELLENT ,PLAYER>
        <RTRUE>
    )>
>

;"Object: SHOVEL --------------------------------------------------------------"
<OBJECT 15-SHOVEL
	(IN 04-GIFT-SHOP)
	(SYNONYM SHOVEL)
	(DESC "shovel")
    (FLAGS NDESCBIT)>

;"Object: WRENCH --------------------------------------------------------------"
<OBJECT 16-WRENCH
	(IN 04-GIFT-SHOP)
	(SYNONYM WRENCH)
	(DESC "wrench")
    (FLAGS NDESCBIT)>

;"Object: SECRET PASSAGE ------------------------------------------------------"
<OBJECT 17-SECRET-PASSAGE
	(IN LOCAL-GLOBALS)
	(SYNONYM PASSAGE)
    (ADJECTIVE SECRET)
	(DESC "secret passage leading west behind the bookcase")>

;"Object: PENCIL --------------------------------------------------------------"
<OBJECT 18-PENCIL
	(IN 05-MAP-ROOM)
	(SYNONYM PENCIL PEN)
    (ADJECTIVE CHEWN WELL-CHEWN)
	(DESC "well-chewn pencil")
    (FLAGS TAKEBIT)>

;"Object: TIED-UP WIZARD ------------------------------------------------------"
<OBJECT 19-TIED-UP-WIZARD
	(IN 16-BROOM-CLOSET)
	(SYNONYM WIZARD)
    (ADJECTIVE SECURELY TIED)
	(DESC "The item that the brooms have been tossed out to make room for, namely The Wizard of Frobozz, securely tied up in Theobaldian Auto-Knotting Rope")
    (TEXT ,MESSAGE-018)
    (ACTION TIED-UP-WIZARD-F)
    (FLAGS NARTICLEBIT)>

<ROUTINE TIED-UP-WIZARD-F ()
    <COND (<VERB? UNTIE>
        <TELL ,MESSAGE-050 CR>
        <MOVE ,19-TIED-UP-WIZARD ,LOCAL-GLOBALS>
        <FCLEAR ,20-ROPE ,NDESCBIT>
        <FSET ,20-ROPE ,TAKEBIT>
        <THIS-IS-IT ,20-ROPE>
        <COND (<NOT ,SCORE-FREE-WIZARD-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-FREE-WIZARD-FLAG T>)>

    )>
>

;"Object: ROPE ----------------------------------------------------------------"
<OBJECT 20-ROPE
	(IN 16-BROOM-CLOSET)
	(SYNONYM ROPE)
    (ADJECTIVE THEOBALDIAN AUTO-KNOTTING HEMP)
	(DESC "length of Theobaldian Auto-Knotting Rope")
    (TEXT ,MESSAGE-062)
    (ACTION ROPE-F)
    (FLAGS NDESCBIT)>

<ROUTINE ROPE-F ()
    <COND (<AND <VERB? UNTIE> <=? <LOC ,19-TIED-UP-WIZARD> ,HERE>>
        <TIED-UP-WIZARD-F>
        <RTRUE>
    )>
    <COND (<AND <VERB? TIE> <HELD? ,20-ROPE>>
        <TELL "You don't need to do that, the rope is of the Theobaldian Auto-Knotting type." CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? THROW THROW-AT> <HELD? ,PRSO>>
        <COND (<AND <NOT <=? <LOC ,28-BEAM-VISIBLE-THROUGH-HOLE> ,HERE>> <NOT <=? <LOC ,40-THING-FISH> ,HERE>>>
            <TELL ,MESSAGE-051 CR>
            <RTRUE>
        )>
        <COND (<=? <LOC ,28-BEAM-VISIBLE-THROUGH-HOLE> ,HERE>
            <TELL ,MESSAGE-052 CR CR>
            <MOVE ,28-BEAM-VISIBLE-THROUGH-HOLE ,LOCAL-GLOBALS>
            <MOVE ,23-BEAM-ACROSS-OPENING ,LOCAL-GLOBALS>
            <MOVE ,38-BROKEN-BEAM ,49-CANYON-BOTTOM-NORTH>
            <GOTO ,28-NARROW-LEDGE>
            <COND (<NOT ,SCORE-NARROW-LEDGE-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-NARROW-LEDGE-FLAG T>)>
            <RTRUE>
        )>
        <COND (<=? <LOC ,40-THING-FISH> ,HERE>
            <TELL ,MESSAGE-073 CR CR>
            <TELL ,MESSAGE-075 CR CR>
            <MOVE ,20-ROPE ,10-LOST-AND-FOUND>
            <MOVE ,23-BEAM-ACROSS-OPENING ,LOCAL-GLOBALS>
            <GOTO ,08-LOBBY>
            <COND (<NOT ,SCORE-ESCAPE-BUILDING-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ESCAPE-BUILDING-FLAG T>)>
            <RTRUE>
        )>
    )>
    <COND (<VERB? GIVE> 
        <COND (<AND <=? <LOC ,31-ZAPHOD> ,HERE> <HELD? ,20-ROPE> <=? ,PRSI ,31-ZAPHOD>>
            <TELL ,MESSAGE-057 CR>
            <MOVE ,31-ZAPHOD ,LOCAL-GLOBALS>
            <MOVE ,20-ROPE ,LOCAL-GLOBALS>
            <MOVE ,29-RADIO ,HERE>
            <FSET ,29-RADIO ,TAKEBIT>
            <FCLEAR ,29-RADIO ,NDESCBIT>
            <THIS-IS-IT ,29-RADIO>
            <COND (<NOT ,SCORE-GET-RADIO-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-RADIO-FLAG T>)>
            <RTRUE>
        )>
    )>
>

;"Object: CAKE ----------------------------------------------------------------"
<OBJECT 21-CAKE
	(IN 15-TEA-ROOM)
	(SYNONYM CAKE)
    (ADJECTIVE CERISE)
	(DESC "cake with cerise lettering")
    (ACTION CAKE-F)
    (FLAGS TAKEBIT EDIBLEBIT READBIT)>

<ROUTINE CAKE-F () 
    <COND (<VERB? EXAMINE READ>
        <COND (<HELD? ,07-MAGNIFYING-GLASS>
            <TELL ,MESSAGE-020 CR>
        )
        (T
            <TELL ,MESSAGE-019 CR>
        )>
        <RTRUE>
    )>
    <COND (<VERB? EAT>
        <JIGS-UP ,MESSAGE-095>
    )>
    <COND (<AND <VERB? GIVE> <HELD? ,PRSO> <IN? ,36-MIDGET ,HERE>>
        <TELL ,MESSAGE-070 CR>
        <MOVE ,36-MIDGET ,LOCAL-GLOBALS>
        <MOVE ,21-CAKE ,LOCAL-GLOBALS>
        <SETG 20-MIDGET-FLAG T>
    )>
>

;"Object: ROSETTE -------------------------------------------------------------"
<OBJECT 22-ROSETTE
	(IN LOCAL-GLOBALS)
	(SYNONYM ROSETTE)
    (ADJECTIVE LARGE GREEN)
	(DESC "large, green rosette")
    (ACTION ROSETTE-F)
    (FLAGS TAKEBIT)>

<ROUTINE ROSETTE-F ()
    <COND (<AND <VERB? TIE GIVE> <HELD? ,PRSO> <=? ,PRSI ,30-KEBABERUS> <=? <LOC ,PRSI> ,HERE>>
        <TELL ,MESSAGE-056 CR>
        <MOVE ,22-ROSETTE ,LOCAL-GLOBALS>
        <MOVE ,30-KEBABERUS ,LOCAL-GLOBALS>
    )>
>

;"Object: BEAM ACROSS OPENING -------------------------------------------------"
<OBJECT 23-BEAM-ACROSS-OPENING
	(IN LOCAL-GLOBALS)
	(SYNONYM BEAM)
    (ADJECTIVE WOODEN)
	(DESC "wooden beam, placed across the opening in the floor")
    (ACTION BEAM-ACROSS-OPENING-F)
    (FLAGS TAKEBIT)>

<ROUTINE BEAM-ACROSS-OPENING-F ()
    <COND (<AND <VERB? TAKE> <=? ,HERE ,23-SMALL-CHAMBER>>
        <MOVE ,13-BEAM ,PLAYER>
        <MOVE ,23-BEAM-ACROSS-OPENING ,LOCAL-GLOBALS>
        <MOVE ,28-BEAM-VISIBLE-THROUGH-HOLE ,LOCAL-GLOBALS>
        <THIS-IS-IT ,13-BEAM>
        <TELL "You pick up " T ,13-BEAM "." CR>
        <RTRUE>
    )>
>

;"Object: VELVET CUSHION ------------------------------------------------------"
<OBJECT 24-VELVET-CUSHION
	(IN LOCAL-GLOBALS)
	(SYNONYM CUSHION)
    (ADJECTIVE VELVET)
	(DESC "velvet cushion")
    (FLAGS TAKEBIT)>

;"Object: MR LAMBERTH ---------------------------------------------------------"
<OBJECT 25-MR-LAMBERTH
	(IN 24-FURNITURE-SHOP)
	(SYNONYM LAMBERTH)
    (ADJECTIVE MR)
	(DESC "Mr Lamberth, carefully examining the boutique, searching for shoplifters")
    (ACTION LAMBERTH-F)
    (FLAGS NARTICLEBIT PERSONBIT)>

<ROUTINE LAMBERTH-F ()
    <COND (<VERB? TELL TELL-ABOUT>
        <TELL ,MESSAGE-093 CR>
        <SETG P-CONT -1>
        <RTRUE>
    )>
 >

;"Object: MR LAMBERTH WITH BUCKET ---------------------------------------------"
<OBJECT 26-MR-LAMBERTH-WITH-BUCKET
	(IN LOCAL-GLOBALS)
	(SYNONYM LAMBERTH)
    (ADJECTIVE MR)
	(DESC "Mr Lamberth, wearing a bucket over his head")
    (ACTION LAMBERTH-F)
    (FLAGS NARTICLEBIT PERSONBIT)>

;"Object: SATIN CUSHION -------------------------------------------------------"
<OBJECT 27-SATIN-CUSHION
	(IN 24-FURNITURE-SHOP)
	(SYNONYM CUSHION)
    (ADJECTIVE SATIN)
	(DESC "satin cushion")
    (ACTION SATIN-CUSHION-F)
    (FLAGS TAKEBIT)>

<ROUTINE SATIN-CUSHION-F ()
    <COND (<AND <VERB? TAKE> <IN? ,25-MR-LAMBERTH ,HERE>>
        <TELL ,MESSAGE-005 CR>
        <RTRUE>
    )>
>

;"Object: BEAM VISIBLE THROUGH HOLE -------------------------------------------"
<OBJECT 28-BEAM-VISIBLE-THROUGH-HOLE
	(IN LOCAL-GLOBALS)
	(SYNONYM BEAM)
    (ADJECTIVE WOODEN)
	(DESC "beam, visible through the opening in the ceiling")>

;"Object: RADIO ---------------------------------------------------------------"
<OBJECT 29-RADIO
	(IN LOCAL-GLOBALS)
	(SYNONYM RADIO)
    (ADJECTIVE TRANSISTOR)
	(DESC "transistor radio")
    (ACTION RADIO-F)
    (FLAGS NDESCBIT CONTBIT DEVICEBIT)>

<ROUTINE RADIO-F ()
    <COND (<AND <VERB? TAKE> <=? <LOC ,31-ZAPHOD> ,HERE>>
        <TELL ,MESSAGE-006 CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? TURN-ON> <HELD? ,PRSO>>
        <TELL ,MESSAGE-059 CR>
        <RTRUE>
    )>
>

;"Object: KEBABERUS -----------------------------------------------------------"
<OBJECT 30-KEBABERUS
	(IN 37-KEBABERUS-ROOM)
	(SYNONYM KEABAERUS HOUND DOG DACHSHUND GUARD)
    (ADJECTIVE THREE-HEADED GIANT MUTANT)
	(DESC "Kebaberus")
    (TEXT ,MESSAGE-022)
    (FLAGS NARTICLEBIT TIEABLEBIT PERSONBIT)>

;"Object: ZAPHOD --------------------------------------------------------------"
<OBJECT 31-ZAPHOD
	(IN 47-ODDLY-ANGLED-ROOM)
	(SYNONYM ANGEL ZAPHOD BEEBLEBROX)
    (ADJECTIVE ODD)
	(DESC "odd angel, holding a transistor radio")
    (TEXT ,MESSAGE-023)
    (ACTION ANGEL-F)
    (FLAGS PERSONBIT VOWELBIT)>

<ROUTINE ANGEL-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-092 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
>

;"Object: RADIO ---------------------------------------------------------------"
<OBJECT 32-RADIO-WITH-BATTERY
	(IN LOCAL-GLOBALS)
	(SYNONYM RADIO)
    (ADJECTIVE TRANSISTOR)
	(DESC "transistor radio")
    (ACTION RADIO-WITH-BATTERY-F)
    (FLAGS TAKEBIT DEVICEBIT)>

<ROUTINE RADIO-WITH-BATTERY-F ()
    <COND (<AND <VERB? TURN-ON> <HELD? ,PRSO>>
        <TELL ,MESSAGE-060 CR>
        <MOVE ,32-RADIO-WITH-BATTERY ,LOCAL-GLOBALS>
        <MOVE ,33-RADIO-MELLOW-YELLOW ,PLAYER>
        <RTRUE>
    )>
>

;"Object: RADIO MELLOW YELLOW -------------------------------------------------"
<OBJECT 33-RADIO-MELLOW-YELLOW
	(IN LOCAL-GLOBALS)
	(SYNONYM RADIO)
    (ADJECTIVE TRANSISTOR)
	(DESC "transistor radio, out of which flows \"Mellow yellow\" by Donovan")
    (ACTION RADIO-MELLOW-YELLOW-F)
    (FLAGS TAKEBIT DEVICEBIT)>

<ROUTINE RADIO-MELLOW-YELLOW-F ()
    <COND (<AND <VERB? TURN-OFF> <HELD? ,PRSO>>
        <TELL ,MESSAGE-061 CR>
        <MOVE ,33-RADIO-MELLOW-YELLOW ,LOCAL-GLOBALS>
        <MOVE ,32-RADIO-WITH-BATTERY ,PLAYER>
        <RTRUE>
    )>
>

;"Object: DWARF SKELETON ------------------------------------------------------"
<OBJECT 34-DWARF-SKELETON
	(IN LOCAL-GLOBALS)
	(SYNONYM DWARF SKELETON)
	(DESC "skeleton of a dwarf")
    (ACTION DWARF-SKELETON-F)
    (FLAGS TAKEBIT)>

<ROUTINE DWARF-SKELETON-F ()
    <COND (<AND <VERB? EXAMINE SEARCH> <NOT ,12-DWARF-SKELETON-FLAG>>
        <TELL ,MESSAGE-024 CR>
        <MOVE ,35-BATTERY ,HERE>
        <SETG 12-DWARF-SKELETON-FLAG T>
        <COND (<NOT ,SCORE-BATTERY-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-BATTERY-FLAG T>)>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Object: BATTERY -------------------------------------------------------------"
<OBJECT 35-BATTERY
	(IN LOCAL-GLOBALS)
	(SYNONYM BATTERY)
    (ADJECTIVE THEOBALDIAN MAGIC)
	(DESC "Theobaldian magic battery")
    (TEXT ,MESSAGE-025)
    (ACTION BATTERY-F)
    (FLAGS TAKEBIT)>

<ROUTINE BATTERY-F ()
    <COND (<VERB? PUT-IN INSERT> 
        <COND (<AND <HELD? ,PRSO> <HELD? ,PRSI> <=? ,PRSI ,29-RADIO>>
            <TELL ,MESSAGE-058 CR>
            <MOVE ,29-RADIO ,LOCAL-GLOBALS>
            <MOVE ,35-BATTERY ,LOCAL-GLOBALS>
            <MOVE ,32-RADIO-WITH-BATTERY ,PLAYER>
            <RTRUE>
        )>
    )>
>

;"Object: MIDGET --------------------------------------------------------------"
<OBJECT 36-MIDGET
	(IN 33-CERISE-DOOR-ROOM)
	(SYNONYM MIDGET)
    (ADJECTIVE SHAVEN NEATLY-SHAVEN)
	(DESC "neatly-shaven midget, brandishing a two-handed battle Gilette safety-razor")
    (TEXT ,MESSAGE-026)
    (ACTION MIDGET-F)
    (FLAGS PERSONBIT)>

<ROUTINE MIDGET-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-093 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
>

;"Object: POSTER --------------------------------------------------------------"
<OBJECT 37-POSTER
	(IN LOCAL-GLOBALS)
	(SYNONYM POSTER)
	(DESC "\"Wanted\"-poster taped to one of the walls")
    (TEXT ,MESSAGE-027)
    (FLAGS READBIT)>

;"Object: BROKEN BEAM ---------------------------------------------------------"
<OBJECT 38-BROKEN-BEAM
	(IN LOCAL-GLOBALS)
	(SYNONYM BEAM)
    (ADJECTIVE BROKEN WOODEN)
	(DESC "wooden beam broken in two")
    (FLAGS TAKEBIT)>

;"Object: DEVICE --------------------------------------------------------------"
<OBJECT 39-DEVICE
	(IN 48-CAVE)
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
    <COND (<AND <VERB? PUSH> <HELD? ,39-DEVICE>>
        <COND (,19-DEVICE-FLAG
            <TELL ,MESSAGE-068 CR>
        )
        (T
            <SETG ,19-DEVICE-FLAG T>
            <MOVE-INVENTORY ,PLAYER ,10-LOST-AND-FOUND>         ;"Move all in inventory to Lost & Found"
            <GOTO ,08-LOBBY>
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

;"Object: THING-FISH ----------------------------------------------------------"
<OBJECT 40-THING-FISH
	(IN LOCAL-GLOBALS)
	(SYNONYM THING-FISH THINGFISH)
	(DESC "The Thing-Fish")
    (TEXT ,MESSAGE-030)
    (ACTION THING-FISH-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE THING-FISH-F ()
    <COND (<VERB? TELL>
        <TELL ,MESSAGE-090 CR>
        <SETG P-CONT -1>            ;"Flush input"
        <RTRUE>
    )>
>

;"Object: WORMHOLE ------------------------------------------------------------"
<OBJECT 41-WORMHOLE
	(IN LOCAL-GLOBALS)
	(SYNONYM WORMHOLE HOLE)
    (ADJECTIVE FREAK)
	(DESC "freak wormhole in the space-time fabric among the furs")
    (ACTION WORMHOLE-F)>

<ROUTINE WORMHOLE-F ()
    <COND (<VERB? WALK ENTER>
        <DO-WALK P?IN>
        <RTRUE>)
    >
>

;"Object: REPELLENT -----------------------------------------------------------"
<OBJECT 42-REPELLENT
	(IN LOCAL-GLOBALS)
	(SYNONYM REPELLENT)
    (ADJECTIVE GRUE)
	(DESC "Grue repellent (all over your body)")
    (ACTION REPELLENT-F)
    (FLAGS NARTICLEBIT)>

<ROUTINE REPELLENT-F ()
    <COND (<AND <VERB? DROP UNWEAR> <HELD? ,PRSO>>
        <TELL ,SYSMESSAGE-008 CR>
        <RTRUE>
    )>
>

;"-----------------------------------------------------------------------------
; ACTIONS
; -----------------------------------------------------------------------------"

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

<ROUTINE STANDARD-F ()
    <COND (<VERB? EXAMINE> 
        <V-EXAMINE>
        <RTRUE>)
    >
>

;"-----------------------------------------------------------------------------
; INTERRUPTIONS
; -----------------------------------------------------------------------------"
<ROUTINE I-EVERY-TURN ()
    <COND (<=? ,MOVES 1>
        <TELL CR ,MESSAGE-046 CR>
        <RTRUE>
    )>
    <COND (<=? ,MOVES 3>
        <TELL CR ,MESSAGE-089 CR>
        <RTRUE>
    )>

    ;"Thing-Fish action"
    <COND (<AND <G? ,MOVES 10> <L=? <RANDOM 100> 8> <NOT <=? <LOC ,PLAYER> ,51-XYZZY-ROOM  ,53-IN-BRICK-BUILDING>>>
        <TELL CR ,MESSAGE-084 CR <PICK-ONE-R ,THING-FISH-ACTION> CR>
        <RTRUE>
    )>

    ;"Goblin action"
    <COND (<L=? <RANDOM 100> 2>
        <TELL CR ,MESSAGE-097 CR>
        <RTRUE>
    )>
    
    ;"Poster action"
    <COND (<AND <L=? <RANDOM 100> 10> ,20-MIDGET-FLAG>
        <TELL CR ,MESSAGE-071 CR>
        <MOVE ,37-POSTER ,HERE>
        <SETG ,20-MIDGET-FLAG <>>
        <RTRUE>
    )>

    ;"Move large red button to device if device is carried"
    <COND (<HELD? ,39-DEVICE>
        <MOVE ,RED-BUTTON ,HERE>
    )
    (T
        <MOVE ,RED-BUTTON ,LOCAL-GLOBALS>
    )>
> 

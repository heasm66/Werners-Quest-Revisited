"Werner's Quest, Revisited - 4. Unchanter main file"

;"Release  1 20200117  : First attempt.
"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

<SETG EXTRA-FLAGS
    (
        EXTRABIT
        SCROLLBIT
        SPELLBIT
        LIQUIDBIT
    )>

"Main loop"

<CONSTANT GAME-BANNER
"||...from your place in the corner, you can see the entire collegial body of the Necromancers' High School, including Bulbouse,
the extremely fat headmaster, Hejsan Hopsan, the meditation teacher, and Boris Effle, the potion mixer, who has a quite unbecoming
wart on his nose. You have put the wart there using the worta spell, the only spell you've managed to copy into your spell book.
Bulbouse says: \"This mischievious pupil must be removed! Not only has he shown himself completely incompetent as a necromancer,
but he has also used the only spell he's managed to comprehend for an infantile lark!\" A tall, somewhat paranoid-looking wizard
clears his throat. It is Eskil the scrollmaker. He says: \"I think we should send him to Kvill's castle. He can't do any harm
there.\" Bulbous replies: \"Very well! We'll send him to Kvill's castle!\" He recites a spell and...|
|
|
Werner's Quest, Revisited - 4. Unchanter|
Original Quill game by Jan Åberg, 1985, 1986|
Source extracted from C64-version with Unquill v0.11 and converted to ZIL by Henrik Åsman, 2019|
Type 'ABOUT' for more details about this version.">

<ROUTINE GO () 
    <CRLF>
    <INIT-STATUS-LINE>
    <V-VERSION> <CRLF>
    <PUTP PLAYER ,P?CAPACITY 500>            ;"Default SIZE of objects is 5. This limits the inventory to 100 objects." 
    <SETG HERE ,01-FORK>
    <MOVE ,PLAYER ,HERE>
    <QUEUE I-EVERY-TURN -1>
    <V-LOOK>
    <MAIN-LOOP>>

;"Flags"

<GLOBAL 05-WELL1-COUNTER 0>                 ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 06-WELL2-COUNTER 0>                 ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 07-PAPERBAG-COUNTER 0>              ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 08-RAVINE-COUNTER 0>                ;"If set to value, this counter decreases every turn until it reaches 0"
<GLOBAL 22-ELEVATOR-FLAG T>

<GLOBAL 11-CURRENT-SPELL 0>
<GLOBAL 12-YEAST-FLAG <>>
<GLOBAL 13-BIN-FLAG <>>
<GLOBAL 14-FAN-FLAG <>>
<GLOBAL 15-DUNGEON-FLAG <>>
<GLOBAL 16-GRUE-COUNTER 0>
<GLOBAL 17-COMPANY-FLAG <>>
<GLOBAL 18-JEFF-MINTER-FLAG <>>
<GLOBAL 19-SOBER-FAN-FLAG <>>
<GLOBAL 20-KVILL-FLAG <>>
<GLOBAL 21-WORTA-ME-FLAG <>>

<GLOBAL HIT-COUNTER 0>

<GLOBAL SCORE-BRENWYN-FLAG <>>
<GLOBAL SCORE-BRRRODVEJ-FLAG <>>
<GLOBAL SCORE-REPHLEX-FLAG <>>
<GLOBAL SCORE-REVHOL-FLAG <>>
<GLOBAL SCORE-TUBORG-FLAG <>>
<GLOBAL SCORE-ENTER-CASTLE-FLAG <>>
<GLOBAL SCORE-ENTER-TOILET-FLAG <>>
<GLOBAL SCORE-GET-COIN-FLAG <>>
<GLOBAL SCORE-LARGE-HOLE-FLAG <>>
<GLOBAL SCORE-KVILL-FLAG <>>

;"Messages"

<CONSTANT MESSAGE-000 "You see nothing special.">
<CONSTANT MESSAGE-001 "Taken.">
<CONSTANT MESSAGE-002 "Dropped.">
<CONSTANT MESSAGE-003 "Picking up a 30 ft. deep well? What a stupendously stupid concept!">
<CONSTANT MESSAGE-004 "No! Disposing of the spell book could show most inconvenient in the future.">
<CONSTANT MESSAGE-005 "As you cast the xerox spell, your spell book begins to glow with a sickening green light. Suddenly, all the letters on the scroll take a leap over to your spell book. Some of them fall to the ground and scurry away, but most of them are now in your spell book. The scroll vanishes through the magic of stage-craft.">
<CONSTANT MESSAGE-006 "With much difficulty, you learn the spell, thereby forgetting any spell you possibly had memorized before.">
<CONSTANT MESSAGE-007 "Strange as it may seem, you know the xerox spell by heart.">
<CONSTANT MESSAGE-008 "You fill the bucket with petrol. The Thing-Fish passes by, riding a bicycle. He shouts: \"Owaah! Ain't dat wut I always has been sayim; ya gwine end up woikin at a gas statium!\"">
<CONSTANT MESSAGE-009 "You try to tap more petrol into the bucket, but as it is already full, the fuel pours over the rim of the container and drips to the the ground. The bike-riding Thing-Fish passes by once again, remarking: \"Owaah! Look deahhh! Not only be he employed at de afo'mentiumated gas statium, but he be also ignint in de perfo'mance uf simple gas statium soivices!\"">
<CONSTANT MESSAGE-010 "The petrol pours between your fingers and drips to the ground. The Thing-Fish passes by, riding a bicycle. He says: \"Boy! Ain't dat what I has always said; ya gwine end up woikin' at a gas statium! But ya appears to be severely ignint! Ya shuddn't let de fuel fall to de ground in dat mannuh! Fuel be expensive dese days!\"">
<CONSTANT MESSAGE-011 "Objects appear closer when you look at them through the pair of binoculars. You quietly contemplate the possibility of using them for examining remote objects.">
<CONSTANT MESSAGE-012 "Upon shaking the piggy bank, something rattles inside it.">
<CONSTANT MESSAGE-013 "It's The Werner Gazette. On the front page is a crudely drawn picture of you, accompanied by an article about the Werner Dungeon Enema Bandit (that's you).">
<CONSTANT MESSAGE-014 "  Enema Bandit Still On The Loose!|   --------------------------------||No reports has yet Arrived concerning|the evil Creature (see picture) who|enforced a Vicious enema unto mr.|Laurentius L. Ittle, a most Innocent and|noble member of the Midget kin two|adventures ago. Rumours, however, say|that the Criminal has left the Werner|Dungeon and has been observed in the|Vicinity of the noble Kvill's residence.|Mr. Ittle is now fully recovered, and|has re-assumed his post as Guardian Of|The Strange Purple Jell-O.">
<CONSTANT MESSAGE-015 "It's a confusing jumble of copper tubes, one of which is stopped up with what appears to be a yeast-smelling scroll.">
<CONSTANT MESSAGE-016 "It's a confusing jumble of copper tubes, one of which is stopped up with what appears to be a newspaper.">
<CONSTANT MESSAGE-017 "In the rubbish bin, among the useless junk, you find a newspaper.">
<CONSTANT MESSAGE-018 "The brenwyn spell: remove alcoholic intoxication.">
<CONSTANT MESSAGE-019 "The towel is pink with light green flowers and not particularly clean.">
<CONSTANT MESSAGE-020 "The brrrodvej spell: animate stagecraft.">
<CONSTANT MESSAGE-021 "The rock fan appears rather unsteady, he speaks slurredly and every once in a while he sings a strange and monotonous song. His behaviour is generally insane; it's quite apparent that he's from Ludvika.">
<CONSTANT MESSAGE-022 "The rock fan seems quite intoxicated and jumps up and down to the so called music.">
<CONSTANT MESSAGE-023 "He appears confused and insane. It's obvious that he's from Ludvika.">
<CONSTANT MESSAGE-024 "Unlike the other robots he's still and quiet. In his abdomen is an enclosure.">
<CONSTANT MESSAGE-025 "The revhol spell: turn an amphipian intoa fairie prince.">
<CONSTANT MESSAGE-026 "The hole is large enough for you to enter. Through it you can see Kvill's chamber, in which is seated Kvill.">
<CONSTANT MESSAGE-027 "It's a large colour photo of Jeff Minter and his favourite llama.">
<CONSTANT MESSAGE-028 "As the immoderately wise person you are, you recognize the rodent as The Unmeasurably Rare And Dangerous Bloodsucking Killer Rabbit (Contrubida Caxidor) (The note on the cage may have been of some help for the identification).">
<CONSTANT MESSAGE-029 "Upon the box is written: \"Theobaldian 30 ft. deep well\".">
<CONSTANT MESSAGE-030 "The well appears to be 30 ft. deep.">
<CONSTANT MESSAGE-031 "Honest John is seated in his Eldorado Cadillac. His gold-filled smile lights up the countryside considerably... In the light of his golden teeth you notice things previously unnoticed, like flowers, eminent castles, nymphs taking baths in little brooks, and also the Thing-Fish, holding a sign upon which it is written: \"Boy! Whatcha starrim at? Resume yo' 'venchurim 'mideately!\"|Honest John closes his mouth and you canno longer discern the aforementioned things.">
<CONSTANT MESSAGE-032 "As nothing has been written on it, the scroll is blank.">
<CONSTANT MESSAGE-033 "The pencil is severely worn. You won't be able to write especially many words with it.">
<CONSTANT MESSAGE-034 "The tuborg spell: summon a rock fan from a rock club in Copenhagen.">
<CONSTANT MESSAGE-035 "The rephlex spell: create a self-destroying mirror.">
<CONSTANT MESSAGE-036 "The fettered persons are all from different adventure games; there's Thorin, the Wizard of Frobozz, Watson, Ford Prefect, one evil little dwarf and many others.">
<CONSTANT MESSAGE-037 "The former stage-craft appears quite confused; they wander about the room occupied with mundane occupations: singing about gold, remarking:\"Fantastic Holmes, I don't understand how you do it!\", saying various words beginning with an \"F\", and the like.">
<CONSTANT MESSAGE-038 "The stage-craft now appear quite agitated, gesticulating wildly and jeering at the person (you) who has showed them such a hideous picture.">
<CONSTANT MESSAGE-039 "The former stage-craft have all collapsed into a heap, seemingly unconscious.">
<CONSTANT MESSAGE-040 "Suddenly, one of the walls turn and the Thing-Fish enters, followed by a typical heavy metal band. He's wearing a long, greasy, black wig over his potato-head, and he's dressed in black clothes with lots of rivets. He intones a low, grunting black-sabbath-type chant: \"Flies all green an' buzznim in dis dum-yin uf despair Who are all o' de poisons fettuhd ovuh deahhh?\" He points at the fettered adventure game individuals.|\"Are dey crazey?| Have dey fainted?| Are dey stage-kraff| someone painted?| Why, it's nevuh been explained| since at foist it were created| 'cos a 'ventchuh game like we's in| be requirim a whole buncha evuhthing| Ah'm talkim evuhthing| dat evuh been">
<CONSTANT MESSAGE-041 " Looks at her!\"|He points at one of the persons, whom you recognize as Kim Kimberly. The heavy metal band breaks out into an unbearably loud instrumental break.|\"Looks at him!\"|He points at the troll from Zork I.|\"Dat's what de game we starrim in| Dat's what de game we starrim in| Dat's what de game we starrim in...\"|The Thing-Fish and his band leaves through turning walls.">
<CONSTANT MESSAGE-042 "You put down your possessions and open a small cafe', where you sell coffee and Danish pastries. The business run well and you make a small fortune. Then, one day, the Thing-Fish and Rance The Dungeonkeeper visit your cafe'. They sit down and order coffee and some Danish pastries. Rance The Dungeonkeeper tells the Thing-Fish an untranslatable German pun. The Thing-Fish breaks into uncontrollable laughter, waving his arms extensively, thereby breaking most of the interior of your small cafe'. The sad remains of your establishment fall down a hole and disappear. You conclude you work as a landlord and resume your adventuring.">
<CONSTANT MESSAGE-043 "You read the mouldy book. It wasn't a good book.">
<CONSTANT MESSAGE-044 "Your spell book contains your spells. On the first page, Bulbouse has scribbled: \"Note: The owner of this spell book is so severely untalented that he can only remember 1 (one) spell at a time.\"">
<CONSTANT MESSAGE-045 "You can see The Necromancers' High School perched on the mountainside, but it's too far away to make out any details.">
<CONSTANT MESSAGE-046 "Gazing through the binoculars, you can see The Necromancers' High School perched on the mountainside. On its terrace you can see Bulbouse, seated in a hammock with a fat cigar in his fat hand. He waves at you, the valuable rings on his fingers glittering in the setting sun (which, by the magic of stage-craft, always is setting). You hate him.">
<CONSTANT MESSAGE-047 "As you pass through the gate, a somewhat familiar midget enters. He closes and locks the gate, whereupon he swallows the key and shouts: \"Hah! There ain't no enema in this adventure!\" He runs off, humming the overture to Wilhelm Tell.">
<CONSTANT MESSAGE-048 "Lay off, there are a large number of scrolls in this game. (What I mean is: Please be more specific.)">
<CONSTANT MESSAGE-049 "You take the yeast-smelling scroll away from the still. Some strongly-smelling drops leak out of the pipe. Farmer Maggot shouts: \"Aw, loaw drecka haw eeh sondah!\" and produces a large rifle with which he perforates your body.">
<CONSTANT MESSAGE-050 "You take the newspaper from the still. Some strongly-smelling drops leak from the pipe. Farmer Maggot shouts: \"Aye! Deowah achchelmyn!\", whereupon he shoots you with a previously unnoticed rifle.">
<CONSTANT MESSAGE-051 "In the rubbish bin you find a vast quantity of useless junk, which you don't concern yourself with.">
<CONSTANT MESSAGE-052 "Opening the cupboard reveals a small, feeble-looking grue which is wearing a pair of sunglasses. It speaks in a feeble voice: \"Oh! An adven... No! You're not an adventurer! You look more like a low-budget necromancer, and a pretty viscous one at that! But here's a deal: if you go get me an adventurer, or the like, anyone who looks more edible than you will do, and I'll give you object no. 11! OK?\" Before you get a chance to reply, the grue closes the cupboard.">
<CONSTANT MESSAGE-053 "The grue sticks out its head and surveys the kitchen. It sees nothing special. \"What?\", it says, \"No foodstuff?\", smashing the cupboard shut.">
<CONSTANT MESSAGE-054 "The grue sticks out its head and surveys the kitchen. It sees the rock fan. \"Oh great!\", it says, dragging the rock fan into the cupboard. It closes the cupboard, from which now can be heard the sound of rock fan consumption.">
<CONSTANT MESSAGE-055 "Opening the cupboard reveals a full grue, which is wearing sunglasses. \"Oh!\", it says, \"I completely forgot! Object No. 11! Here you are.\" He hands you a cerise scroll and closes the cupboard.">
<CONSTANT MESSAGE-056 "The grue says: \"What! You again? Scram!\" It closes the cupboard.">
<CONSTANT MESSAGE-057 "With a swift upward jerk you remove the scroll from the still and replace it with the newspaper. Farmer Maggot inspects the new packing material and, finding it satisfactory, has no objection.">
<CONSTANT MESSAGE-058 "With a swift upward jerk, you remove the newspaper from the still. Before you have time to replace it, the farmer, obviously tired of your fiddling with his dearest possession, takes out a rifle with which he shoots you.">
<CONSTANT MESSAGE-059 "Suddenly, the stage-craft comes to life. They break their stage-craft fetters and start pacing aimlessly around the dungeon, concerned with mundane occupations.">
<CONSTANT MESSAGE-060 "Seeing a photo of the person representing everything they don't value seems to have got the stage-craft upset; they starr angrily at the photo and mutter a wide array of oaths, some of which you never knew existed.">
<CONSTANT MESSAGE-061 "Upon entering the room, the stage-craft notice all the Jeff Minter stuff and begin to batter it furiously. The troll from the Werner trilogy enters, shouting: \"YOU MAY NOT DAMAGE THE INVENTORY!\", but as nobody pays any attention to him, he leaves in despair.">
<CONSTANT MESSAGE-062 "Dropped.||The stage-craft throw themselves over the photo and tear it to pieces. Then they leave, satisfied with what they've accomplished.">
<CONSTANT MESSAGE-063 "Dropped.||The stage-craft throw themselves after the photo in an attempt to tear it to pieces. Being too eager, however, some of them stumble and plunge, head first, into the brick wall, thus windening the hole, and collapse in a heap. The stage-craft that got hold of the photo leave< in Triumph (a red, previously unnoticed, Triumph '59).">
<CONSTANT MESSAGE-064 "The stage-craft follow you, out of their mind with irritation.">
<CONSTANT MESSAGE-065 "Suddenly, the rock fan appears in the room! He looks around, quite confused, and murmurs something incomprehensible.">
<CONSTANT MESSAGE-066 "The rock fan appears more steady now. He eyes you with curiousity.">
<CONSTANT MESSAGE-067 "The rock fan follows you.">
<CONSTANT MESSAGE-068 "The TV set is showing a concert from a rock club in Copenhagen. What appears to be a rock fan is jumping up and down to the so called music.">
<CONSTANT MESSAGE-069 "The TV set is showing a concert from a rock club in Copenhagen.">
<CONSTANT MESSAGE-070 "Through the hole you can see Kvill's chamber, in which Kvill is seated.">
<CONSTANT MESSAGE-071 "As you pull the lever, the cage opens and the rabbit leaps out. In one gigantic leap it jumps onto your throat and buries its teeth into it.">
<CONSTANT MESSAGE-072 "As you pull the lever, the cage opens and the rabbit leaps out, accidentally falling into the well.">
<CONSTANT MESSAGE-073 "Nothing happens.">
<CONSTANT MESSAGE-074 "In the box there is a 30 ft. deep well, which falls to the ground. The box disappears through the magic of stage-craft.">
<CONSTANT MESSAGE-075 "You scribble a few words on the blank scroll. The now worn-out pencil disappears through the magic of stage-craft. You take a look at the scroll. Oh dear! You seem to have scribbled yourself a spell!">
<CONSTANT MESSAGE-076 "You have no suitable material to write on.">
<CONSTANT MESSAGE-077 "You rub the mirror and find yourself moved to another place...">
<CONSTANT MESSAGE-078 "As you insert the motor into Floyd the droid, he springs into action. The partly apart-taken robots say unanimously: \"So that's what doing your thing is! The thing is to put a motor in yourself!\" Floyd reaches into himself, takes out a pink scroll and gives it to you. He then rushes off into the depths of the castle (Note the total lack of jokes about Pink and Floyd).">
<CONSTANT MESSAGE-079 "As you pour the petrol into the hole, the machine comes to life, the hammer hitting the floor furiously!">
<CONSTANT MESSAGE-080 "The hammer hits the piggy bank, which breaks into thousands of pieces (very fragile chrome that was), which disappear through the magic of stage-craft. Left lying on the floor is a coin.">
<CONSTANT MESSAGE-081 "You put on the dress. This makes you feel silly.">
<CONSTANT MESSAGE-082 "You put on the wig. This makes you feel silly.">
<CONSTANT MESSAGE-083 "You remove the wig. This makes you feel somewhat less silly.">
<CONSTANT MESSAGE-084 "You remove the dress. This makes you feel somewhat less silly.">
<CONSTANT MESSAGE-085 "As you cast the spell, the toad turns into a fairie prince. The fairie prince is wearing rubber trousers up to his armpits and a chic little leather cap. He's also carrying a small handbag.">
<CONSTANT MESSAGE-086 "Upon seeing you, the fairie prince remarks, in a high-pitched voice: \"Hello, sailor!\", whereupon he preceeds to drag you into the swamp, where you experience several unpleasant things and finally die, having contracted a nasty disease.">
<CONSTANT MESSAGE-087 "He gives you a casual glance and says, in a high-pitched voice: \"Hi! Nice hairdo! Oh, by the way, thanks for breaking the spell. Here, take this!\" He reaches into his handbag and takes out a cologne-soaked scroll, which he gives to you before skipping off through the forest.">
<CONSTANT MESSAGE-088 "As you cast the spell, a mirror appears, suspended in mid-air. It hovers there just long enough to let you examine your features. Then it disappears.">
<CONSTANT MESSAGE-089 "As you cast the spell, a mirror appears, suspended in mid-air. Kvill gazes into the mirror for a while, admiring himself, until, suddenly, it disappears.">
<CONSTANT MESSAGE-090 "As you cast the spell, a mirror appears, suspended in mid-air. As Kvill gazes into the mirror and notices the wart on his nose, his face freezes with terror. He shouts: \"Oh no! A wart! Oh, what a burden!\" Then he faints. Suddenly, Bulbouse appears in the room. He shouts: \"Look what you've done! You've put an ugly wart on the face of Kvill! You're a complete menace! OK! I'll give you a villa by the Fish-head ocean! With a swimming-pool! Just don't mess things up any more, OK? I'd say this adventure is completed now!\"">
<CONSTANT MESSAGE-091 "Kvill is wearing a black tuxedo, and his hair is impeccably combed.">
<CONSTANT MESSAGE-092 "Kvill is wearing a black tuxedo, and his hair is impeccably combed. He has an ugly wart on his nose.">
<CONSTANT MESSAGE-093 "As you cast the spell, an ugly wart appears on Kvill's nose, but he doesn't seem to notice it.">
<CONSTANT MESSAGE-094 "Nothing happens, perhaps because he's already got a wart on his nose.">
<CONSTANT MESSAGE-095 "You buy a well from Honest John.">
<CONSTANT MESSAGE-096 "You have no money.">
<CONSTANT MESSAGE-097 "The fat, slobby, bearded club owner approaches you, carrying a large axe which he waves in your direction and says: \"You're not a member of the club, aye? Please leave, if you would be so very kind?\" You do so...">
<CONSTANT MESSAGE-098 "A person appears at the top of the well. He gazes down into the well, notices you and says: \"Oh dear! Have you fallen into a 30 ft. deep well?\" Then he wanders off.">
<CONSTANT MESSAGE-099 "Boldly springing into action, the rodent takes one gigantic leap, going for your throat, which it slits open.">
<CONSTANT MESSAGE-100 "You wrap the towel around your head. The Ravenous Bugblatter Beast of Traal is completely bewildered; it's so dim, it thinks that if you can't see it, it can't see you, but since there is no such beast here nothing of this really happens and this is irrelevant and this very message is nothing but a broad hint for another game that shall go nameless but it's based on the book of the same name by Douglas Adams and I could go on with this message forever but I won't because there's not much memory left.">
<CONSTANT MESSAGE-101 "You remove the towel. The Ravenous Bugblatter etc. etc. etc.">
<CONSTANT MESSAGE-102 "You don't have that spell committed to memory.">
<CONSTANT MESSAGE-103 "Nothing happens. Perhaps it was sober already.">
<CONSTANT MESSAGE-104 "Nothing happens. Perhaps it wasn't stage-craft.">
<CONSTANT MESSAGE-105 "Nothing happens. Perhaps it wasn't an amphibian.">
<CONSTANT MESSAGE-106 "Nothing happens. Perhaps it wasn't a rock fan.">
<CONSTANT MESSAGE-107 "The toad looks at you and says: \"Now, look here! I told you in part III that it wouldn't work, didn't I?\"">
<CONSTANT MESSAGE-108 "Honest Joh says: \"Hi there! Do you wanna buy a well? First class, life-time guarantee!\"">
<CONSTANT MESSAGE-109 "You now have an ugly wart on your nose.">
<CONSTANT MESSAGE-110 "Nothing happens, possibly because you already have a wart on your nose.">
<CONSTANT MESSAGE-111 "Honest John shouts: \"Hey you! Look what you've done with my charisma! Just you wait! I'll join forces with the Thing-Fish and come up with a gruesome revenge!\" He puts the metal to the pedal and disappears in a cloud of dust.">
<CONSTANT MESSAGE-112 "A wart appears on the nose on one of the stage-craft persons, but he doesn't seem to notice.">
<CONSTANT MESSAGE-113 "A wart appears on the nose of the rock fan, but he's to intoxicated to notice it.">
<CONSTANT MESSAGE-114 "A wart appears on the nose of the rock fan, but he doesn't care (he's from Ludvika, you know).">
<CONSTANT MESSAGE-115 "He's far too busy thinking about his ego to notice you.">
<CONSTANT MESSAGE-116 "The rock fan says: \"Hi!\"">
<CONSTANT MESSAGE-117 "The stage-craft nod at you.">
<CONSTANT MESSAGE-118 "Out of fear for a certain troll, you decide not to do it.">

<CONSTANT SYSMESSAGE-000 "It's too dark to see.">
<CONSTANT SYSMESSAGE-001 "You can see:">
<CONSTANT SYSMESSAGE-002 "What next? ">
<CONSTANT SYSMESSAGE-003 "What next? ">
<CONSTANT SYSMESSAGE-004 "What next? ">
<CONSTANT SYSMESSAGE-005 "What next? ">
<CONSTANT SYSMESSAGE-006 "What on earth do you mean by that?">
<CONSTANT SYSMESSAGE-007 "That is a direction in which I'm quite unable to move.">
<CONSTANT SYSMESSAGE-008 "That's impossible.">
<CONSTANT SYSMESSAGE-009 "Your belongings are:">
<CONSTANT SYSMESSAGE-010 "(worn)">
<CONSTANT SYSMESSAGE-011 "Nil.">
<CONSTANT SYSMESSAGE-012 "Quit? Are you really sure that would be the best thing to do in a situation like this?">
<CONSTANT SYSMESSAGE-013 "               The End.||Do you want to have another go?">
<CONSTANT SYSMESSAGE-014 "Just what I thought.">
<CONSTANT SYSMESSAGE-015 "OK.">
<CONSTANT SYSMESSAGE-016 "More...">
<CONSTANT SYSMESSAGE-017 "You have taken ">
<CONSTANT SYSMESSAGE-018 " turn">
<CONSTANT SYSMESSAGE-019 "s">
<CONSTANT SYSMESSAGE-020 ".">
<CONSTANT SYSMESSAGE-021 "You have scored">
<CONSTANT SYSMESSAGE-022 "%25">
<CONSTANT SYSMESSAGE-023 "That item isn't worn by you.">
<CONSTANT SYSMESSAGE-024 "You're carrying far too many objects to do that.">
<CONSTANT SYSMESSAGE-025 "That thing is already being carried by you.">
<CONSTANT SYSMESSAGE-026 "You can't see that item here.">
<CONSTANT SYSMESSAGE-027 "Your load is too heavy.">
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

;"Room: FORK ------------------------------------------------------------------"
<ROOM 01-FORK
    (DESC "Fork")
    (IN ROOMS)
    (LDESC 
"You are standing at a fork in the path coming from the west. The paths lead north, south and west.")
    (NORTH TO 14-NORTHERN-PATH)
    (SOUTH TO 05-SOUTHERN-PATH)
    (WEST TO 02-KLIEN-MOEBIUS-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: KLIEN-MOEBIUS PATH ----------------------------------------------------"
<ROOM 02-KLIEN-MOEBIUS-PATH
    (DESC "Klien-Moebius-Path")
    (IN ROOMS)
    (LDESC 
"You are standing on a Klein-Moebius-inspired east-west path. To the west, it turns upwards and bends through itself in a
strange loop. To the east, however, the path appears normal.")
    (WEST TO 02-KLIEN-MOEBIUS-PATH)
    (EAST TO 01-FORK)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: INSIDE CARBOARD HUT ---------------------------------------------------"
<ROOM 03-INSIDE-CARBOARD-HUT
    (DESC "Inside Cardboard Hut")
    (IN ROOMS)
    (LDESC 
"You are standing inside the cardboard hut, which smells strongly of potatoes. The exit lies to the south.")
    (SOUTH TO 04-FRANCESCOS-FRONT-LAWN)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: FRANCESCO'S FRONT LAWN ------------------------------------------------"
<ROOM 04-FRANCESCOS-FRONT-LAWN
    (DESC "Francesco's Front Lawn")
    (IN ROOMS)
    (LDESC 
"You are standing on Francesco's front lawn. To the north stands a cardboard hut and to the east is an opening
in the vegetation.")
    (NORTH TO 03-INSIDE-CARBOARD-HUT)
    (EAST TO 05-SOUTHERN-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: SOUTHERN PATH ---------------------------------------------------------"
<ROOM 05-SOUTHERN-PATH
    (DESC "Southern Path")
    (IN ROOMS)
    (LDESC 
"You are on the southern path, which at this point stretches from north to south. To the west, there appears to be an opening
in the surrounding, otherwise impenetrable vegetation.")
    (NORTH TO 01-FORK)
    (SOUTH TO 06-TURNING-PATH)
    (WEST TO 04-FRANCESCOS-FRONT-LAWN)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: TURNING PATH ----------------------------------------------------------"
<ROOM 06-TURNING-PATH
    (DESC "Path")
    (IN ROOMS)
    (LDESC 
"The path turns here, enabling you to go north or east.")
    (NORTH TO 05-SOUTHERN-PATH)
    (EAST TO 07-FOREST-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: FOREST PATH -----------------------------------------------------------"
<ROOM 07-FOREST-PATH
    (DESC "Forest Path")
    (IN ROOMS)
    (LDESC 
"You are on an east-west forest path. A smaller path winds through the forest to the south.")
    (SOUTH TO 08-PLAYGROUND)
    (WEST TO 06-TURNING-PATH)
    (EAST TO 09-TURNING-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: PLAYGROUND ------------------------------------------------------------"
<ROOM 08-PLAYGROUND
    (DESC "Kvill's playground")
    (IN ROOMS)
    (LDESC 
"You are on Kvill's playground, which is equipped with torture racks, whipping posts, tongs and other means of torture.
This is the place where Kvill used to take his school mates and torture them to death (Kvill was never very popular
in school (or anywhere else)). All around is impenetrable forest, except to the north, where a tiny path leads away
between the trees.")
    (NORTH TO 07-FOREST-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (WHIPPING) (RSTACK RACKS POST POSTS TONG TONGS) STANDARD-F)>

;"Room: TURNING PATH ----------------------------------------------------------"
<ROOM 09-TURNING-PATH
    (DESC "Path")
    (IN ROOMS)
    (LDESC 
"The path turns. It's now leading north and west.")
    (NORTH TO 10-CASTLE-GATE)
    (WEST TO 07-FOREST-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: CASTLE GATE -----------------------------------------------------------"
<ROOM 10-CASTLE-GATE
    (DESC "Before Castle Gate")
    (IN ROOMS)
    (LDESC 
"You are standing before the gate of an imposing castle. Beside the gate is a sign reading: \"Kvill's Castle\". The path
leads north and south, and all around is dense, if not impenetrable, forest.")
    (NORTH TO 11-TURNING-PATH)
    (SOUTH TO 09-TURNING-PATH)
    (EAST PER CASTLE-GATE-EXIT)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (IMPOSING) (CASTLE) STANDARD-F
            (<>) (GATE SIGN) STANDARD-F)>

<ROUTINE CASTLE-GATE-EXIT ()
    <TELL ,MESSAGE-047 CR CR>
    <COND (<NOT ,SCORE-ENTER-CASTLE-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ENTER-CASTLE-FLAG T>)>
    <RETURN ,17-ENTRANCE-HALL>    
>

;"Room: TURNING PATH ----------------------------------------------------------"
<ROOM 11-TURNING-PATH
    (DESC "Path")
    (IN ROOMS)
    (LDESC 
"The path turns here, leading south and west.")
    (SOUTH TO 10-CASTLE-GATE)
    (WEST TO 12-FOREST-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: FOREST PATH -----------------------------------------------------------"
<ROOM 12-FOREST-PATH
    (DESC "Forest Path")
    (IN ROOMS)
    (LDESC 
"You are on an east-west forest path.")
    (EAST TO 11-TURNING-PATH)
    (WEST TO 15-OUTSIDE-FARMHOUSE)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: PICNIC SPOT -----------------------------------------------------------"
<ROOM 13-PICNIC-SPOT
    (DESC "Picnic Spot")
    (IN ROOMS)
    (LDESC 
"You are in a picnic spot in the forest. Benches and tables carved out of tree trunks are standing here, along with a
rubbish bin, carved out of a petrified troll. To the west lies the northern path.")
    (WEST TO 14-NORTHERN-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BENCH BENCHES TABLE TABLES TREE-INDENT TRUNK) STANDARD-F
            (RUBBISH) (BIN) BIN-F)>

<ROUTINE BIN-F ()
    <COND (<VERB? EXAMINE>
        <COND (,13-BIN-FLAG
            <TELL ,MESSAGE-051 CR>
        )
        (T
            <TELL ,MESSAGE-017 CR>
            <MOVE ,04-NEWSPAPER ,HERE>
            <SETG ,13-BIN-FLAG T>
            <THIS-IS-IT ,04-NEWSPAPER>
        )>
        <RTRUE>
     )>
>

;"Room: NORTHERN PATH ---------------------------------------------------------"
<ROOM 14-NORTHERN-PATH
    (DESC "Northern Path")
    (IN ROOMS)
    (LDESC 
"You are on the northern path, which stretched from north to south. To the east lies a picnic spot.")
    (NORTH TO 15-OUTSIDE-FARMHOUSE)
    (SOUTH TO 01-FORK)
    (EAST TO 13-PICNIC-SPOT)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>
      
;"Room: OUTSIDE FARMHOUSE -----------------------------------------------------"
<ROOM 15-OUTSIDE-FARMHOUSE
    (DESC "Path Outside Farmhouse")
    (IN ROOMS)
    (LDESC 
"The path turns from south to east here. To the north lies Farmer Maggot's farmhouse.")
    (NORTH TO 16-INSIDE-FARMHOUSE)
    (SOUTH TO 14-NORTHERN-PATH)
    (EAST TO 12-FOREST-PATH)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (FARMER MAGGOT\'S) (FARMHOUSE) STANDARD-F)>

;"Room: INSIDE FARMHOUSE ------------------------------------------------------"
<ROOM 16-INSIDE-FARMHOUSE
    (DESC "Inside Farmhouse")
    (IN ROOMS)
    (LDESC 
"You are in the farm house of Farmer Maggot. Well, farmhouse is in fact far too nice a noun to use to describe this
stinking one-room hovel. However, one object here differs considerably from the general misery; in the middle of the
room stands a shining distillation kit. The exit lies to the south. Farmer Maggot is here, eyeing you suspiciously
and murmuring various profundities in an incomprehensible dialect.")
    (SOUTH TO 15-OUTSIDE-FARMHOUSE)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (FARMER) (MAGGOT) STANDARD-F)>

;"Room: ENTRANCE HALL ---------------------------------------------------------"
<ROOM 17-ENTRANCE-HALL
    (DESC "Entrance Hall")
    (IN ROOMS)
    (LDESC 
"You are in the entrance hall of Kvill's castle. To the west lies the gate, which is inexorably shut. Corridors lead north
and south, and to the east lies the courtyard.")
    (NORTH TO 18-NORTHERN-CORRIDOR)
    (SOUTH TO 41-NS-CORRIDOR)
    (EAST TO 44-COURTYARD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (GATE) STANDARD-F)>
     
;"Room: NORTHERN CORRIDOR -----------------------------------------------------"
<ROOM 18-NORTHERN-CORRIDOR
    (DESC "Northern Corridor")
    (IN ROOMS)
    (LDESC 
"You are walking along the northern corridor.")
    (NORTH TO 19-NW-TOWER-BASE)
    (SOUTH TO 17-ENTRANCE-HALL)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: NW TOWER BASE ---------------------------------------------------------"
<ROOM 19-NW-TOWER-BASE
    (DESC "Base of Northwest Tower")
    (IN ROOMS)
    (LDESC 
"You are standing at the base of the northwest tower. A spiral staircase leads up and corridors lead off to the south and east.")
    (SOUTH TO 18-NORTHERN-CORRIDOR)
    (EAST TO 21-LIBRARY)
    (UP TO 20-BARE-TOWER-ROOM)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SPIRAL) (STAIRCASE) STANDARD-F)>

;"Room: BARE TOWER ROOM -------------------------------------------------------"
<ROOM 20-BARE-TOWER-ROOM
    (DESC "Bare Tower Room")
    (IN ROOMS)
    (LDESC 
"You are in a bare tower room. Through the window, far away to the northwest, you can see the Fishhead mountains and, 
among those, the Necromancers' High School. A spiral staircase leads down.")
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SPIRAL) (STAIRCASE) STANDARD-F
            (<>) (WINDOW) STANDARD-F
            (FISHHEAD) (MOUNTAIN MOUNTAINS) STANDARD-F
            (NECROMANCERS\' HIGH) (SCHOOL) HIGH-SCHOOL-F)>

<ROUTINE HIGH-SCHOOL-F ()
    <COND (<VERB? EXAMINE>
        <COND (<HELD? ,01-BINOCULARS>
            <TELL ,MESSAGE-046 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-045 CR>
            <RTRUE>
        )>
    )>
>

;"Room: LIBRARY ---------------------------------------------------------------"
<ROOM 21-LIBRARY
    (DESC "Library") 
    (IN ROOMS)
    (LDESC 
"You are in a small library. It's so small that a smaller library would be difficult to imagine. The only bookcase here is
designed to hold 1 (one) book. Doorways lead east and west.")
    (EAST TO 22-EW-CORRIDOR)
    (WEST TO 19-NW-TOWER-BASE)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BOOKCASE) STANDARD-F)>

;"Room: EW CORRIDOR -----------------------------------------------------------"
<ROOM 22-EW-CORRIDOR
    (DESC "East-West Corridor")
    (IN ROOMS)
    (LDESC 
"You are in an east-west corridor. To the south is a doorway leading out to the courtyard, and above the staircase
leading down hangs a sign reading: \"The Dungeon of Despair\".")
    (SOUTH TO 43-NE-COURTYARD)
    (EAST TO 25-EW-CORRIDOR)
    (WEST TO 21-LIBRARY)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAIRCASE SIGN) STANDARD-F)>

;"Room: DUNGEON OF DESPAIR ----------------------------------------------------"
<ROOM 23-DUNGEON-OF-DESPAIR
    (DESC "Dungeon of Despair")
    (IN ROOMS)
    (LDESC 
"You are in The Dungeon of Despair. A sinister midget with a bucket and a mop is cleaning the floor here. On the walls
are hanging a large number of fetters. A flight of stairs leads up and a small doorway leads west.")
    (WEST TO 24-SUB-DUNGEON)
    (UP TO 22-EW-CORRIDOR)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (ACTION DUNGEON-OF-DESPAIR-F)
    (THINGS (<>) (MIDGET BUCKET MOP FLOOR STAIRS STAIR) STANDARD-F)>

<ROUTINE DUNGEON-OF-DESPAIR-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <NOT ,15-DUNGEON-FLAG>>
        <TELL CR ,MESSAGE-040 CR ,MESSAGE-041 CR>
        <SETG ,15-DUNGEON-FLAG T>
        <RTRUE>
    )>

>

;"Room: SUB DUNGEON -----------------------------------------------------------"
<ROOM 24-SUB-DUNGEON
    (DESC "Sub-Dungeon")
    (IN ROOMS)
    (LDESC 
"You are in a sub-dungeon. There are cells on both sides. In those are imprisoned cheaters, liars, robbers, thieves, tricksters,
traitors, swindlers, decievers, arsonists and other criminals. In the ceiling of each cell is set a diamond-shaped window.
A small doorway leads east.")
    (EAST TO 23-DUNGEON-OF-DESPAIR)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (CHEATERS LIARS ROBBERS THIEVES TRICKSTERS TRAITORS SWINDLERS DECIEVERS ASONISTS CRIMINALS CELL WINDOW DOORWAY) STANDARD-F)>

;"Room: EW CORRIDOR -----------------------------------------------------------"
<ROOM 25-EW-CORRIDOR
    (DESC "East-West Corridor")
    (IN ROOMS)
    (LDESC 
"You are in an east-west corridor. Another corridor lead south.")
    (SOUTH TO 28-SMALL-ROOM)
    (EAST TO 26-NE-TOWER-BASE)
    (WEST TO 22-EW-CORRIDOR)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>

;"Room: NE TOWER BASE ---------------------------------------------------------"
<ROOM 26-NE-TOWER-BASE
    (DESC "Base of Northeast Tower")
    (IN ROOMS)
    (LDESC 
"You are at the base of the northeast tower. Corridors lead south and west, and a spiral staircase leads up.")
    (SOUTH TO 30-MIRROR-ROOM)
    (WEST TO 25-EW-CORRIDOR)
    (UP PER NE-TOWER-BASE-EXIT)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SPIRAL) (STAIRCASE) STANDARD-F)>

<ROUTINE NE-TOWER-BASE-EXIT ()
    <COND (,18-JEFF-MINTER-FLAG <RETURN ,61-MINTER-ROOM>)>
    <RETURN ,27-JEFF-MINTERS-ROOM>
>

;"Room: JEFF MINTERS ROOM -----------------------------------------------------"
<ROOM 27-JEFF-MINTERS-ROOM
    (DESC "Jeff Minter Room")
    (IN ROOMS)
    (LDESC 
"You are in the Jeff Minter Room. The entire room is a contribution to Jeff Minter; computers along the walls run various
Llamasoft games and the walls are covered with posters depicting the covers of his games. A spiral staircase leads down.")
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (ACTION JEFF-MINTERS-ROOM-F)
    (THINGS (<>) (COMPUTER COMPUTERS GAME GAMES WALL WALLS POSTER POSTERS STAIRCASE) STANDARD-F)>

<ROUTINE JEFF-MINTERS-ROOM-F (RARG)
    <COND (<AND <=? .RARG ,M-END> ,17-COMPANY-FLAG>
        <TELL ,MESSAGE-061 CR CR>
        <SETG ,18-JEFF-MINTER-FLAG T>
        <GOTO ,61-MINTER-ROOM>
        <MOVE ,35-COMPANY ,HERE>
        <RTRUE>
    )>
>

;"Room: SMALL ROOM ------------------------------------------------------------"
<ROOM 28-SMALL-ROOM
    (DESC "Small Room")
    (IN ROOMS)
    (LDESC 
"You are in a small room with a lever protruding from the western wall. To the east is a large cage and a corridor leads north.")
    (NORTH TO 25-EW-CORRIDOR)
    (EAST PER SMALL-ROOM-EXIT)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (LEVER) LEVER-F
            (<>) (CAGE) CAGE-F)>

<ROUTINE SMALL-ROOM-EXIT ()
    <COND (<NOT <=? <LOC ,22-RABBIT> ,HERE>> <RETURN ,29-CAGE>)>
    <TELL ,SYSMESSAGE-007 CR>
    <RFALSE>
>

<ROUTINE CAGE-F ()
    <COND (<AND <VERB? EXAMINE> <=? <LOC ,22-RABBIT> ,HERE>>
        <TELL ,MESSAGE-028 CR>
        <RTRUE>
    )>
>

<ROUTINE LEVER-F ()
    <COND (<AND <VERB? PULL>
        <COND   (<AND <=? <LOC ,22-RABBIT> ,HERE> <=? <LOC ,25-WELL> ,HERE>>
                    <TELL ,MESSAGE-072 CR>
                    <MOVE ,22-RABBIT ,LOCAL-GLOBALS>
                    <MOVE ,23-KILLER-RABBIT ,40-WELL-BOTTOM>
                    <RTRUE>)
                (<AND <=? <LOC ,22-RABBIT> ,HERE> <NOT <=? <LOC ,25-WELL> ,HERE>>>
                    <JIGS-UP ,MESSAGE-071>
                    <RTRUE>)
                (<AND <NOT <=? <LOC ,22-RABBIT> ,HERE>>>
                    <TELL ,MESSAGE-073 CR>
                    <RTRUE>)>
        >
    )>
>

;"Room: CAGE ------------------------------------------------------------------"
<ROOM 29-CAGE
    (DESC "In the Cage")
    (IN ROOMS)
    (LDESC 
"You are in the cage of the killer rabbit. The exit lies to the west.")
    (WEST TO 28-SMALL-ROOM)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (CAGE) STANDARD-F)>     

;"Room: MIRROR ROOM  ----------------------------------------------------------"
<ROOM 30-MIRROR-ROOM
    (DESC "Mirror Room")
    (IN ROOMS)
    (LDESC 
"You are in the mirror room. Doorways lead north and south, and a large mirror, through which you can see a toilet, occupies
the western wall.")
    (NORTH TO 26-NE-TOWER-BASE)
    (SOUTH TO 31-SMALL-ROOM)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE) (MIRROR) MIRROR-F)>  

<ROUTINE MIRROR-F ()
    <COND (<VERB? TOUCH RUB>
        <TELL ,MESSAGE-077 CR CR>
        <COND (<=? ,HERE ,30-MIRROR-ROOM>
                <COND (<NOT ,SCORE-ENTER-TOILET-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ENTER-TOILET-FLAG T>)>
                <GOTO ,56-TOILET>)
              (T <GOTO ,30-MIRROR-ROOM>)>
    )>    
>

;"Room: SMALL ROOM ------------------------------------------------------------"
<ROOM 31-SMALL-ROOM
    (DESC "Small Room")
    (IN ROOMS)
    (LDESC 
"You are in a small room whose eastern wall consists of bricks. Corridors lead north and south.")
    (NORTH TO 30-MIRROR-ROOM)
    (SOUTH TO 32-ROBOT-SHOP)
    (EAST PER SMALL-ROOM-BRICK-EXIT)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BRICKS) STANDARD-F)> 

<ROUTINE SMALL-ROOM-BRICK-EXIT ()
    <COND (<=? <LOC ,20-LARGE-HOLE> ,HERE> <RETURN ,57-SECRET-CHAMBER>)>
    <TELL ,SYSMESSAGE-007 CR>
    <RFALSE>
>

;"Room: ROBOT SHOP ------------------------------------------------------------"
<ROOM 32-ROBOT-SHOP
    (DESC "Robot Shop")
    (IN ROOMS)
    (LDESC 
"You are in a robot shop. Along the walls are standing several robots, damaged beyond repairability. Their voice modules, however,
seem to function, as they chatter uninterruptedly. It appears as though they are discussing the philosofical aspects of various
occurences. Doorways lead north and south.")
    (NORTH TO 31-SMALL-ROOM)
    (SOUTH TO 33-SE-TOWER-BASE)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (ROBOTS) STANDARD-F)> 

;"Room: SE TOWER BASE ---------------------------------------------------------"
<ROOM 33-SE-TOWER-BASE
    (DESC "Base of Southeast Tower")
    (IN ROOMS)
    (LDESC 
"You are standing at the base of the southeast tower. A spiral staircase leads up, corridors lead north and west, and there is
a gate in the southern wall.")
    (NORTH TO 32-ROBOT-SHOP)
    (SOUTH TO 50-FOREST)
    (WEST TO 35-LIVING-ROOM)
    (UP TO 34-BEDROOM)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAIRCASE GATE) STANDARD-F)> 

 ;"Room: BEDROOM --------------------------------------------------------------"
<ROOM 34-BEDROOM
    (DESC "Small Bedroom")
    (IN ROOMS)
    (LDESC 
"You are in a small bedroom, furnished with only a bed. There is a walk-in closet to the south, and a spiral staircase leads down.")
    (SOUTH TO 48-CLOSET)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAIRCASE BED) STANDARD-F)> 

;"Room: LIVING ROOM -----------------------------------------------------------"
<ROOM 35-LIVING-ROOM
    (DESC "Living Room")
    (IN ROOMS)
    (LDESC 
"You are in the living room. It's furnished with a sofa, a table, a couple of armchairs and a TV set. The TV set is showing some
kind of music programme. Doorways lead east and west.")
    (EAST TO 33-SE-TOWER-BASE)
    (WEST TO 36-GREAT-HALL)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SOFA TABLE ARMCHAIR ARMCHAIRS) STANDARD-F
            (<>) (TV) TV-F
            (JUMPING ROCK) (FAN) FAN-F)>     

<ROUTINE TV-F ()
    <COND (<VERB? EXAMINE>
        <COND (,14-FAN-FLAG
            <TELL ,MESSAGE-069 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-068 CR>
            <RTRUE>
        )>
    )>
>

<ROUTINE FAN-F ()
    <COND (<VERB? EXAMINE>
        <COND (<NOT ,14-FAN-FLAG>
            <TELL ,MESSAGE-022 CR>
            <RTRUE>
        )>
    )>
    <COND (<AND <VERB? TUBORG> <=? ,11-CURRENT-SPELL 46>>
        <COND (<NOT ,14-FAN-FLAG>
            <TELL ,MESSAGE-065 CR>
            <SETG ,14-FAN-FLAG T>)>
            <SETG ,11-CURRENT-SPELL 0>
            <MOVE ,12-UNSTEADY-FAN ,HERE>
        <RTRUE>
    )>
>

;"Room: GREAT HALL ------------------------------------------------------------"
<ROOM 36-GREAT-HALL
    (DESC "Great Hall")
    (IN ROOMS)
    (LDESC 
"You are in the great hall of the castle. It is large and empty. Corridors lead east and west, and to the the north is a
magnificient doorway.")
    (NORTH TO 46-SW-COURTYARD)
    (EAST TO 35-LIVING-ROOM)
    (WEST TO 37-KITCHEN)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)>    

;"Room: KITCHEN ---------------------------------------------------------------"
<ROOM 37-KITCHEN
    (DESC "Kitchen")
    (IN ROOMS)
    (LDESC 
"You are in the kitchen, which has been severely vandalised. The only intact item is a large cupboard. Doorways lead east and west.")
    (EAST TO 36-GREAT-HALL)
    (WEST TO 38-SW-TOWER-BASE)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE) (CUPBOARD) CUPBOARD-F)>

<ROUTINE CUPBOARD-F ()
    <COND (<VERB? OPEN>
        <COND   (<=? <LOC ,13-ROCK-FAN> ,HERE>
                    <TELL ,MESSAGE-054 CR>
                    <MOVE ,13-ROCK-FAN ,LOCAL-GLOBALS>
                    <SETG ,16-GRUE-COUNTER 2>
                    <SETG ,19-SOBER-FAN-FLAG <>>
                    <RTRUE>)
                (<=? ,16-GRUE-COUNTER 0>
                    <TELL ,MESSAGE-052 CR>
                    <SETG ,16-GRUE-COUNTER 1>
                    <RTRUE>)   
                (<=? ,16-GRUE-COUNTER 1>
                    <TELL ,MESSAGE-053 CR>
                    <RTRUE>)   
                (<=? ,16-GRUE-COUNTER 2>
                    <TELL ,MESSAGE-055 CR>
                    <MOVE ,11-CERISE-SCROLL ,WINNER>
                    <COND (<NOT ,SCORE-BRRRODVEJ-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-BRRRODVEJ-FLAG T>)>
                    <SETG ,16-GRUE-COUNTER 3>
                    <RTRUE>)  
                (<=? ,16-GRUE-COUNTER 3>
                    <TELL ,MESSAGE-056 CR>
                    <RTRUE>)>    
    )>
> 

;"Room: SW TOWER BASE ---------------------------------------------------------"
<ROOM 38-SW-TOWER-BASE
    (DESC "Base of Southwest Tower")
    (IN ROOMS)
    (LDESC 
"You are standing at the base of the southwest tower. Corridors lead north and east, and a spiral staircase leads up.")
    (NORTH TO 41-NS-CORRIDOR)
    (EAST TO 37-KITCHEN)
    (UP TO 39-SW-TOWER)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SPIRAL) (STAIRCASE) STANDARD-F)> 

;"Room: SW TOWER --------------------------------------------------------------"
<ROOM 39-SW-TOWER
    (DESC "Southwest Tower")
    (IN ROOMS)
    (LDESC 
"You are in the southwest tower. A spiral staircase leads down.")
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SPIRAL) (STAIRCASE) STANDARD-F)> 

;"Room: WELL BOTTOM -----------------------------------------------------------"
<ROOM 40-WELL-BOTTOM
    (DESC "Bottom of Well")
    (IN ROOMS)
    (LDESC 
"You are on the bottom of a 30 ft. deep well, standing in about 5 inches of lukewarm water.")
    (FLAGS LIGHTBIT)
    (ACTION WELL-BOTTOM-F)
    (THINGS (LUKEWARM) (WATER) STANDARD-F)> 

<ROUTINE WELL-BOTTOM-F (RARG)
    <COND (<AND <=? .RARG ,M-END> <=? <LOC ,23-KILLER-RABBIT> ,HERE>> 
        <TELL CR>
        <JIGS-UP ,MESSAGE-099> <RTRUE>)>
>

;"Room: NS CORRIDOR -----------------------------------------------------------"
<ROOM 41-NS-CORRIDOR
    (DESC "North-South Corridor")
    (IN ROOMS)
    (LDESC 
"You are walking along a north-south corridor.")
    (NORTH TO 17-ENTRANCE-HALL)
    (SOUTH TO 38-SW-TOWER-BASE)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: NW COURTYARD ---------------------------------------------------------"
<ROOM 42-NW-COURTYARD
    (DESC "Courtyard")
    (IN ROOMS)
    (LDESC 
"You are in the northwest corner of the courtyard. To the southeast lies a small brick building from which emanates horrible music.")
    (EAST TO 43-NE-COURTYARD)
    (SOUTH TO 44-COURTYARD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SMALL BRICK) (BUILDING) STANDARD-F
            (HORRIBLE) (MUSIC) STANDARD-F)> 

;"Room: NE COURTYARD ---------------------------------------------------------"
<ROOM 43-NE-COURTYARD
    (DESC "Courtyard")
    (IN ROOMS)
    (LDESC 
"You are in the northeast corner of the courtyard. To the southwest lies a small brick building from which emanates horrible music.")
    (NORTH TO 22-EW-CORRIDOR)
    (SOUTH TO 47-SE-COURTYARD)
    (WEST TO 42-NW-COURTYARD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SMALL BRICK) (BUILDING) STANDARD-F
            (HORRIBLE) (MUSIC) STANDARD-F)> 

;"Room: COURTYARD -------------------------------------------------------------"
<ROOM 44-COURTYARD
    (DESC "Courtyard")
    (IN ROOMS)
    (LDESC 
"You are on the courtyard, which extends to the north and south. To the west lies the interior of the castle, and to the
east lies a small brick building from which emanates horrible music.")
    (NORTH TO 42-NW-COURTYARD)
    (SOUTH TO 46-SW-COURTYARD)
    (EAST TO 45-ROCK-CLUB)
    (WEST TO 17-ENTRANCE-HALL)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SMALL BRICK) (BUILDING) STANDARD-F
            (HORRIBLE) (MUSIC) STANDARD-F)> 

;"Room: ROCK CLUB -------------------------------------------------------------"
<ROOM 45-ROCK-CLUB
    (DESC "Rock Club, Copenhagen")
    (IN ROOMS)
    (LDESC 
"You are in a rock club in Copenhagen. On stage is playing The Sisters of Mercy. There is also a bunch of TV technicians here,
along with their cameras and cables.")
    (ACTION ROCK-CLUB-F)
    (FLAGS LIGHTBIT)> 

<ROUTINE ROCK-CLUB-F (RARG)
    <COND (<=? .RARG ,M-END>
        <TELL CR ,MESSAGE-097 CR CR>
        <GOTO ,44-COURTYARD>
        <RTRUE>
    )>
>

;"Room: SW COURTYARD ----------------------------------------------------------"
<ROOM 46-SW-COURTYARD
    (DESC "Courtyard")
    (IN ROOMS)
    (LDESC 
"You are in the southwest corner of the courtyard. To the northeast lies a small brick building from which emanates horrible music.
You can enter the castle to the south.")
    (NORTH TO 44-COURTYARD)
    (SOUTH TO 36-GREAT-HALL)
    (EAST TO 47-SE-COURTYARD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SMALL BRICK) (BUILDING) STANDARD-F
            (HORRIBLE) (MUSIC) STANDARD-F)> 

;"Room: SE COURTYARD ----------------------------------------------------------"
<ROOM 47-SE-COURTYARD
    (DESC "Courtyard")
    (IN ROOMS)
    (LDESC 
"You are in the southeast corner of the courtyard. To the northwest lies a small brick building from which emanates horrible music.")
    (NORTH TO 43-NE-COURTYARD)
    (WEST TO 46-SW-COURTYARD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SMALL BRICK) (BUILDING) STANDARD-F
            (HORRIBLE) (MUSIC) STANDARD-F)> 

;"Room: CLOSET ----------------------------------------------------------------"
<ROOM 48-CLOSET
    (DESC "Walk-In Closet")
    (IN ROOMS)
    (LDESC 
"You are in a walk-in closet. The exit lies to the north.")
    (NORTH TO 34-BEDROOM)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: FOREST ----------------------------------------------------------------"
<ROOM 49-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest, in which you are lost.")
    (NORTH TO 50-FOREST)
    (SOUTH TO 51-FOREST)
    (EAST TO 52-FOREST)
    (WEST TO 51-FOREST)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: FOREST ----------------------------------------------------------------"
<ROOM 50-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest, in which you are lost. To the north lies the castle.")
    (NORTH TO 33-SE-TOWER-BASE)
    (SOUTH TO 52-FOREST)
    (EAST TO 52-FOREST)
    (WEST TO 49-FOREST)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 
     
;"Room: FOREST ----------------------------------------------------------------"
<ROOM 51-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest, in which you are lost.")
    (NORTH TO 52-FOREST)
    (SOUTH TO 53-SWAMP)
    (EAST TO 50-FOREST)
    (WEST TO 49-FOREST)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: FOREST ----------------------------------------------------------------"
<ROOM 52-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest, in which you are lost.")
    (NORTH TO 49-FOREST)
    (SOUTH TO 53-SWAMP)
    (EAST TO 50-FOREST)
    (WEST TO 51-FOREST)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 
 
;"Room: SWAMP -----------------------------------------------------------------"
<ROOM 53-SWAMP
    (DESC "Ivetofta Swamp")
    (IN ROOMS)
    (LDESC 
"You are in Ivetofta Swamp. The air is filled with midges and flies, and amphibians croak all around you.")
    (NORTH TO 51-FOREST)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SWAMP MIDGES FLIES AMPHIBIANS) STANDARD-F)> 

;"Room: WORKS -----------------------------------------------------------------"
<ROOM 54-WORKS
    (DESC "Works of Petrol Station")
    (IN ROOMS)
    (LDESC 
"You are in the works of a petrol station. It's filled with cars of different sizes and configurations, all of which are broken.
A door in the eastern wall leads out, and the toilet lies to the west.")
    (EAST TO 55-PETROL-STATION)
    (WEST TO 56-TOILET)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (CAR CARS) STANDARD-F)> 

;"Room: PETROL STATION --------------------------------------------------------"
<ROOM 55-PETROL-STATION
    (DESC "Petrol Station")
    (IN ROOMS)
    (LDESC 
"You are at a petrol station. A petrol pump is here. The road lies to the south and the works lies to the west.")
    (SOUTH TO 59-DUSTY-ROAD)
    (WEST TO 54-WORKS)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (PETROL) (PUMP) STANDARD-F)> 

;"Room: TOILET ----------------------------------------------------------------"
<ROOM 56-TOILET
    (DESC "Toilet")
    (IN ROOMS)
    (LDESC 
"You are in a toilet. It's equipped in a fashion normal for toilets: a bowl and a washbasin with a mirror, through which
you can see the interior of a castle, over it. The exit lies to the east.")
    (EAST TO 54-WORKS)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (TOILET BOWL WASHBASIN) STANDARD-F
            (<>) (MIRROR) MIRROR-F)> 
      
;"Room: SECRET CHAMBER --------------------------------------------------------"
<ROOM 57-SECRET-CHAMBER
    (DESC "Kvill's Secret Chamber")
    (IN ROOMS)
    (LDESC 
"You are in Kvill's secret chamber. You can go west through a hole in the brick wall. Kvill is here, wearing a black tuxedo,
his hair impeccably combed.")
    (WEST TO 31-SMALL-ROOM)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (WALL) STANDARD-F)> 

;"Room: DUSTY ROAD ------------------------------------------------------------"
<ROOM 58-DUSTY-ROAD
    (DESC "Dusty Road")
    (IN ROOMS)
    (LDESC 
"You are standing on a dusty east-west road.")
    (EAST TO 59-DUSTY-ROAD)
    (WEST TO 58-DUSTY-ROAD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: DUSTY ROAD ------------------------------------------------------------"
<ROOM 59-DUSTY-ROAD
    (DESC "Dusty Road")
    (IN ROOMS)
    (LDESC 
"You are standing on a dusty east-west road. To the north lies a petrol station.")
    (NORTH TO 55-PETROL-STATION)
    (EAST TO 60-DUSTY-ROAD)
    (WEST TO 58-DUSTY-ROAD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: DUSTY ROAD ------------------------------------------------------------"
<ROOM 60-DUSTY-ROAD
    (DESC "Dusty Road")
    (IN ROOMS)
    (LDESC 
"You are standing on a dusty east-west road.")
    (EAST TO 60-DUSTY-ROAD)
    (WEST TO 59-DUSTY-ROAD)
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)> 

;"Room: MINTER ROOM -----------------------------------------------------------"
<ROOM 61-MINTER-ROOM
    (DESC "Jeff Minter Room")
    (IN ROOMS)
    (LDESC 
"You are in the former Jeff Minter room, which is now laid in ruins. A spiral staircase leads down.")
    (DOWN PER WELL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (SPIRAL) (STAIRCASE) STANDARD-F)> 

;"-----------------------------------------------------------------------------
; OBJECTS
; -----------------------------------------------------------------------------"

;"Object: DISTILLATION KIT ----------------------------------------------------"
<OBJECT DISTILLATION-KIT
	(IN 16-INSIDE-FARMHOUSE)
	(SYNONYM KIT)
    (ADJECTIVE SHINING DISTILLATION)
	(DESC "shining distillation kit")
    (ACTION KIT-F)
    (FLAGS NDESCBIT CONTBIT)>

<ROUTINE KIT-F ()
    <COND (<VERB? EXAMINE>
        <COND (,12-YEAST-FLAG
            <TELL ,MESSAGE-016 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-015 CR>
            <MOVE ,05-YEAST-SCROLL ,HERE>
            <RTRUE>
        )>
    )>
>

;"Object: PETROL --------------------------------------------------------------"
<OBJECT PETROL
	(IN 55-PETROL-STATION)
	(SYNONYM PETROL)
	(DESC "petrol")
    (ACTION PETROL-F)
    (FLAGS NDESCBIT LIQUIDBIT)>

<ROUTINE PETROL-F ()
    <COND (<VERB? TAKE PUMP>
        <COND (<HELD? 27-BUCKET>
            <TELL ,MESSAGE-008 CR>
            <MOVE ,27-BUCKET ,LOCAL-GLOBALS>
            <MOVE ,28-BUCKET-WITH-PETROL ,WINNER>
            <RTRUE>
        )>
        <COND (<HELD? 28-BUCKET-WITH-PETROL>
            <TELL ,MESSAGE-009 CR>
            <RTRUE>
        )>
        <TELL ,MESSAGE-010 CR>
        <RTRUE>
   )>
>

;"Object: KVILL ---------------------------------------------------------------"
<OBJECT KVILL
	(IN 57-SECRET-CHAMBER)
	(SYNONYM KVILL)
	(DESC "Kvill")
    (ACTION KVILL-F)
    (FLAGS PERSONBIT NDESCBIT NARTICLEBIT)>

<ROUTINE KVILL-F ()
    <COND (<VERB? EXAMINE>
        <COND   (,20-KVILL-FLAG <TELL ,MESSAGE-092 CR>)
                (<NOT ,20-KVILL-FLAG> <TELL ,MESSAGE-091 CR>)>
        <RTRUE>
    )>
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
        <COND (,20-KVILL-FLAG <TELL ,MESSAGE-094 CR>)
              (<NOT ,20-KVILL-FLAG> <TELL ,MESSAGE-093 CR> <SETG ,20-KVILL-FLAG T>)>
        <SETG ,11-CURRENT-SPELL 0>
        <RTRUE>
    )>
    <COND (<VERB? TELL> <SETG ,WINNER ,PRSO> <RTRUE>)>
    <COND (<OR <=? ,WINNER ,KVILL> <=? ,PRSO ,KVILL>>
        <COND   (<OR <VERB? HELLO> <=? ,PRSI ,HELLO>> <TELL ,MESSAGE-115 CR> <RTRUE>)
                (<=? ,WINNER ,KVILL> <TELL "You are plainly ignored." CR> <RTRUE>)>
    )>
    <COND (<AND <VERB? REPHLEX> <=? ,11-CURRENT-SPELL 43>>
        <COND (,20-KVILL-FLAG
        <COND (<NOT ,SCORE-KVILL-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-KVILL-FLAG T>)>
            <JIGS-UP ,MESSAGE-090>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-089 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
        )>
    )>
>

;"Object: HEAD ----------------------------------------------------------------"
<OBJECT HEAD
	(IN GLOBAL-OBJECTS)
	(SYNONYM HEAD)
    (ADJECTIVE MY)
	(DESC "your head")
	(FLAGS NDESCBIT NARTICLEBIT PARTBIT)>

;"Object: HEAD ----------------------------------------------------------------"
<OBJECT CAFE
	(IN GLOBAL-OBJECTS)
	(SYNONYM CAFE)
    (ADJECTIVE MY)
	(DESC "cafe")
    (ACTION CAFE-F)
	(FLAGS NDESCBIT)>

<ROUTINE CAFE-F ()
    <COND (<VERB? OPEN> <TELL ,MESSAGE-042 CR> <RTRUE>)>
>

;"Object: BINOCULARS ----------------------------------------------------------"
<OBJECT 01-BINOCULARS
	(IN 03-INSIDE-CARBOARD-HUT)
	(SYNONYM BINOCULARS)
    (ADJECTIVE RED PLASTIC)
	(DESC "pair of red plastic binoculars")
    (TEXT ,MESSAGE-011)
    (FLAGS TAKEBIT)>

;"Object: PIGGY BANK ----------------------------------------------------------"
<OBJECT 02-PIGGY-BANK
	(IN 08-PLAYGROUND)
	(SYNONYM BANK)
    (ADJECTIVE CHROME PIGGY)
	(DESC "chrome piggy bank")
    (TEXT ,MESSAGE-012)
    (FLAGS TAKEBIT)>

;"Object: CHROME SPOON --------------------------------------------------------"
<OBJECT 03-CHROME-SPOON
	(IN PLAYER)
	(SYNONYM SPOON)
    (ADJECTIVE OVER-SIZED OVERSIZED CHROME)
	(DESC "oversized, chrome spoon")
    (FLAGS TAKEBIT NARTICLEBIT)>

;"Object: NEWSPSPER -----------------------------------------------------------"
<OBJECT 04-NEWSPAPER
	(IN LOCAL-GLOBALS)
	(SYNONYM NEWSPAPER ARTICLE)
	(DESC "newspaper")
    (TEXT ,MESSAGE-013)
    (ACTION NEWSPAPER-F)
    (FLAGS TAKEBIT READBIT EXTRABIT)>

<ROUTINE NEWSPAPER-F ()
    <COND (<VERB? TAKE>
        <COND (<AND <=? ,HERE ,16-INSIDE-FARMHOUSE> <NOT ,12-YEAST-FLAG>>
            <JIGS-UP ,MESSAGE-050>
            <RTRUE>
        )>
    )>
    <COND (<VERB? READ>
        <FIXED-FONT-ON>
        <TELL ,MESSAGE-014 CR>
        <FIXED-FONT-OFF>
        <RTRUE>
    )>
    <COND (<AND <VERB? REPLACE> <OR <=? ,PRSI ,05-YEAST-SCROLL> <=? ,PRSI <>> <HELD? ,05-YEAST-SCROLL>>>
        <JIGS-UP ,MESSAGE-058>
        <RTRUE>
    )>
    <COND (<AND <VERB? INSERT> <OR <=? ,PRSI ,DISTILLATION-KIT> <=? ,PRSI <>> <HELD? ,04-NEWSPAPER>>>
        <TELL ,MESSAGE-057 CR>
        <MOVE ,04-NEWSPAPER ,HERE>
        <FSET ,04-NEWSPAPER ,NDESCBIT>
        <FCLEAR ,05-YEAST-SCROLL ,NDESCBIT>
        <MOVE ,05-YEAST-SCROLL ,WINNER>
        <COND (<NOT ,SCORE-BRENWYN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-BRENWYN-FLAG T>)>
        <RTRUE>
    )>
>

;"Object: YEAST SCROLL --------------------------------------------------------"
<OBJECT 05-YEAST-SCROLL
	(IN LOCAL-GLOBALS)
	(SYNONYM SCROLL)
    (ADJECTIVE YEAST YEAST-SMELLING SMELLING BRENWYN)
	(DESC "yeast-smelling scroll")
    (TEXT ,MESSAGE-018)
    (ACTION YEAST-SCROLL-F)
    (FLAGS TAKEBIT READBIT NDESCBIT EXTRABIT SCROLLBIT)>

<ROUTINE YEAST-SCROLL-F ()
    <COND (<VERB? TAKE>
        <COND (<AND <=? ,HERE ,16-INSIDE-FARMHOUSE> <NOT ,12-YEAST-FLAG>>
            <JIGS-UP ,MESSAGE-049>
            <RTRUE>
        )>
    )>
    <COND (<AND <VERB? REPLACE> <OR <=? ,PRSI ,04-NEWSPAPER> <=? ,PRSI <>> <HELD? ,04-NEWSPAPER>>>
        <TELL ,MESSAGE-057 CR>
        <MOVE ,04-NEWSPAPER ,HERE>
        <FSET ,04-NEWSPAPER ,NDESCBIT>
        <FCLEAR ,05-YEAST-SCROLL ,NDESCBIT>
        <MOVE ,05-YEAST-SCROLL ,WINNER>
        <COND (<NOT ,SCORE-BRENWYN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-BRENWYN-FLAG T>)>
        <RTRUE>
    )>
    <COND (<AND <VERB? INSERT> <OR <=? ,PRSI ,DISTILLATION-KIT> <=? ,PRSI <>> <HELD? ,05-YEAST-SCROLL>>>
        <JIGS-UP ,MESSAGE-058>
        <RTRUE>
    )>
    <COND (<AND <VERB? XEROX> <FSET? ,PRSO ,SCROLLBIT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-005 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <MOVE ,41-BRENWYN-SPELL ,38-SPELL-BOOK>
        <RTRUE>
    )>
>

;"Object: MACHINE -------------------------------------------------------------"
<OBJECT 06-MACHINE
	(IN 39-SW-TOWER)
	(SYNONYM MACHINE HAMMER COGWHEEL COGWHEELS HOLE)
    (ADJECTIVE LARGE STRANGE)
	(DESC "strange machine with cogwheels, a large hammer and a hole in it")
    (ACTION MACHINE-F)>

<ROUTINE MACHINE-F ()
    <COND (<AND <VERB? FILL> <OR <=? ,PRSI <>> <=? ,PRSI ,28-BUCKET-WITH-PETROL> <HELD? ,PRSI>>>
        <TELL ,MESSAGE-079 CR>
        <MOVE ,28-BUCKET-WITH-PETROL ,LOCAL-GLOBALS>
        <MOVE ,27-BUCKET ,HERE>
        <MOVE ,06-MACHINE ,LOCAL-GLOBALS>
        <MOVE ,07-INFERNAL-MACHINE ,HERE>
        <RTRUE>
    )>
>

;"Object: INFERNAL MACHINE ----------------------------------------------------"
<OBJECT 07-INFERNAL-MACHINE
	(IN LOCAL-GLOBALS)
	(SYNONYM MACHINE HAMMER COGWHEEL COGWHEELS HOLE)
    (ADJECTIVE LARGE STRANGE)
	(DESC "The infernal machine, making a horrible noise, the hammer hitting the floor repeatedly")
    (ACTION INFERNAL-MACHINE-F)
    (FLAGS NARTICLEBIT)>

<ROUTINE INFERNAL-MACHINE-F ()
    <COND (<VERB? FILL> <TELL ,SYSMESSAGE-008 CR> <RTRUE>)>
>

;"Object: COIN ----------------------------------------------------------------"
<OBJECT 08-COIN
	(IN LOCAL-GLOBALS)
	(SYNONYM COIN ZORKMID MONEY)
	(DESC "0.038 zorkmid coin")
    (FLAGS TAKEBIT)>

;"Object: TOWEL ---------------------------------------------------------------"
<OBJECT 09-TOWEL
	(IN 37-KITCHEN)
	(SYNONYM TOWEL)
    (ADJECTIVE PINK)
	(DESC "towel")
    (TEXT ,MESSAGE-019)
    (ACTION TOWEL-F)
    (FLAGS TAKEBIT)>

<ROUTINE TOWEL-F ()
    <COND (<AND <VERB? WEAR WRAP> <OR <=? ,PRSI <>> <=? ,PRSI ,HEAD>>>
        <TELL ,MESSAGE-100 CR>
        <MOVE ,09-TOWEL ,LOCAL-GLOBALS>
        <MOVE ,10-TOWEL-AROUND-HEAD ,WINNER>
        <RTRUE>
    )>
>

;"Object: TOWEL AROUND HEAD ---------------------------------------------------"
<OBJECT 10-TOWEL-AROUND-HEAD
	(IN LOCAL-GLOBALS)
	(SYNONYM TOWEL)
    (ADJECTIVE PINK)
	(DESC "towel (wrapped around your head)")
    (TEXT ,MESSAGE-019)
    (ACTION TOWEL-AROUND-HEAD-F)
    (FLAGS TAKEBIT)>

<ROUTINE TOWEL-AROUND-HEAD-F ()
    <COND (<AND <VERB? UNWEAR DROP> <HELD? ,PRSO>>
        <TELL ,MESSAGE-101 CR>
        <MOVE ,09-TOWEL ,WINNER>
        <MOVE ,10-TOWEL-AROUND-HEAD ,LOCAL-GLOBALS>
        <COND (<VERB? DROP> <MOVE ,09-TOWEL ,HERE>)>
        <THIS-IS-IT ,09-TOWEL>
        <RTRUE>
    )>
>

;"Object: CERISE SCROLL -------------------------------------------------------"
<OBJECT 11-CERISE-SCROLL
	(IN LOCAL-GLOBALS)
	(SYNONYM SCROLL)
    (ADJECTIVE CERISE BRRRODVEJ)
	(DESC "cerise scroll")
    (TEXT ,MESSAGE-020)
    (ACTION CERISE-SCROLL-F)
    (FLAGS TAKEBIT READBIT SCROLLBIT)>

<ROUTINE CERISE-SCROLL-F ()
    <COND (<AND <VERB? XEROX> <FSET? ,PRSO ,SCROLLBIT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-005 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <MOVE ,42-BRRRODVEJ-SPELL ,38-SPELL-BOOK>
        <RTRUE>
    )>
>

;"Object: UNSTEADY FAN --------------------------------------------------------"
<OBJECT 12-UNSTEADY-FAN
	(IN LOCAL-GLOBALS)
	(SYNONYM FAN)
    (ADJECTIVE UNSTEADY ROCK)
	(DESC "somewhat unsteady rock fan")
    (TEXT ,MESSAGE-021)
    (ACTION UNSTEADY-FAN-F)
    (FLAGS PERSONBIT)>

<ROUTINE UNSTEADY-FAN-F ()
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
            <TELL ,MESSAGE-113 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
    )>
    <COND (<VERB? TELL> <SETG ,WINNER ,PRSO> <RTRUE>)>
    <COND (<OR <=? ,WINNER ,12-UNSTEADY-FAN> <=? ,PRSO ,12-UNSTEADY-FAN>>
        <COND   (<OR <VERB? HELLO> <=? ,PRSI ,HELLO>> <TELL ,MESSAGE-116 CR> <RTRUE>)
                (<=? ,WINNER ,12-UNSTEADY-FAN> <TELL "You are plainly ignored." CR> <RTRUE>)>
    )>
    <COND (<AND <VERB? BRENWYN> <=? ,11-CURRENT-SPELL 41>>
        <TELL ,MESSAGE-066 CR>
        <MOVE ,12-UNSTEADY-FAN ,LOCAL-GLOBALS>
        <MOVE ,13-ROCK-FAN ,HERE>
        <SETG ,19-SOBER-FAN-FLAG T>
        <SETG ,11-CURRENT-SPELL 0>
        <RTRUE>
    )>
>

;"Object: ROCK FAN ------------------------------------------------------------"
<OBJECT 13-ROCK-FAN
	(IN LOCAL-GLOBALS)
	(SYNONYM FAN)
    (ADJECTIVE ROCK)
	(DESC "rock fan")
    (TEXT ,MESSAGE-023)
    (ACTION ROCK-FAN-F)
    (FLAGS PERSONBIT)>

<ROUTINE ROCK-FAN-F ()
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
            <TELL ,MESSAGE-114 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
    )>
    <COND (<VERB? TELL> <SETG ,WINNER ,PRSO> <RTRUE>)>
    <COND (<OR <=? ,WINNER ,13-ROCK-FAN> <=? ,PRSO ,13-ROCK-FAN>>
        <COND   (<OR <VERB? HELLO> <=? ,PRSI ,HELLO>> <TELL ,MESSAGE-116 CR> <RTRUE>)
                (<=? ,WINNER ,13-ROCK-FAN> <TELL "You are plainly ignored." CR> <RTRUE>)>
    )>
>

;"Object: JUMPING FAN ---------------------------------------------------------"
<OBJECT 14-JUMPING-FAN
	(IN 45-ROCK-CLUB)
	(SYNONYM FAN)
    (ADJECTIVE JUMPING ROCK)
	(DESC "rock fan, jumping up and down to the so-called music")
    (FLAGS PERSONBIT)>

;"Object: WIG -----------------------------------------------------------------"
<OBJECT 15-WIG
	(IN 48-CLOSET)
	(SYNONYM WIG)
    (ADJECTIVE BLOND)
	(DESC "blond wig")
    (ACTION WIG-F)
    (FLAGS TAKEBIT)>

<ROUTINE WIG-F ()
    <COND (<AND <VERB? WEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT>>
        <TELL ,SYSMESSAGE-029 CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? WEAR> <HELD? ,PRSO> <NOT <FSET? ,PRSO ,WORNBIT>>>
        <TELL ,MESSAGE-082 CR>
        <FSET ,PRSO ,WORNBIT>
        <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <NOT <FSET? ,PRSO ,WORNBIT>>>
        <TELL ,SYSMESSAGE-023 CR>
         <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT>>
        <FCLEAR ,PRSO ,WORNBIT>
        <TELL ,MESSAGE-083 CR>
         <RTRUE>
    )>
>

;"Object: DRESS ---------------------------------------------------------------"
<OBJECT 16-DRESS
	(IN 48-CLOSET)
	(SYNONYM DRESS)
    (ADJECTIVE CERISE)
	(DESC "cerise dress")
    (ACTION DRESS-F)
    (FLAGS TAKEBIT)>

<ROUTINE DRESS-F ()
    <COND (<AND <VERB? WEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT>>
        <TELL ,SYSMESSAGE-029 CR>
        <RTRUE>
    )>
    <COND (<AND <VERB? WEAR> <HELD? ,PRSO> <NOT <FSET? ,PRSO ,WORNBIT>>>
        <TELL ,MESSAGE-081 CR>
        <FSET ,PRSO ,WORNBIT>
        <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <NOT <FSET? ,PRSO ,WORNBIT>>>
        <TELL ,SYSMESSAGE-023 CR>
         <RTRUE>
    )>
    <COND (<AND <VERB? UNWEAR> <HELD? ,PRSO> <FSET? ,PRSO ,WORNBIT>>
        <FCLEAR ,PRSO ,WORNBIT>
        <TELL ,MESSAGE-084 CR>
         <RTRUE>
    )>
>

;"Object: TOAD ----------------------------------------------------------------"
<OBJECT 17-TOAD
	(IN 53-SWAMP)
	(SYNONYM TOAD)
	(DESC "toad")
    (ACTION TOAD-F)
    (FLAGS PERSONBIT)>

<ROUTINE TOAD-F ()
    <COND (<AND <VERB? REVHOL> <=? ,11-CURRENT-SPELL 44>>
        <TELL ,MESSAGE-085 CR CR>
        <COND (<AND <FSET? ,15-WIG ,WORNBIT> <FSET? ,16-DRESS ,WORNBIT>>
            <TELL ,MESSAGE-087 CR>
            <MOVE ,17-TOAD ,LOCAL-GLOBALS>
            <MOVE ,33-COLOGNE-SOAKED-SCROLL ,WINNER>
            <COND (<NOT ,SCORE-REPHLEX-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-REPHLEX-FLAG T>)>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
        )
        (T
            <JIGS-UP ,MESSAGE-086>
            <RTRUE>
        )>
    )>
    <COND (<VERB? KISS> <TELL ,MESSAGE-107 CR> <RTRUE>)>
>

;"Object: FLOYD ---------------------------------------------------------------"
<OBJECT 18-FLOYD
	(IN 32-ROBOT-SHOP)
	(SYNONYM FLOYD DROID ROBOT)
	(DESC "Floyd the droid")
    (TEXT ,MESSAGE-024)
    (FLAGS NARTICLEBIT PERSONBIT CONTBIT)>

;"Object: PINK-SCROLL ---------------------------------------------------------"
<OBJECT 19-PINK-SCROLL
	(IN LOCAL-GLOBALS)
	(SYNONYM SCROLL)
    (ADJECTIVE PINK REVHOL)
	(DESC "pink scroll")
    (TEXT ,MESSAGE-025)
    (ACTION PINK-SCROLL-F)
    (FLAGS TAKEBIT READBIT SCROLLBIT)>

<ROUTINE PINK-SCROLL-F ()
    <COND (<AND <VERB? XEROX> <FSET? ,PRSO ,SCROLLBIT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-005 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <MOVE ,44-REVHOL-SPELL ,38-SPELL-BOOK>
        <RTRUE>
    )>
>

;"Object: LARGE HOLE ----------------------------------------------------------"
<OBJECT 20-LARGE-HOLE
	(IN LOCAL-GLOBALS)
	(SYNONYM HOLE)
    (ADJECTIVE LARGE)
	(DESC "large hole in the brick wall")
    (TEXT ,MESSAGE-026)>

;"Object: PHOTO ---------------------------------------------------------------"
<OBJECT 21-PHOTO
	(IN 27-JEFF-MINTERS-ROOM)
	(SYNONYM PHOTO)
    (ADJECTIVE JEFF MINTER)
	(DESC "photo of Jeff Minter")
    (TEXT ,MESSAGE-027)
    (ACTION PHOTO-F)
    (FLAGS TAKEBIT)>

<ROUTINE PHOTO-F ()
    <COND (<AND <VERB? SHOW> <=? ,PRSI ,35-COMPANY>>
        <TELL ,MESSAGE-060 CR>
        <SETG ,17-COMPANY-FLAG T>
        <RTRUE>
    )>
    <COND (<AND     <=? ,HERE ,31-SMALL-ROOM> 
                    <HELD? ,21-PHOTO> 
                    <=? <LOC ,35-COMPANY> ,HERE> 
                    <OR <VERB? DROP> <AND <VERB? GIVE> <=? ,PRSI ,35-COMPANY>>>>
        <TELL ,MESSAGE-063 CR>
        <MOVE ,21-PHOTO ,LOCAL-GLOBALS>
        <MOVE ,35-COMPANY ,LOCAL-GLOBALS>
        <MOVE ,47-SMALL-HOLE ,LOCAL-GLOBALS>
        <MOVE ,20-LARGE-HOLE ,HERE>
        <MOVE ,36-UNCONSCIOUS-PERSONS ,HERE>
        <SETG ,17-COMPANY-FLAG <>>
        <COND (<NOT ,SCORE-LARGE-HOLE-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-LARGE-HOLE-FLAG T>)>
        <RTRUE>
    )>
    <COND (<AND     <NOT <=? ,HERE ,31-SMALL-ROOM>> 
                    <HELD? ,21-PHOTO> 
                    <=? <LOC ,35-COMPANY> ,HERE> 
                    <OR <VERB? DROP> <AND <VERB? GIVE> <=? ,PRSI ,35-COMPANY>>>>
        <TELL ,MESSAGE-062 CR>
        <MOVE ,21-PHOTO ,LOCAL-GLOBALS>
        <MOVE ,35-COMPANY ,LOCAL-GLOBALS>
        <MOVE ,36-UNCONSCIOUS-PERSONS ,HERE>
        <SETG ,17-COMPANY-FLAG <>>
        <RTRUE>
    )>
>

;"Object: RABBIT --------------------------------------------------------------"
<OBJECT 22-RABBIT
	(IN 28-SMALL-ROOM)
	(SYNONYM RABBIT)
    (ADJECTIVE WHITE BUNNY)
	(DESC "small white bunny rabbit (inside the cage)")
    (TEXT ,MESSAGE-028)>

;"Object: KILLER RABBIT -------------------------------------------------------"
<OBJECT 23-KILLER-RABBIT
	(IN LOCAL-GLOBALS)
	(SYNONYM RABBIT)
    (ADJECTIVE WHITE BUNNY KILLER)
	(DESC "The killer rabbit")
    (FLAGS NARTICLEBIT)>

;"Object: BOX -----------------------------------------------------------------"
<OBJECT 24-BOX
	(IN 58-DUSTY-ROAD)
	(SYNONYM BOX WELL)
    (ADJECTIVE CARDBOARD)
	(DESC "cardboard box")
    (TEXT ,MESSAGE-029)
    (ACTION BOX-F)
    (FLAGS NDESCBIT)>

<ROUTINE BOX-F ()
    <COND (<AND <VERB? EXAMINE> <FSET? ,PRSO ,NDESCBIT>> <TELL "You don't see that here." CR> <RTRUE>)>
    <COND (<AND <VERB? BUY> <=? <LOC ,26-HONEST-JOHN> ,HERE> <HELD? ,08-COIN>>
        <TELL ,MESSAGE-095 CR>
        <MOVE ,08-COIN ,LOCAL-GLOBALS>
        <MOVE ,24-BOX ,WINNER>
        <FCLEAR ,24-BOX ,NDESCBIT>
        <FSET ,24-BOX ,TAKEBIT>
        <RTRUE>
    )>
    <COND (<AND <VERB? OPEN> <HELD? ,PRSO>>
        <TELL ,MESSAGE-074 CR>
        <MOVE ,24-BOX ,LOCAL-GLOBALS>
        <MOVE ,25-WELL ,HERE>
        <RTRUE>
    )>
>

;"Object: WELL ----------------------------------------------------------------"
<OBJECT 25-WELL
	(IN LOCAL-GLOBALS)
	(SYNONYM WELL)
    (ADJECTIVE DEEP)
	(DESC "30 ft. deep well")
    (ACTION WELL-F)
    (TEXT ,MESSAGE-030)>

<ROUTINE WELL-F ()
    <COND (<VERB? TAKE> <TELL ,MESSAGE-003 CR> <RTRUE>)>
>

;"Object: HONEST JOHN ---------------------------------------------------------"
<OBJECT 26-HONEST-JOHN
	(IN 58-DUSTY-ROAD)
	(SYNONYM JOHN)
    (ADJECTIVE HONEST)
	(DESC "Honest John the well-monger, seated in his Eldorado Cadillac")
    (TEXT ,MESSAGE-031)
    (ACTION HONEST-JOHN-F)
    (FLAGS NARTICLEBIT PERSONBIT)>

<ROUTINE HONEST-JOHN-F ()
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
            <TELL ,MESSAGE-111 CR>
            <MOVE ,26-HONEST-JOHN ,LOCAL-GLOBALS>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
    )>
    <COND (<VERB? TELL> <SETG ,WINNER ,PRSO> <RTRUE>)>
    <COND (<OR <=? ,WINNER ,26-HONEST-JOHN> <=? ,PRSO ,26-HONEST-JOHN>>
        <COND   (<OR <VERB? HELLO> <=? ,PRSI ,HELLO>> <TELL ,MESSAGE-108 CR> <RTRUE>)
                (<=? ,WINNER ,26-HONEST-JOHN> <TELL "You are plainly ignored." CR> <RTRUE>)>
    )>
>

;"Object: BUCKET --------------------------------------------------------------"
<OBJECT 27-BUCKET
	(IN 54-WORKS)
	(SYNONYM BUCKET)
	(DESC "bucket")
    (ACTION BUCKET-F)
    (FLAGS TAKEBIT)>

<ROUTINE BUCKET-F ()
    <COND (<VERB? FILL>
        <COND   (<=? ,HERE ,55-PETROL-STATION> <PERFORM V?TAKE ,PETROL>)
                (<AND   <=? ,PRSO ,28-BUCKET-WITH-PETROL> 
                        <=? ,HERE ,39-SW-TOWER> 
                        <=? <LOC ,06-MACHINE> ,HERE>> <PERFORM V?FILL ,06-MACHINE> <RTRUE>)>
    )>
    <COND (<VERB? INSERT>
        <COND   (<AND   <=? ,PRSO ,28-BUCKET-WITH-PETROL>
                        <=? ,PRSI ,06-MACHINE> 
                        <=? ,HERE ,39-SW-TOWER> 
                        <=? <LOC ,06-MACHINE> ,HERE>> <PERFORM V?FILL ,06-MACHINE> <RTRUE>)>
    )>
>

;"Object: BUCKET WITH PETROL --------------------------------------------------"
<OBJECT 28-BUCKET-WITH-PETROL
	(IN LOCAL-GLOBALS)
	(SYNONYM BUCKET PETROL)
	(DESC "bucket of petrol")
    (ACTION BUCKET-F)
    (FLAGS TAKEBIT)>

;"Object: MOTOR ---------------------------------------------------------------"
<OBJECT 29-MOTOR
	(IN 54-WORKS)
	(SYNONYM MOTOR)
    (ADJECTIVE STRANGE)
	(DESC "strange motor")
    (ACTION MOTOR-F)
    (FLAGS TAKEBIT)>

<ROUTINE MOTOR-F ()
    <COND (<AND <VERB? INSERT> <HELD? ,29-MOTOR> <=? ,PRSI ,18-FLOYD>>
        <TELL ,MESSAGE-078 CR>
        <MOVE ,29-MOTOR ,LOCAL-GLOBALS>
        <MOVE ,19-PINK-SCROLL ,WINNER>
        <COND (<NOT ,SCORE-REVHOL-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-REVHOL-FLAG T>)>
        <MOVE ,18-FLOYD ,LOCAL-GLOBALS>
        <RTRUE>
    )>
>

;"Object: BLANK SCROLL --------------------------------------------------------"
<OBJECT 30-BLANK-SCROLL
	(IN 29-CAGE)
	(SYNONYM SCROLL)
    (ADJECTIVE BLANK)
	(DESC "blank scroll")
    (TEXT ,MESSAGE-032)
    (ACTION BLANK-SCROLL-F)
    (FLAGS TAKEBIT READBIT SCROLLBIT)>

<ROUTINE BLANK-SCROLL-F ()
    <COND (<AND <VERB? WRITE> <=? ,PRSO ,30-BLANK-SCROLL> <=? ,PRSI ,31-PENCIL>>
        <TELL ,MESSAGE-075 CR>
        <MOVE ,30-BLANK-SCROLL ,LOCAL-GLOBALS>
        <MOVE ,32-NEW-SCROLL ,WINNER>
        <COND (<NOT ,SCORE-TUBORG-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-TUBORG-FLAG T>)>
        <MOVE ,31-PENCIL ,LOCAL-GLOBALS>
        <RTRUE>
    )>
>

;"Object: PENCIL --------------------------------------------------------------"
<OBJECT 31-PENCIL
	(IN 29-CAGE)
	(SYNONYM PENCIL)
    (ADJECTIVE WORN-OUT)
    (TEXT ,MESSAGE-033)
	(DESC "nearly worn-out pencil")
    (FLAGS TAKEBIT TOOLBIT)>

;"Object: NEW SCROLL ----------------------------------------------------------"
<OBJECT 32-NEW-SCROLL
	(IN LOCAL-GLOBALS)
	(SYNONYM SCROLL)
    (ADJECTIVE NEW TUBORG)
	(DESC "new scroll")
    (TEXT ,MESSAGE-034)
    (ACTION NEW-SCROLL-F)
    (FLAGS TAKEBIT READBIT SCROLLBIT)>

<ROUTINE NEW-SCROLL-F ()
    <COND (<AND <VERB? XEROX> <FSET? ,PRSO ,SCROLLBIT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-005 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <MOVE ,46-TUBORG-SPELL ,38-SPELL-BOOK>
        <RTRUE>
    )>
>

;"Object: COLOGNE-SOAKED SCROLL -----------------------------------------------"
<OBJECT 33-COLOGNE-SOAKED-SCROLL
	(IN LOCAL-GLOBALS)
	(SYNONYM SCROLL)
    (ADJECTIVE COLOGNE-SOAKED COLOGNE SOAKED REPHLEX)
	(DESC "cologne-soaked scroll")
    (TEXT ,MESSAGE-035)
    (ACTION COLOGNE-SOAKED-SCROLL-F)
    (FLAGS TAKEBIT READBIT SCROLLBIT)>

<ROUTINE COLOGNE-SOAKED-SCROLL-F ()
    <COND (<AND <VERB? XEROX> <FSET? ,PRSO ,SCROLLBIT> <HELD? ,PRSO>>
        <TELL ,MESSAGE-005 CR>
        <MOVE ,PRSO ,LOCAL-GLOBALS>
        <MOVE ,43-REPHLEX-SPELL ,38-SPELL-BOOK>
        <RTRUE>
    )>
>

;"Object: PERSONS -------------------------------------------------------------"
<OBJECT 34-PERSONS
	(IN 23-DUNGEON-OF-DESPAIR)
	(SYNONYM PERSONS)
	(DESC "large number of persons from different adventure games, fettered to the walls")
    (TEXT ,MESSAGE-036)
    (ACTION PERSONS-F)>

<ROUTINE PERSONS-F ()
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
            <TELL ,MESSAGE-112 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
    )>
    <COND (<VERB? TELL> <SETG ,WINNER ,PRSO> <RTRUE>)>
    <COND (<OR <=? ,WINNER ,34-PERSONS> <=? ,PRSO ,34-PERSONS>>
        <COND   (<OR <VERB? HELLO> <=? ,PRSI ,HELLO>> <TELL ,MESSAGE-117 CR> <RTRUE>)
                (<=? ,WINNER ,34-PERSONS> <TELL "You are plainly ignored." CR> <RTRUE>)>
    )>
    <COND (<AND <VERB? BRRRODVEJ> <=? ,11-CURRENT-SPELL 42>>
        <TELL ,MESSAGE-059 CR>
        <MOVE ,34-PERSONS ,LOCAL-GLOBALS>
        <MOVE ,35-COMPANY ,HERE>
        <SETG ,11-CURRENT-SPELL 0>
        <RTRUE>
    )>
>

;"Object: COMPANY -------------------------------------------------------------"
<OBJECT 35-COMPANY
	(IN LOCAL-GLOBALS)
	(SYNONYM PERSONS)
	(DESC "company of persons from different adventure games")
    (ACTION COMPANY-F)
    (FLAGS PERSONBIT)>

<ROUTINE COMPANY-F ()
    <COND (<VERB? EXAMINE>
        <COND (,17-COMPANY-FLAG
            <TELL ,MESSAGE-038 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-037 CR>
            <RTRUE>
        )>
    )>
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
            <TELL ,MESSAGE-112 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
    )>
    <COND (<VERB? TELL> <SETG ,WINNER ,PRSO> <RTRUE>)>
    <COND (<OR <=? ,WINNER ,35-COMPANY> <=? ,PRSO ,35-COMPANY>>
        <COND   (<OR <VERB? HELLO> <=? ,PRSI ,HELLO>> <TELL ,MESSAGE-117 CR> <RTRUE>)
                (<=? ,WINNER ,35-COMPANY> <TELL "You are plainly ignored." CR> <RTRUE>)>
    )>
>

;"Object: UNCONSCIOUS PERSONS -------------------------------------------------"
<OBJECT 36-UNCONSCIOUS-PERSONS
	(IN LOCAL-GLOBALS)
	(SYNONYM PERSONS PERSONALITIES)
    (ADJECTIVE UNCONSCIOUS ADVENTURE GAME)
	(DESC "heap of unconscious adventure game personalities")
    (TEXT ,MESSAGE-039)
    (ACTION UNCONSCIOUS-PERSONS-F)>

<ROUTINE UNCONSCIOUS-PERSONS-F ()
    <COND (<AND <VERB? WORTA> <=? ,11-CURRENT-SPELL 45>>
            <TELL ,MESSAGE-112 CR>
            <SETG ,11-CURRENT-SPELL 0>
            <RTRUE>
    )>
>

;"Object: MOULDY BOOK ---------------------------------------------------------"
<OBJECT 37-MOULDY-BOOK
	(IN 21-LIBRARY)
	(SYNONYM BOOK)
    (ADJECTIVE MOULDY)
	(DESC "mouldy book")
    (TEXT ,MESSAGE-043)
    (FLAGS TAKEBIT READBIT)>

;"Object: SPELL BOOK ---------------------------------------------------------"
<OBJECT 38-SPELL-BOOK
	(IN PLAYER)
	(SYNONYM BOOK)
    (ADJECTIVE SPELL)
	(DESC "spell book")
    (TEXT ,MESSAGE-044)
    (ACTION SPELL-BOOK-F)
    (FLAGS TAKEBIT READBIT CONTBIT OPENBIT)>

<ROUTINE SPELL-BOOK-F ()
    <COND (<VERB? DROP> <TELL ,MESSAGE-004 CR> <RTRUE>)>
>

;"Object: XEROX ---------------------------------------------------------------"
<OBJECT 40-XEROX-SPELL
	(IN 38-SPELL-BOOK) 
	(SYNONYM SPELL)
    (ADJECTIVE XEROX)
	(DESC "The xerox spell (copy a spell into the spell book)")
    (ACTION XEROX-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE XEROX-F ()
    <COND (<VERB? CAST>
        <PERFORM V?XEROX ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-007 CR>
        <RTRUE>    
    )>
>

;"Object: BRENWYN -------------------------------------------------------------"
<OBJECT 41-BRENWYN-SPELL
	(IN LOCAL-GLOBALS) 
	(SYNONYM SPELL)
    (ADJECTIVE BRENWYN)
	(DESC "The brenwyn spell (remove alcoholic intoxication)")
    (ACTION BRENWYN-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE BRENWYN-F ()
    <COND (<VERB? CAST>
        <PERFORM V?BRENWYN ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-006 CR>
        <SETG ,11-CURRENT-SPELL 41>
        <RTRUE>
    )>
>

;"Object: BRRRODVEJ -----------------------------------------------------------"
    <OBJECT 42-BRRRODVEJ-SPELL
	(IN LOCAL-GLOBALS) 
	(SYNONYM SPELL)
    (ADJECTIVE BRRRODVEJ)
	(DESC "The brrrodvej spell (animate stage-craft)")
    (ACTION BRRRODVEJ-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE BRRRODVEJ-F ()
    <COND (<VERB? CAST>
        <PERFORM V?BRRRODVEJ ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-006 CR>
        <SETG ,11-CURRENT-SPELL 42>
        <RTRUE>
    )>
>

;"Object: REPHLEX -------------------------------------------------------------"
    <OBJECT 43-REPHLEX-SPELL
	(IN LOCAL-GLOBALS) 
	(SYNONYM SPELL)
    (ADJECTIVE REPHLEX)
	(DESC "The rephlex spell (create a self-destroying mirror)")
    (ACTION REPHLEX-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE REPHLEX-F ()
    <COND (<VERB? CAST>
        <PERFORM V?REPHLEX ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-006 CR>
        <SETG ,11-CURRENT-SPELL 43>
        <RTRUE>
    )>
>

;"Object: REVHOL --------------------------------------------------------------"
    <OBJECT 44-REVHOL-SPELL
	(IN LOCAL-GLOBALS) 
	(SYNONYM SPELL)
    (ADJECTIVE REVHOL)
	(DESC "The revhol spell (turn an amphibian into a fairie prince)")
    (ACTION REVHOL-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE REVHOL-F ()
    <COND (<VERB? CAST>
        <PERFORM V?REVHOL ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-006 CR>
        <SETG ,11-CURRENT-SPELL 44>
        <RTRUE>
    )>
>

;"Object: WORTA ---------------------------------------------------------------"
    <OBJECT 45-WORTA-SPELL
	(IN 38-SPELL-BOOK) 
	(SYNONYM SPELL)
    (ADJECTIVE WORTA)
	(DESC "The worta spell (put an ugly wart on the victim's nose)")
    (ACTION WORTA-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE WORTA-F ()
    <COND (<VERB? CAST>
        <PERFORM V?WORTA ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-006 CR>
        <SETG ,11-CURRENT-SPELL 45>
        <RTRUE>
    )>
>

;"Object: TUBORG --------------------------------------------------------------"
<OBJECT 46-TUBORG-SPELL
	(IN LOCAL-GLOBALS) 
	(SYNONYM SPELL)
    (ADJECTIVE TUBORG)
	(DESC "The tuborg spell (summon a rock fan from a rock club in Copenhagen)")
    (ACTION TUBORG-F)
    (FLAGS READBIT NARTICLEBIT SPELLBIT)>

<ROUTINE TUBORG-F ()
    <COND (<VERB? CAST>
        <PERFORM V?TUBORG ,PRSI>
        <RTRUE>
    )>
    <COND (<VERB? LEARN>
        <TELL ,MESSAGE-006 CR>
        <SETG ,11-CURRENT-SPELL 46>
        <RTRUE>
    )>
>

;"Object: SMALL HOLE ----------------------------------------------------------"
    <OBJECT 47-SMALL-HOLE
	(IN 31-SMALL-ROOM) 
	(SYNONYM HOLE)
    (ADJECTIVE SMALL)
	(DESC "small hole in the brick wall")
    (TEXT ,MESSAGE-070)>

;"Object: WART ----------------------------------------------------------------"
    <OBJECT 48-WART
	(IN LOCAL-GLOBALS) 
	(SYNONYM WART)
    (ADJECTIVE UGLY)
	(DESC "ugly wart (on your nose)")
    (ACTION WART-F)
    (FLAGS VOWELBIT)>

<ROUTINE WART-F ()
    <COND (<VERB? DROP> <TELL ,SYSMESSAGE-008 CR> <RTRUE>)>
>

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

<ROUTINE WELL-EXIT ()
    <COND   (<=? <LOC ,25-WELL> ,HERE> <RETURN ,40-WELL-BOTTOM>)
            (<=? ,HERE ,20-BARE-TOWER-ROOM> <RETURN ,19-NW-TOWER-BASE>)
            (<=? ,HERE ,22-EW-CORRIDOR> <RETURN ,23-DUNGEON-OF-DESPAIR>)
            (<=? ,HERE ,27-JEFF-MINTERS-ROOM> <RETURN ,26-NE-TOWER-BASE>)
            (<=? ,HERE ,39-SW-TOWER> <RETURN ,38-SW-TOWER-BASE>)
            (<=? ,HERE ,61-MINTER-ROOM> <RETURN ,26-NE-TOWER-BASE>)
            (<=? ,HERE ,34-BEDROOM> <RETURN ,33-SE-TOWER-BASE>)
            (T <TELL ,SYSMESSAGE-007 CR> <RFALSE>)
    >
>

;"-----------------------------------------------------------------------------
; INTERRUPTIONS
; -----------------------------------------------------------------------------"

<ROUTINE I-EVERY-TURN ()

    ;"Rock Fan"
    <COND (<AND ,19-SOBER-FAN-FLAG <NOT <=? <LOC ,13-ROCK-FAN> ,HERE>>> 
        <TELL CR,MESSAGE-067 CR>
        <MOVE ,13-ROCK-FAN ,HERE>
        <RTRUE>
    )>

    ;"Well interruptions"
    <COND (<AND <L=? <RANDOM 100> 2> <=? ,HERE ,40-WELL-BOTTOM>>
        <TELL CR ,MESSAGE-098 CR>
        <RTRUE>
    )>

    ;"Company"
    <COND (<AND ,17-COMPANY-FLAG <NOT <=? <LOC ,35-COMPANY> ,HERE>>> 
        <TELL CR,MESSAGE-064 CR>
        <MOVE ,35-COMPANY ,HERE>
        <RTRUE>
    )>

    ;"Piggy Bank"
    <COND (<AND <=? <LOC ,07-INFERNAL-MACHINE> ,HERE> <=? <LOC ,02-PIGGY-BANK> ,HERE> <NOT <HELD? ,02-PIGGY-BANK>>> 
        <TELL CR,MESSAGE-080 CR>
        <MOVE ,02-PIGGY-BANK ,LOCAL-GLOBALS>
        <MOVE ,08-COIN ,HERE>
        <COND (<NOT ,SCORE-GET-COIN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-COIN-FLAG T>)>
        <RTRUE>
    )>

>

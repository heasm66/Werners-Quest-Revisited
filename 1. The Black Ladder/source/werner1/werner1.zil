"Werner's Quest, Revisited - 1. The Black Ladder main file"

;"Release  1 20191014: First attempt.
           2 20191129: INFO ==> ABOUT, MODERN/CLASSIC
                       Compile to .z5 (XZIP). This is default for Inform and therefore the most tested format.
           3 20191213: InvisiClues & reorganize extensions.
           4 20191219: Spelling.
           5 20200108: Bugs
           6 20200109: Hints to lowercase
"

<VERSION XZIP>
<CONSTANT RELEASEID 6>

<SETG EXTRA-FLAGS
    (
    MAZEBIT                 ;"Room is part of maze" 
    NDUNGEONBIT             ;"Room is NOT part of Dungeon"
    )>

"Main loop"

<CONSTANT GAME-BANNER
"|
Werner's Quest, Revisited - 1. The Black Ladder|
Original Quill game by Jan Åberg, 1985, 1986|
Source extracted from C64-version with Unquill v0.11 and converted to ZIL by Henrik Åsman, 2019|
Type 'ABOUT' for more details about this version.">

<ROUTINE GO () 
    <CRLF>
    <INIT-STATUS-LINE>
    <V-VERSION> <CRLF>
    <PUTP PLAYER ,P?CAPACITY 50>            ;"Default SIZE of objects is 5. This limits the inventory to 10 objects." 
    <SETG HERE ,00-OUTSIDE-HOUSE>
    <MOVE ,PLAYER ,HERE>
    <QUEUE I-EVERY-TURN -1>
    <QUEUE I-DRAGON -1>
    <V-LOOK>
    <MAIN-LOOP>>

;"-----------------------------------------------------------------------------"
;" ZILF Library and extensions"
;"-----------------------------------------------------------------------------"

<INSERT-FILE "zillib/parser">
<INSERT-FILE "extensions/parser-extension">
<INSERT-FILE "extensions/verbs-extension">
<INSERT-FILE "hints">

;"Flags"

<GLOBAL 11-FRONT-DOOR-FLAG <>>
<GLOBAL 12-LIGHT-FLAG <>>
<GLOBAL 13-SKELETON-FLAG <>>
<GLOBAL 14-NEST-FLAG <>>
<GLOBAL 15-KEY-FLAG <>>
<GLOBAL 16-DESK-FLAG <>>
<GLOBAL 17-DRAGON-COUNTER 0>
<GLOBAL 18-RAMBO-FLAG <>>
<GLOBAL 19-DUCK-FLAG <>>
<GLOBAL 20-BAKERY-DOOR-FLAG <>>
<GLOBAL 21-COIN-UNDER-TABLE-FLAG <>>
<GLOBAL 22-THING-FISH-STAGE-COUNTER 0>
<GLOBAL 23-THING-FISH-FLAG <>>
<GLOBAL 24-MIDGET-FLAG <>>
<GLOBAL 25-WIZARD-FLAG <>>
<GLOBAL 26-SPACE-TRAVELLER-FLAG <>>
<GLOBAL 27-TEA-FLAG <>>
<GLOBAL 28-EVIL-PRINCE-COUNTER 0>

<GLOBAL TICKET-PAID-FLAG <>>
<GLOBAL TROLL-COUNTER 0>
<GLOBAL HIT-COUNTER 0>
<GLOBAL SPECTACLES-COUNTER 0>

<GLOBAL SCORE-ENTER-DUNGEON-FLAG <>>
<GLOBAL SCORE-GET-PASTRY-FLAG <>>
<GLOBAL SCORE-GET-TEA-FLAG <>>
<GLOBAL SCORE-KILL-DRAGON-FLAG <>>
<GLOBAL SCORE-KILL-PRINCE-FLAG <>>
<GLOBAL SCORE-ENTER-LAWN-FLAG <>>
<GLOBAL SCORE-ENTER-HOUSE-FLAG <>>
<GLOBAL SCORE-ESCAPE-MAZE-FLAG <>>
<GLOBAL SCORE-ENTER-LAB-MO-TORIUM-FLAG <>>
<GLOBAL SCORE-GET-LADDER-FLAG <>>

;"Messages"

<CONSTANT MESSAGE-000 "You see nothing special.">
<CONSTANT MESSAGE-001 "The door has no handle on the outside.">
<CONSTANT MESSAGE-002 "A knocking sound is heard. From inside the house, a voice grumbles: \"CAN'T YOU READ, HALFWIT? USE THE DOOR BELL!\".">
<CONSTANT MESSAGE-003 "A ringing sound is heard. The door slowly creaks open.">
<CONSTANT MESSAGE-004 "|Gandalf appears.|Gandalf takes the curious map.|Gandalf says \"What's this?\".|Gandalf leaves.">
<CONSTANT MESSAGE-005 "The examination reveals that the skeleton consists of 206 bones and is clutching at a curious map.">
<CONSTANT MESSAGE-006 "The nest contains an over-sized chrome spoon and a shiny coin.">
<CONSTANT MESSAGE-007 "The animals are of different sizes, all are furry, and some of them are consuming other ones.">
<CONSTANT MESSAGE-008 "The sign reads:|\"Werner's Dungeon - Open 9 to 5 - Visit the Maze - See the two famous Danish pastry cooks - Entrance: One shiny coin.\". It also has an arrow pointing down.">
<CONSTANT MESSAGE-009 "The neon-lit sign shows the structure of the dungeon. An arrow pointing to the lobby is marked \"U R HERE!\". According to the sign, the office is east, the maze west, the toilet north and the main dungeon south.">
<CONSTANT MESSAGE-010 "The piece of cloth has a little red clip tied to it.">
<CONSTANT MESSAGE-011 "The clip is securely fastened to the piece of cloth.">
<CONSTANT MESSAGE-012 "It's a 0.038 Zorkmid coin.">
<CONSTANT MESSAGE-013 "It's a vending machine designed to dispense tickets.">
<CONSTANT MESSAGE-014 "The disguise is meant to be worn, to make you look like a china man.">
<CONSTANT MESSAGE-015 "The machine dispenses a pink ticket.">
<CONSTANT MESSAGE-016 "The troll waves his axe in your direction, implying that you must show a ticket to enter the dungeon.">
<CONSTANT MESSAGE-017 "The troll takes the ticket, hands you a brochure and shows you down the stairs.">
<CONSTANT MESSAGE-018 "The troll is huge, evil-looking and certainly alive. His axe appears well-sharpened.">
<CONSTANT MESSAGE-019 "The brochure contains some whimsical information about the features of the dungeon, and the number to Werner's Maze Service, which is 0832 146 93.">
<CONSTANT MESSAGE-020 "Nothing happens.">
<CONSTANT MESSAGE-021 "The door is already open.">
<CONSTANT MESSAGE-022 "The door is already closed.">
<CONSTANT MESSAGE-023 "You go through the trap door. It is dark. you notice that your head has been cleaved by a large axe.">
<CONSTANT MESSAGE-024 "Nobody opens the door.">
<CONSTANT MESSAGE-025 "The door is closed.">
<CONSTANT MESSAGE-026 "The door is open.">
<CONSTANT MESSAGE-027 "As you search the sofas, you find a small curious key.||Thorin enters.|Thorin says \"Good, there it is. Almost thought I lost it.\".|Thorin takes the curious key.|Thorin leaves.">
<CONSTANT MESSAGE-028 "In the desk you find a Danish bakery access card.">
<CONSTANT MESSAGE-029 "The map is very curious indeed, with a large number of red circles and lines.">
<CONSTANT MESSAGE-030 "As you raise your hand to strike, the troll appears. Remarking \"PLEASE DO NOT DAMAGE THE INVENTORY!\" he parts your head from your torso with one mighty blow of his large axe.">
<CONSTANT MESSAGE-031 "Aah! That was a nice drink.">
<CONSTANT MESSAGE-032 "Oh dear! The dragon seems to have noticed you.">
<CONSTANT MESSAGE-033 "The dragon follows you.">
<CONSTANT MESSAGE-034 "The dragon is getting closer...">
<CONSTANT MESSAGE-035 "The dragon opens its fangs...">
<CONSTANT MESSAGE-036 "The dragon toasts you.">
<CONSTANT MESSAGE-037 "Time passes...">
<CONSTANT MESSAGE-038 "Rambo seems to notice you. He grabs a machine gun.">
<CONSTANT MESSAGE-039 "Shouting \"EAT LEAD, YOU LOUSY RED!\" Rambo perforates your person with bullets.">
<CONSTANT MESSAGE-040 "Rambo fires. The bullets whine above your head. You get up. Rambo butts his head against the wall, sobbing: \"I missed! I missed a COMMIE! Oh, what a burden!\". He draws a large bowie knife and inserts it in his ribs. The dead Rambo falls down a hole and disappears.">
<CONSTANT MESSAGE-041 "Rambo fires. The bullets whine above your head and hit the dragon, who falls down a hole and disappears. You get up. Rambo looks confused at first, then he continues to point at you with his machine gun.">
<CONSTANT MESSAGE-042 "Rambo eyes you suspiciously, but lowers the machine gun.">
<CONSTANT MESSAGE-043 "Why bother?">
<CONSTANT MESSAGE-044 "Under the table you find a shiny coin.">
<CONSTANT MESSAGE-045 "The bargnome hands you a drink.">
<CONSTANT MESSAGE-046 "Preben says: \"HAER DU SAA SETT, PREBEN? DEN LILLE MAND GER OSS SAA EN LILLE EN!\"|Preben replies: \"JA DAE G0R HAN DU! HVI MAA GIVE HAM ETT WIENERBR0D!\"|Preben says: \"DAE G0R VI SAA, PREBEN!|MAE CHOKOLAEDE I MIDDEN!\"|Preben & Preben take the drink and give you a Danish pastry.">
<CONSTANT MESSAGE-047 "Preben remarks to you: \"R0R SAA ICKE VAAR ALKOHOL, DU LILLE MAND!\"|You decide not to touch the bottles.">
<CONSTANT MESSAGE-048 "|Preben says: \"NU BEGYNDER HVI SAA OG BAEGE!\"|Preben replies: \"MEN F0RST SKAE HVI HAE OSS EN LILLE EN!\"|Preben says: \"JA DAE SKAE HVI DU!\"|Preben & Preben consume some alcohol from one of the bottles.|Preben remarks: \"IH! HVAER DEN DEJLIG!\"">
<CONSTANT MESSAGE-049 "|Preben begins to roll the dough.|Preben asks: \"HVAD AER DET SAA DU G0R?\"|Preben replies: \"JEG PR0VLER!\"|Preben remarks: \"PR0VLER DU?\"|Preben says: \"JA DET G0R JEG DU! DET AERETT TONGT ARBEID! HVI MAA HAE EN LILLE EN!\"|Preben & Preben drink some alcohol.|Preben says: \"IH! DEN HVAER DEJLIG DU!\"">
<CONSTANT MESSAGE-050 "|Preben points to the dough, saying: \"HAER HAR JEG DEGEN!\"|He taps the dough, and an enormous cloud of flour fills the bakery.">
<CONSTANT MESSAGE-051 "|Preben takes one of the numerous bottles and says: \"HAER HAR JEG EN BAYER!\"|Preben remarks: \"DEN SER VAERKELIGEN DEJLIG UD, DU!\"|Preben says: \"DEN SKA HVI DRICKE SENARE DU!\"|Preben replies: \"DET SKA HVI G0RE DU, OG FR0JDE OSS RIGTIGT, MAE PILLEDE REJER OG R0EGR0DMAEFL0E, OG DAEMER, DAEMER, PREBEN, OG DET BLIR VAERKELIGEN DEJLIGT!\"">
<CONSTANT MESSAGE-052 "|Preben says: \"NU SKA HVI BAEGE WIENER- BR0D!\"|Preben remarks: \"NAEJ!\"|Preben asks: \"SKA HVI SAA ICKE BAEGE WIENERBR0D!\"|Preben replies: \"JO, MEN F0RST SKA VI HAE OSS EN LILLE EN!\"|Preben & Preben take a drink from one of the bottles.|Preben says: \"IH! DEN HVAER DEJLIG DU!\"">
<CONSTANT MESSAGE-053 "The door slides open.">
<CONSTANT MESSAGE-054 "The pastry is a Danish cookie with chocolate in the middle.">
<CONSTANT MESSAGE-055 "He is armed and most probably dangerous.">
<CONSTANT MESSAGE-056 "The two Danish bakers have red noses, big moustaches, and are covered with flour.">
<CONSTANT MESSAGE-057 "The dragon looks just like an ordinary, fire-breathing dragon.">
<CONSTANT MESSAGE-058 "The door slides shut behind you.">
<CONSTANT MESSAGE-059 "That was a very tasty Danish pastry.">
<CONSTANT MESSAGE-060 "You have no money.">
<CONSTANT MESSAGE-061 "The dragon blocks your path.">
<CONSTANT MESSAGE-062 "Ford Prefect walks by, saying \"Hello there, you don't have a babel fish in your ear. Here, take this one.\". He sticks a fish in your ear, takes a small device out of his satchel and disappears into thin air.">
<CONSTANT MESSAGE-063 "You take the fish out of your ear and throw it to the ground, where it falls down a hole and disappears.">
<CONSTANT MESSAGE-064 "|Preben says: \"LET'S NOW BEGIN TO BAKE!\"|Preben replies: \"BUT FIRST, WE MUST HAVE A LITTLE ONE!\"|Preben says: \"YES, INDEED WE SHALL!\"|Preben & Preben consume some alcohol from one of the bottles.|Preben remarks: \"IH! WAS THAT A NICE ONE!\"">
<CONSTANT MESSAGE-065 "|Preben begins to roll the dough.|Preben asks: \"WHAT ARE YOU DOING?\"|Preben replies: \"I'M ROLLING!\"|Preben remarks: \"ARE YOU ROLLING?\"|Preben says: \"YES I SURE AM. IT'S HARD  WORK! WE MUST HAVE A LITTLE ONE!\"|Preben & Preben drink some alcohol.|Preben says: \"IH! THAT SURE WAS A NICE ONE!\"">
<CONSTANT MESSAGE-066 "|Preben points to the dough, saying: \"HERE I HAVE THE DOUGH!\"|He taps the dough, and an enormous cloud of flour fills the bakery.">
<CONSTANT MESSAGE-067 "|Preben takes one of the numerous bottles and says: \"HERE I HAVE A BAYER!\"|Preben remarks: \"IT SURE LOOKS NICE!\"|Preben says: \"WE SURE WILL DRINK IT LATER!\"|Preben replies: \"WE SURE WILL, AND ENJOY OURSELVES REALLY MUCH, WITH PICKED PRAWNS AND R0EGR0DMAEFL0DE (not even the babel fish can translate that), AND LADIES, LADIES, PREBEN, AND THAT SURE IS GOING TO BE NICE!\"">
<CONSTANT MESSAGE-068 "|Preben says: \"NOW WE ARE GOING TO BAKE DANISH PASTRY!\"|Preben remarks: \"NO!\"|Preben asks: \"WE ARE NOT GOING TO BAKE DANISH PASTRY?\"|Preben replies: \"YES, BUT FIRST WE MUST HAVE A LITTLE ONE!\"|Preben & Preben take a drink from one of the bottles.">
<CONSTANT MESSAGE-069 "Preben says: \"PREBEN, LOOK AT THAT LITTLE MAN! HE GIVES US A LITTLE ONE!\"|Preben replies: \"YES HE SURE DOES. WE MUST GIVE HIM DANISH PASTRY!\"|Preben remarks: \"YES WE SURE MUST, WITH CHOCOLATE IN THE MIDDLE!\"|Preben & Preben take the drink and give you a Danish pastry.">
<CONSTANT MESSAGE-070 "Preben says: \"LITTLE MAN, DON'T YOU TOUCH OUR ALCOHOL!\"|You decide not to touch the bottles.">
<CONSTANT MESSAGE-071 "Rambo replies: \"Hello.\"">
<CONSTANT MESSAGE-072 "Rambo looks confused and says: \"I dinn'tunnerstan' ya man. Say't 'gin, 'an say'tslowly, w'dya.\"">
<CONSTANT MESSAGE-073 "They don't seem to notice you.">
<CONSTANT MESSAGE-074 "The troll gives you a strange look and says: \"Are ya here to chat or to visit the dungeon?\"">
<CONSTANT MESSAGE-075 "A dungeon tourist imformation person carrying a familiar brochure walks up to you, gives the brochure to you and says: \"Here, I found this and thought you had perhaps dropped it by mistake. |No, no, don't thank me, it was nothing really. Have a nice day.\".|Then he departs.">
<CONSTANT MESSAGE-076 "A dungeon tourist information person carrying a familiar brochure walks up to you and says: \"Have you received...|Oh, I see you have. Have a nice day.\".|He departs.">
<CONSTANT MESSAGE-077 "\"Eep... Eep... Werner's Maze Service... Right... Be sendin' someone right over... Have a nice day.\"||After a while (three hours) PacMan (No. 1 authority in maze questions) appears, saying \"Er... Sorry I'm late, but I had some really dead guys to deal with...|Just follow me.\"||You follow PacMan through the maze and finally you find that...">
<CONSTANT MESSAGE-078 "\"Hello, this is Werner's Maze Service. Unfortunately nobody is in at the moment, but if you leave a message we will help you within a few decades. Please speak before you hear the tone.\"||After a few milliseconds you hear an Eep and a click.">
<CONSTANT MESSAGE-079 "All you get is a busy signal.">
<CONSTANT MESSAGE-080 "It is a full-size replica of a sinister-looking janitor midget carrying a bucket and a mop, who is wearing spectacles (the midget, not the mop).">
<CONSTANT MESSAGE-081 "The Thing-Fish looks amazed as you enter.">
<CONSTANT MESSAGE-082 "The Thing-Fish says: \"How many of you folks thinks I knows what I's talkin' 'bouts? Raise yo' hains up!\"">
<CONSTANT MESSAGE-083 "The Thing-Fish says: \"Uh-huh! An' how many thinks my potato been bakin' too long? Raise yo' mizzabel hains up!\"">
<CONSTANT MESSAGE-084 "The Thing-Fish says: \"Ain't you de clevuh one! Thru de magic o' stage-kraffwe'll now move on to de Evil Prince's Lab-Mo-Torium!\". He pulls a concealed lever, the walls turn and suddenly...">
<CONSTANT MESSAGE-085 "The Thing-Fish, gesticulating wildly, says: \"UH-HUH!\". He pulls a concealed lever, and a trap door opens below you.|You fall 30 feet and land in an enormous vat of Galoot Cologne, in which you drown.">
<CONSTANT MESSAGE-086 "The Thing-Fish says: \"I see y'all hasn't got de catch on dis hain-raisin bidniz. Let's get rollin' 'gin. When I ask ya a questium, ya raise yo mizzabel hain up if ya ergree, an' ya don't if ya dis-ergree. Got it?\"">
<CONSTANT MESSAGE-087 "The goblin won't let you enter the theatre without a ticket.">
<CONSTANT MESSAGE-088 "The Thing-Fish has a head like a potato, lips like a duck, checkered skirt, big white gloves and a napkin.">
<CONSTANT MESSAGE-089 "The Thing-Fish points at The Evil Prince and says: \"Dat nasty sucker ovuh deaah is respondabul fo' de potium dat made me looks like dis...\". He points at his person, which is equipped with a potato-head, ducklips, skirt, gloves and napkin. \"Dis heaah nakkin...\" he says, pointing at the napkin, \"...be achilly growim outa my body, an' I can only speak diuhlectal an' grammaticly uncorrect, an' dat individj'l fiddlim wit de pipe is respobdabul! He am a prince, a evil prince an' part-time theatritical critizizumuh! Thru de magico' stage-kraff, we be abul to see him at woik! Now, if you, by some reasum, shudd happen to be sorta... erasim de sucker fum de soifass o' de urf, nobody cudd be more grateful den I. If you shudd happen to suxeed, you sho'nuff is welcome to drop in at de cardboard bungalow on Francesco's front lawn fo' sum mash potatoes!\"">
<CONSTANT MESSAGE-090 "He points to the vat and says: \"Dat vat ovuh deaah contains potiumed Galoot Colognum. Don't go near it.\"|He disappears in a puff of stage-craft.">
<CONSTANT MESSAGE-091 "The midget fends you off with his mop.">
<CONSTANT MESSAGE-092 "A midget appears in the doorway brandishing a mop with which he fends you off.">
<CONSTANT MESSAGE-093 "The midget snatches the spectacles away from you and puts them on.">
<CONSTANT MESSAGE-094 "The midget, mistaking the statuette for a colleague, starts to converse with it about Cliff Richard's latest album.">
<CONSTANT MESSAGE-095 "The midget, not wanting his conversation interrupted, fends you off with his mop.">
<CONSTANT MESSAGE-096 "The midget absent-mindedly takes the spectacles and puts them on. Suddenly, he realizes that he is talking to a statuette, and ends the conversation.">
<CONSTANT MESSAGE-097 "The Thing-Fish, a sinister-looking being with potato-head, duck-lips, skirt, large white gloves and a napkin, enters the room saying \"Boy! What ya doim wit de dunyum theatre technocraticazatiumal equippnint? Don't ya evuh tuch dat buttum 'gin!\". He leaves, murmuring things about \"De prolibromatizatiumed yoot of today.\"">
<CONSTANT MESSAGE-098 "You can't see much, and walk into something hard.">
<CONSTANT MESSAGE-099 "On the other side of the mirror, a wizard enters the room. His hair and beard are unkempt, and he is wearing a dirty old robe and a silly, pointed hat with stars and moons on it. He is carrying two books, some mouldy bread, a jug and a worn silver spoon. When he notices you, a glimpse of hope lights up his eyes. He opens one of his books and recites a spell of some sort.|Nothing happens.|Chewing his hat, he leaves in despair.">
<CONSTANT MESSAGE-100 "On the other side of the mirror, a some-what unkempt wizard enters the room.|Seeing you, he begins to recite a spell. Suddenly...">
<CONSTANT MESSAGE-101 "The wizard jumps up and down with excitement.">
<CONSTANT MESSAGE-102 "The wizard rushes through the plain wooden door and comes back after a few minutes, carrying a purple scroll, a pencil and an adventure game map.|Suddenly, one of the walls turn and the Thing-Fish enters, saying \"What ya doim heaah? Y'all be trudgim de wrong 'ventchuh, boy! Bettuh come wit me an', thru de magic o' stage-kraff, re-entuh de familiuh ol' dunyum 'gin!\".|The walls turn and... ">
<CONSTANT MESSAGE-103 "The posters show phlorescent hoods, trendy beardstyles and mithril bikinis, all products of the Theobaldian empire.">
<CONSTANT MESSAGE-104 "It is an issue of Mock Pig Carver's Weekly. The theme this week is the possibility of connecting artificial pigs to gigantic vats of cologne.">
<CONSTANT MESSAGE-105 "|  THE ARTIFICIAL PIG CARVER'S ACADEMY|  -----------------------------------||||||           Mr. Evil Prince||      for excellent knowledge on||           the subject of|||     THE ANATOMY OF CONCRETE PORK|||      signed:|      Quentin R. deNameland|      President">
<CONSTANT MESSAGE-106 "A person wearing a torn and battered space suit enters. He looks you up and down for a few moments. Then he leaves.">
<CONSTANT MESSAGE-107 "A person wearing a torn and battered space suit enters. He says: \"That's a mighty interesting-looking bunch of octagonal rods you got there, boy!\", grabbing the octagonal rods. \"Wow! A red rod! And a blue rod! And even a turquoise one! Thank you so very much!\"|He leaves, whistling merrily and with-out noticing that he drops one of the rods.">
<CONSTANT MESSAGE-108 "You gesticulate wildly with the rod, but there is no effect.">
<CONSTANT MESSAGE-109 "As you begin to gesticulate with the rod a bridge appears to the north. The Thing-Fish appears, obviously impressed,saying \"Wow! Science!\", and leaves.">
<CONSTANT MESSAGE-110 "You can't wave such a large number of rods.">
<CONSTANT MESSAGE-111 "As you wave the rod, the bridge vanishes in a puff of stage-craft.">
<CONSTANT MESSAGE-112 "It bears a small label reading: \"Bridge-About-Bringing Rod. Another trendy product from Theobald Engineering.\"">
<CONSTANT MESSAGE-113 "You enter the sauna. After several seconds, you come out the same person you were when you entered.">
<CONSTANT MESSAGE-114 "The machine dispenses a cup of tea. Seeing this, Arthur's face turns pale green, and he starts to emit guttural sounds.">
<CONSTANT MESSAGE-115 "As you turn the switch, the walls turn and, through the magic of stage-craft, you are moved away from the bridge...">
<CONSTANT MESSAGE-116 "It is dark. Suddenly, the lights come on. You find yourself in a Vogon Warship. A severely ugly Vogon is here. The Vogon removes his disguise, and you discover it is actually the Thing-Fish. He says: \"Boy! What ya be doim heaah? Dis be de uncorrect 'ventchuh! Fotchenatly, we still has dat good ol' stage-kraff!\"|The walls turn, and...">
<CONSTANT MESSAGE-117 "The machine remarks: \"You haven't yet drunk the tea I last gave you.\"">
<CONSTANT MESSAGE-118 "Arthur takes the tea and drinks it thirstily.">
<CONSTANT MESSAGE-119 "Arthur is unshaved and wearing a gown.">
<CONSTANT MESSAGE-120 "Aaaah... That was the best tea you've ever tasted. Through the magic of stage-craft, the cup vanishes.">
<CONSTANT MESSAGE-121 "The Thing-Fish says: \"Shurrup, boy, an' raise yo mizzabel hain up at de approproit moment!\"">
<CONSTANT MESSAGE-122 "You get no reply.">
<CONSTANT MESSAGE-123 "The Black Adder stops you, whispering: \"That ladder is an important piece of my cunning plan to recieve the crown. Don't touch it.\"">
<CONSTANT MESSAGE-124 "The Black Adder says: \"Do not disturb! I am developing my cunning plan!\"">
<CONSTANT MESSAGE-125 "The Black Adder's father, Richard IV, enters. Seeing you, he draws a sword and shouts: \"AAH! A TURK! GET OUT OF MY WAY, EDNA!\". As he rushes towards you, Edmund trips him up. He falls, lands accidentally on his sword and dies. The dead king falls down a hole and disappears. Edmund rushes off, shouting: \"Hothaah! The king is dead! Harry, come here and have a look at my new torture rack!\"">
<CONSTANT MESSAGE-126 "Sir Percy replies: \"Hah! You think you can lure me into telling you the password, don't you? Well, I won't tell you that it's 'MOOSE' anyway! Hah!\"">
<CONSTANT MESSAGE-127 "OK.||The Evil Prince didn't seem to notice you.">
<CONSTANT MESSAGE-128 "The Evil Prince takes the tea saying: \"Thank you.\"">
<CONSTANT MESSAGE-129 "The Evil Prince takes the Danish pastry and says: \"I never eat pastry without tea, but thanks anyway.\"">
<CONSTANT MESSAGE-130 "The Evil Prince takes the Danish pastry,consumes it and drinks the tea. Through the magic of stage-craft, the cup vanishes.">
<CONSTANT MESSAGE-131 "The Evil Prince takes the tea, eats the pastry and drinks the tea. Through the magic of stage-craft, the cup vanishes.">
<CONSTANT MESSAGE-132 "Suddenly, the Evil Prince begins to transform. His heads begins to look like a potato, he sprouts duck lips and a napkin starts to grow out of his body. \"AAAARRGH!\" remarks the Evil Prince, falls into the vat and drowns.">
<CONSTANT MESSAGE-133 "The Danish pastry tastes Galoot Cologne. You notice that you now have potatohead, ducklips, and all other features of the Thing-Fish. The Thing-Fish enters, saying: \"I have no mo' use for ya. I'll throw ya into de cologunuh vat.\"|He does that, and you drown.">
<CONSTANT MESSAGE-134 "The guard says: \"Okay, follow me.\"|You do so, and...">
<CONSTANT MESSAGE-135 "The guard says: \"No, that's not the right password. The right password is...Oops, I shouldn't say that, should I?\"">
<CONSTANT MESSAGE-136 "Miriam, the butcher's second fattest daughter, starts to sing. The tiled stove cracks and catches fire, and one of the peasants jumps up and down shouting: \"AAAARRGH! I HAVE A STITCH!\"|The farmers flee in panic, and so do you. You run through the countryside, and when you stop to catch your breath, you find that...">
<CONSTANT MESSAGE-137 "One of the farmers drags you back, saying: \"Don't leave yet! Don't you want some entertainment, aye?\"">
<CONSTANT MESSAGE-138 "One of the farmers says: \"Well, the crop hasn't been as good as the last one.\"">
<CONSTANT MESSAGE-139 "You enter the cardboard hut. The Thing-Fish is here. He gives you some mashed potatoes and says: \"Good woik boy! Now dat de sucker am dead, life can go back to normal heaah in de Werner dunyum. We'll fire de stupid ticket collectim creetchum, you takes his place as ticket collectuh, an' I will write a theatricazatiumal manuscriptchuh 'bouts dis mess an' den we go to Broadway an' we gwine 'come both rich an' famous!\"||Gandalf enters.|Gandalf gives the curious map to you.|Gandalf whistles.|A large number of hobbits, dwarves, elves, small furry creatures from Alpha Centauri and adventure game players enters. Led by Gandalf they carry you away into the sunset.">
<CONSTANT MESSAGE-140 "Behind you, you can hear the Thing-Fish shouting: \"Hey! Wait! Come back heaah! Ain't ya hoid what I were sayim? Don't ya wanna 'come rich an' famouos? Hah! I sho'nuff don't care! Ya hear me? I canget me 'nothuh ticket collectuh! I can go to Broadway all by myseff, an' be twice so much rich an' famous den I wudd have was if you was wit me! I don't need ya! Just you wait an' see! \"||You have completed the adventure.">
<CONSTANT MESSAGE-141 "The Thing-Fish appears in the doorway. He says: \"What ya doim heaah? Ya sho'nuff not killed de Evil Prince yet!\"">
<CONSTANT MESSAGE-142 "You lean it against the vat.">

<CONSTANT SYSMESSAGE-000 "">
<CONSTANT SYSMESSAGE-001 "You can see:">
<CONSTANT SYSMESSAGE-002 "What next? ">
<CONSTANT SYSMESSAGE-003 "What next? ">
<CONSTANT SYSMESSAGE-004 "What next? ">
<CONSTANT SYSMESSAGE-005 "What next? ">
<CONSTANT SYSMESSAGE-006 "I don't understand you.">
<CONSTANT SYSMESSAGE-007 "You can't go that way.">
<CONSTANT SYSMESSAGE-008 "That's impossible.">
<CONSTANT SYSMESSAGE-009 "You're carrying:">
<CONSTANT SYSMESSAGE-010 "(worn)">
<CONSTANT SYSMESSAGE-011 "Nothing at all.">
<CONSTANT SYSMESSAGE-012 "You don't really mean that, do you?">
<CONSTANT SYSMESSAGE-013 "****  END OF GAME  ****">
<CONSTANT SYSMESSAGE-014 "Who cares?">
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
<CONSTANT SYSMESSAGE-025 "You're already carrying it.">
<CONSTANT SYSMESSAGE-026 "You can't see it here.">
<CONSTANT SYSMESSAGE-027 "Your load is too heavy.">
<CONSTANT SYSMESSAGE-028 "You're not carrying it.">
<CONSTANT SYSMESSAGE-029 "You're already wearing it.">
<CONSTANT SYSMESSAGE-030 "Y">
<CONSTANT SYSMESSAGE-031 "N">
<CONSTANT SYSMESSAGE-032 "Disc or Tape?">
<CONSTANT SYSMESSAGE-033 "Type in filename.">
<CONSTANT SYSMESSAGE-034 "Start the tape.">

<GLOBAL PREBEN-DK
	<LTABLE 
		,MESSAGE-048
		,MESSAGE-049
		,MESSAGE-050
		,MESSAGE-051
		,MESSAGE-052
        "[SKIP]">>

<GLOBAL PREBEN-UK
	<LTABLE
		,MESSAGE-064
		,MESSAGE-065
		,MESSAGE-066
		,MESSAGE-067
		,MESSAGE-068
        "[SKIP]">>

<GLOBAL GAME_VERSION_CLASSIC <>>                    ;"Should the game be played in CLASSIC or NEW mode? (NEW won't kill quite as swift as in CLASSIC mode)"

;"-----------------------------------------------------------------------------
; ROOMS
; -----------------------------------------------------------------------------"

;"Room: OUTSIDE HOUSE ---------------------------------------------------------"
<ROOM 00-OUTSIDE-HOUSE
    (DESC "Outside House")
    (IN ROOMS)
    (LDESC 
"You are standing beside a rotting old house equipped with a front door. Next to the front door is a button and a sign
reading \"PLEASE USE THE DOOR BELL!\". All around you is the forest, probably inhabited by creatures yet only described in
adventure games.")
    (NORTH TO 03-FOREST)
    (SOUTH TO 05-FOREST)
    (WEST TO 04-FOREST)
    (EAST TO 03-FOREST)
    (IN TO 08-INSIDE-HOUSE IF 11-FRONT-DOOR-FLAG ELSE ,MESSAGE-025)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (<>) (BUTTON BELL DOORBELL) DOORBELL-F
            (ROTTING OLD) (HOUSE) HOUSE-F
            (<>) (SIGN FOREST KEYHOLE HANDLE KNOB) STANDARD-F)
    (GLOBAL FRONT-DOOR)>

<ROUTINE HOUSE-F ()
    <COND (<VERB? WALK ENTER>
        <DO-WALK P?IN>
        <RTRUE>)
    >
    <STANDARD-F>
>

<ROUTINE DOORBELL-F ()
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-002 CR>)
    >
>

;"Room: FOREST with cloth and clip --------------------------------------------"
<ROOM 01-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest and very lost. Hanging in a bush is a piece of red and white cloth with the number \"43\"
written on it.")
    (NORTH TO 02-FOREST)
    (SOUTH TO 02-FOREST)
    (WEST TO 06-FOREST)
    (EAST TO 00-OUTSIDE-HOUSE)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (RED WHITE) (CLOTH) CLOTH-F
            (RED) (CLIP) CLIP-F
            (<>) (FOREST BUSH) STANDARD-F)>

<ROUTINE CLOTH-F ()
    <COND (<VERB? EXAMINE> 
        <TELL ,MESSAGE-010 CR>
        <RTRUE>)
    >
>

<ROUTINE CLIP-F ()
    <COND (<VERB? EXAMINE TAKE> 
        <TELL ,MESSAGE-011 CR>
        <RTRUE>)
    >
>

;"Room: FOREST ----------------------------------------------------------------"
<ROOM 02-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are still wandering around aimlessly in the forest, utterly lost.")
    (NORTH TO 01-FOREST)
    (SOUTH TO 02-FOREST)
    (WEST TO 02-FOREST)
    (EAST TO 06-FOREST)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (<>) (FOREST) STANDARD-F)>

<ROOM 03-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest.")
    (NORTH TO 01-FOREST)
    (SOUTH TO 05-FOREST)
    (WEST TO 04-FOREST)
    (EAST TO 02-FOREST)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (<>) (FOREST) STANDARD-F)>

;"Room: FOREST with animals ---------------------------------------------------"
<ROOM 04-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are lost in the forest. You notice small furry animals being eaten by somewhat larger furry animals.")
    (NORTH TO 02-FOREST)
    (SOUTH TO 00-OUTSIDE-HOUSE)
    (WEST TO 04-FOREST)
    (EAST TO 04-FOREST)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (FURRY SMALL LARGE) (ANIMALS ANIMAL) ANIMAL-F
            (<>) (FOREST) STANDARD-F)>

<ROUTINE ANIMAL-F ()
    <COND (<VERB? EXAMINE> 
        <TELL ,MESSAGE-007 CR>
        <RTRUE>)
    >
>

;"Room: FOREST with skeleton --------------------------------------------------"
<ROOM 05-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest. Resting against a tree is a skeleton, probably the remains of a luckless orienteerer.")
    (NORTH TO 01-FOREST)
    (SOUTH TO 04-FOREST)
    (WEST TO 05-FOREST)
    (EAST TO 04-FOREST)
    (ACTION FOREST-SKELETON-F)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (LUCKLESS) (SKELETON ORIENTEERER) SKELETON-F
            (<>) (FOREST) STANDARD-F)>

<ROUTINE FOREST-SKELETON-F (RARG)
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<NOT <=? <LOC ,13-BABELFISH> ,PLAYER>>
            <TELL ,MESSAGE-062 CR>
            <MOVE ,13-BABELFISH ,PLAYER>)
        >)
    >
>

<ROUTINE SKELETON-F ()
    <COND (<VERB? EXAMINE SEARCH> 
        <COND (<NOT ,13-SKELETON-FLAG>
            <TELL ,MESSAGE-005 CR>
            <MOVE ,04-MAP ,HERE>
            <SETG 13-SKELETON-FLAG T>
            <RTRUE>)
        >)
    >
>

;"Room: FOREST with tree ------------------------------------------------------"
<ROOM 06-FOREST
    (DESC "Forest")
    (IN ROOMS)
    (LDESC 
"You are in the forest, standing beside a tree which looks so easy to climb even you could manage it.")
    (NORTH TO 04-FOREST)
    (SOUTH TO 04-FOREST)
    (WEST TO 04-FOREST)
    (EAST TO 04-FOREST)
    (UP TO 07-TREE)
    (ACTION FOREST-TREE-F)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (<>) (FOREST TREE) TREE-F)>


<ROUTINE FOREST-TREE-F ()
     <COND (<AND <VERB? CLIMB> <PRSO? <>>>
        <TELL "[the tree]|">
        <TREE-F>
        <RTRUE>)
    >
>

;"Room: TREE ------------------------------------------------------------------"
<ROOM 07-TREE
    (DESC "Up a Tree")
    (IN ROOMS)
    (LDESC 
"You are sitting somewhat unsteadily in a tree. The sun is shining like a very large star. The forest,
which from here appears to be composed of a large number of trees, stretches to the north as well as the south.
To the east, far away, you can see Bilbo crawling out through the Goblin's Back Door. To the west you can see
Arthur Dent lying in front of a huge yellow bulldozer. Beside you on the branch is a severely ugly nest.")
    (DOWN TO 06-FOREST)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (UGLY) (NEST) NEST-F
            (<>) (FOREST STAR BILBO ARTHUR DENT DOOR BRANCH) STANDARD-F
            (<>) (TREE) TREE-F)>

<ROUTINE NEST-F ()
    <COND (<VERB? EXAMINE> 
        <COND (<NOT ,14-NEST-FLAG>
            <TELL ,MESSAGE-006 CR>
            <MOVE ,01-COIN ,HERE>
            <MOVE ,02-SPOON ,HERE>
            <SETG 14-NEST-FLAG T>
            <RTRUE>)
        >)
    >
>

<ROUTINE TREE-F ()
    <COND (<VERB? CLIMB> 
        <COND (<=? ,HERE ,06-FOREST>
            <DO-WALK P?UP>
            <RTRUE>)
        >)
    >
    <COND (<VERB? DESCEND> 
        <COND (<=? ,HERE ,07-TREE>
            <DO-WALK P?DOWN>
            <RTRUE>)
        >)
    >
>

;"Room: INSIDE HOUSE ----------------------------------------------------------"
<ROOM 08-INSIDE-HOUSE
    (DESC "Inside House")
    (IN ROOMS)
    (LDESC 
"You are standing inside the rotting house. The house is sparsely furnished, in fact not at all. On one wall is
positioned a sign. Beside the sign is a button, and an open trap door is placed in the floor. The exit is west
and there is a walk-in closet in the eastern wall.")
    (EAST TO 09-CLOSET)
    (WEST TO 00-OUTSIDE-HOUSE IF 11-FRONT-DOOR-FLAG ELSE ,MESSAGE-025)
    (DOWN PER TRAP-DOOR-F)
    (ACTION INSIDE-HOUSE-F)
    (FLAGS LIGHTBIT NDUNGEONBIT)
    (THINGS (<>) (BUTTON) LIGHTBUTTON-F
            (<>) (SIGN) HOUSE-SIGN-F
            (<>) (HOUSE TRAPDOOR FLOOR CLOSET KEYHOLE) STANDARD-F)
    (GLOBAL FRONT-DOOR)>

<ROUTINE LIGHTBUTTON-F ()
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-020 CR>
        <COND (,12-LIGHT-FLAG
            <FCLEAR ,10-SMALL-ROOM ,LIGHTBIT>
            <SETG 12-LIGHT-FLAG <>>)
        (T
            <FSET ,10-SMALL-ROOM ,LIGHTBIT>
            <SETG 12-LIGHT-FLAG T>)
        >
        <RTRUE>)
    >
>

<ROUTINE HOUSE-SIGN-F ()
    <COND (<VERB? EXAMINE READ> 
        <TELL ,MESSAGE-008 CR>
        <RTRUE>)
    >
>

<ROUTINE TRAP-DOOR-F ()
    <SETG TROLL-COUNTER 0>
    <COND (,12-LIGHT-FLAG
        <RETURN ,10-SMALL-ROOM>)
    (T
        <COND (,GAME_VERSION_CLASSIC
            <JIGS-UP ,MESSAGE-023>
            <RFALSE>)
        (T
            <RETURN ,10-SMALL-ROOM>
        )>
    )
    >
>

<ROUTINE INSIDE-HOUSE-F ()
    <COND (<NOT ,SCORE-ENTER-HOUSE-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ENTER-HOUSE-FLAG T>)>
>

;"Room: CLOSET ----------------------------------------------------------------"
<ROOM 09-CLOSET
    (DESC "Closet")
    (IN ROOMS)
    (LDESC 
"You are in a walk-in closet. The exit is to the west.")
    (WEST TO 08-INSIDE-HOUSE)
    (FLAGS LIGHTBIT NDUNGEONBIT)>     

;"Room: SMALL ROOM ------------------------------------------------------------"
<ROOM 10-SMALL-ROOM
    (DESC "Small Room")
    (IN ROOMS)
    (LDESC 
"You are in a small room containing a vending machine. Beside the stairway leading down stands a huge troll,
brandishing a large axe. You can also go up through a hole in the ceiling.")
    (UP TO 08-INSIDE-HOUSE)
    (DOWN PER SMALL-ROOM-EXIT)
    (ACTION SMALL-ROOM-F)
    (FLAGS NDUNGEONBIT)
    (THINGS (<>) (AXE HOLE STAIRWAY CEILING) STANDARD-F)>

<ROUTINE SMALL-ROOM-F (RARG)
    <COND (<=? .RARG ,M-END>
        <COND (<G=? ,TROLL-COUNTER 1> <JIGS-UP "|Suddenly you notice that your head has been cleaved by a large axe."> <RFALSE>)>
        <COND (<NOT <FSET? ,HERE ,LIGHTBIT>> <SETG ,TROLL-COUNTER <+ ,TROLL-COUNTER 1>>)>
    )>
>

<ROUTINE SMALL-ROOM-EXIT ()
    <COND (<AND ,TICKET-PAID-FLAG <NOT ,GAME_VERSION_CLASSIC>>
        <RETURN ,11-DUNGEON-LOBBY>
    )
    (T
        <COND (<FSET? ,HERE ,LIGHTBIT>
            <TELL ,MESSAGE-016 CR>
            <RFALSE>
        )
        (T
            <TELL "You can't go that way." CR>
            <RFALSE>
        )>
    )>
>

;"Room: DUNGEON LOBBY ---------------------------------------------------------"
<ROOM 11-DUNGEON-LOBBY
    (DESC "Dungeon Lobby")
    (IN ROOMS)
    (LDESC 
"You are in the dungeon lobby, which is furnished with large plush sofas. One
wall features a neon-lit sign. Doorways lead off in all directions.")
    (UP TO 10-SMALL-ROOM)
    (EAST TO 12-OFFICE)
    (WEST TO 17-MAZE)
    (NORTH TO 21-TOILET)
    (SOUTH TO 22-JUNCTION)
    (ACTION DUNGEON-LOBBY-F)
    (FLAGS LIGHTBIT)
    (THINGS (NEON NEON-LIT LIT) (SIGN) SMALL-ROOM-SIGN-F
            (PLUSH LARGE) (SOFA SOFAS) SOFA-F
            (SMALL CURIOUS) (KEY) STANDARD-F)>

<ROUTINE SMALL-ROOM-SIGN-F ()
    <COND (<VERB? EXAMINE READ> 
        <TELL ,MESSAGE-009 CR>
        <RTRUE>)
    >
>

<ROUTINE SOFA-F ()
    <COND (<VERB? EXAMINE SEARCH> 
        <COND (<NOT ,15-KEY-FLAG>
            <TELL ,MESSAGE-027 CR>
            <SETG 15-KEY-FLAG T>
            <RTRUE>)
        >)
    >
>

<ROUTINE DUNGEON-LOBBY-F (RARG)
    <COND (<NOT ,SCORE-ENTER-DUNGEON-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ENTER-DUNGEON-FLAG T>)>
>

;"Room: OFFICE ----------------------------------------------------------------"
<ROOM 12-OFFICE
    (DESC "Dungeonmaster's office")
    (IN ROOMS)
    (LDESC 
"You are in the Dungeonmaster's office. In the middle of the room stands an enormous mahogany desk, and on the floor
is a thick carpet. The only exit is through a doorway to the west.")
    (WEST TO 11-DUNGEON-LOBBY)
    (FLAGS LIGHTBIT)  
    (THINGS (ENORMOUS MAHOGANY) (DESK) DESK-F
            (THICK) (CARPET) STANDARD-F)>

<ROUTINE DESK-F ()
    <COND (<VERB? EXAMINE SEARCH> 
        <COND (<NOT ,16-DESK-FLAG>
            <TELL ,MESSAGE-028 CR>
            <MOVE ,07-ACCESS-CARD ,HERE>
            <SETG 16-DESK-FLAG T>
            <RTRUE>)
        >)
    >
>

;"Room: MAZE ------------------------------------------------------------------"
<ROOM 13-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 15-MAZE)
    (SOUTH TO 16-MAZE)
    (EAST TO 14-MAZE)
    (WEST TO 15-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>  

<ROOM 14-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 14-MAZE)
    (SOUTH TO 16-MAZE)
    (EAST TO 16-MAZE)
    (WEST TO 15-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>        

<ROOM 15-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 13-MAZE)
    (SOUTH TO 18-MAZE)
    (EAST TO 19-MAZE)
    (WEST TO 13-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>  
      
<ROOM 16-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 15-MAZE)
    (SOUTH TO 17-MAZE)
    (EAST TO 17-MAZE)
    (WEST TO 17-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>  
      
<ROOM 17-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 17-MAZE)
    (SOUTH TO 18-MAZE)
    (EAST TO 13-MAZE)
    (WEST TO 18-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>  
      
<ROOM 18-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 17-MAZE)
    (SOUTH TO 15-MAZE)
    (EAST TO 16-MAZE)
    (WEST TO 15-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>  

<ROOM 19-MAZE
    (DESC "Maze")
    (IN ROOMS)
    (LDESC 
"You are in a maze of passages.")
    (NORTH TO 20-GIFT-SHOP)
    (SOUTH TO 18-MAZE)
    (EAST TO 15-MAZE)
    (WEST TO 14-MAZE)
    (FLAGS LIGHTBIT MAZEBIT)>  
      
;"Room: GIFT SHOP -------------------------------------------------------------"
<ROOM 20-GIFT-SHOP
    (DESC "Deserted Gift Shop")
    (IN ROOMS)
    (LDESC 
"You are in the deserted gift shop of Werner's dungeon. The exit is to the south.")
    (SOUTH TO 19-MAZE)
    (FLAGS LIGHTBIT)>  

;"Room: TOILET ----------------------------------------------------------------"
<ROOM 21-TOILET
    (DESC "Toilet")
    (IN ROOMS)
    (LDESC 
"You are in the toilet of Werner's dungeon. Like all toilets in adventures, it has no interesting features. The exit is to the south.")
    (SOUTH TO 11-DUNGEON-LOBBY)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (TOILET) STANDARD-F)>  

;"Room: JUNCTION --------------------------------------------------------------"
<ROOM 22-JUNCTION
    (DESC "Junction")
    (IN ROOMS)
    (LDESC 
"You are at a junction in the dungeons. Passages lead in all directions.")
    (NORTH TO 11-DUNGEON-LOBBY)
    (WEST TO 31-RAMBO-LAIR)
    (EAST TO 23-VIEWING-ROOM)
    (SOUTH TO 32-PASSAGE)
    (FLAGS LIGHTBIT)>      

;"Room: VIEWING ROOM ----------------------------------------------------------"
<ROOM 23-VIEWING-ROOM
    (DESC "Viewing Room")
    (IN ROOMS)
    (LDESC 
"You are in the Danish bakery viewing room. Through a large window in the northern wall you can see two Danish
pastry cooks baking and consuming large amounts of alcohol. To the east there is a doorway marked \"CREW ONLY!\".
Passages lead south and west.")
    (SOUTH TO 26-TWISTING-PASSAGE)
    (EAST TO 24-BARE-ROOM)
    (WEST TO 22-JUNCTION)
    (FLAGS LIGHTBIT)> 

;"Room: BARE ROOM -------------------------------------------------------------"
<ROOM 24-BARE-ROOM
    (DESC "Bare Room")
    (IN ROOMS)
    (LDESC 
"You are in a bare room. To the north there is a door with a slot beside it. A doorway
to the west leads to the Danish bakery viewing room.")
    (WEST TO 23-VIEWING-ROOM)
    (IN TO 25-BAKERY IF 20-BAKERY-DOOR-FLAG)
    (NORTH TO 25-BAKERY IF 20-BAKERY-DOOR-FLAG)
    (FLAGS LIGHTBIT)
    (GLOBAL BAKERY-DOOR)>

;"Room: BAKERY ----------------------------------------------------------------"
<ROOM 25-BAKERY
    (DESC "Danish Bakery")
    (IN ROOMS)
    (LDESC 
"You are in the Danish bakery. In the southern wall is set a large viewing window through which you
can see the viewing room. The southern wall also features a door. Preben & Preben, the two inebriate
Danish pastry cooks, are here. You notice a large number of bottles positioned near the two Danes.")
    (SOUTH PER BAKERY-EXIT)
    (ACTION BAKERY-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (BOTTLE BOTTLES ALCOHOL) BOTTLE-F)
    (GLOBAL BAKERY-DOOR)>

<ROUTINE BAKERY-EXIT ()
    <TELL ,MESSAGE-058 CR CR>
    <SETG 20-BAKERY-DOOR-FLAG <>>
    <RETURN ,24-BARE-ROOM>
>

<ROUTINE BAKERY-F (RARG "AUX" TEXT)
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<=? <LOC ,13-BABELFISH> ,PLAYER>
            <SET .TEXT <PICK-ONE-R ,PREBEN-UK>>)
        (T
            <SET .TEXT <PICK-ONE-R ,PREBEN-DK>>
        )>
        <COND (<NOT <=? .TEXT "[SKIP]">> <TELL .TEXT CR>)>
        <RTRUE>
    )>
> 

<ROUTINE BOTTLE-F ()
    <COND (<VERB? TAKE>
        <COND (<=? <LOC ,13-BABELFISH> ,PLAYER>
            <TELL ,MESSAGE-070 CR>
            <RTRUE>)
        (T
            <TELL ,MESSAGE-047 CR>
            <RTRUE>)
        >)
    >
    <STANDARD-F>
> 

;"Room: TWISTING PASSAGE ------------------------------------------------------"
<ROOM 26-TWISTING-PASSAGE
    (DESC "Twisting Passage")
    (IN ROOMS)
    (LDESC 
"You are in the Twisting Passage. Chubby Checkers is heard from concealed loud-speakers, and a large
number of individuals are twisting to the music. The passage continues north and east.")
    (NORTH TO 23-VIEWING-ROOM)
    (EAST TO 27-BAR)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SPEAKERS LOUD-SPEAKERS INDIVIDUALS) STANDARD-F)> 

;"Room: BAR -------------------------------------------------------------------"
<ROOM 27-BAR
    (DESC "Bar")
    (IN ROOMS)
    (LDESC 
"You are at the bar, which is tended by a gnome with a hip, gaily colored beard. The backroom is to the
east and you can leave the bar to the west.")
    (EAST TO 28-BACKROOM)
    (WEST TO 26-TWISTING-PASSAGE)
    (ACTION BAR-F)
    (FLAGS LIGHTBIT)> 

<ROUTINE BAR-F ()
    <COND (<AND <VERB? BUY>  <=? ,PRSO ,10-DRINK>>
        <COND (<HELD? ,01-COIN>
            <TELL ,MESSAGE-045 CR>
            <MOVE ,01-COIN ,LOCAL-GLOBALS>
            <MOVE ,10-DRINK ,PLAYER>
            <FSET ,10-DRINK TAKEBIT>
            <FCLEAR ,10-DRINK NDESCBIT>
            <RTRUE>
        )>
    )>
>

;"Room: BACKROOM --------------------------------------------------------------"
<ROOM 28-BACKROOM
    (DESC "Backroom")
    (IN ROOMS)
    (LDESC 
"You are in the backroom of the bar. It is furnished with a table covered with green cloth, and some chairs.
The bar is to the west and to the east is a doorway with a sign reading \"DO UNDER NO CIRCUMSTANCES GO FURTHER EAST!\".")
    (EAST TO 29-CAVERN)
    (WEST TO 27-BAR)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (TABLE) TABLE-F
            (<>) (SIGN CLOTH CHAIRS CHAIR) STANDARD-F)> 

<ROUTINE TABLE-F ()
    <COND (<VERB? LOOK-UNDER SEARCH> 
        <COND (<AND <=? ,HERE ,28-BACKROOM> <NOT ,21-COIN-UNDER-TABLE-FLAG>>
            <TELL ,MESSAGE-044 CR>
            <MOVE ,01-COIN ,HERE>
            <THIS-IS-IT ,01-COIN>
            <SETG ,21-COIN-UNDER-TABLE-FLAG T>
            <RTRUE>)
        (T
            <TELL ,MESSAGE-000 CR>
            <RTRUE>)
        >)
        (T
            <STANDARD-F>
        )
    >
>

;"Room: CAVERN ----------------------------------------------------------------"
<ROOM 29-CAVERN
    (DESC "Large Cavern")
    (IN ROOMS)
    (LDESC 
"You are in a large cavern. A passage leads west and another leads north.")
    (WEST TO 28-BACKROOM)
    (NORTH PER CAVERN-EXIT)
    (FLAGS LIGHTBIT)> 

<ROUTINE CAVERN-EXIT ()
    <COND (<IN? ,09-DRAGON ,HERE>
        <TELL ,MESSAGE-061 CR>
        <RFALSE>)
    (T
        <RETURN ,30-DRAGON-LAIR>)
    >
>

;"Room: DRAGON'S LAIR ---------------------------------------------------------"
<ROOM 30-DRAGON-LAIR
    (DESC "Dragon's Lair")
    (IN ROOMS)
    (LDESC 
"You are in the dragon's lair. The walls are decorated with swords of Elvish craftmanship. The only exit is south.")
    (SOUTH TO 29-CAVERN)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SWORD SWORDS) STANDARD-F)> 

;"Room: RAMBO'S LAIR ----------------------------------------------------------"
<ROOM 31-RAMBO-LAIR
    (DESC "Rambo's Lair")
    (IN ROOMS)
    (LDESC 
"You are in Rambo's lair. It is decorated with bamboo canes, bazookas and large bowie knives. You can go east.")
    (EAST TO 22-JUNCTION)
    (ACTION RAMBO-LAIR-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (CANE CANES BAZOOKA BAZOOKAS KNFE KNIVES) STANDARD-F)>

<ROUTINE RAMBO-LAIR-F (RARG)
    <COND (<AND <VERB? DUCK> ,18-RAMBO-FLAG <NOT ,19-DUCK-FLAG>>
        <TELL ,SYSMESSAGE-015 CR>
        <SETG ,19-DUCK-FLAG T>
        <RTRUE>)
    >        
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<AND <IN? ,11-RAMBO ,HERE> <FSET? ,05-DISGUISE WORNBIT> ,18-RAMBO-FLAG <NOT ,19-DUCK-FLAG>>
            <TELL CR>
            <JIGS-UP ,MESSAGE-039>
            <RTRUE>)
        >
        <COND (<AND <IN? ,11-RAMBO ,HERE> <FSET? ,05-DISGUISE WORNBIT> <IN? ,09-DRAGON ,HERE> ,18-RAMBO-FLAG ,19-DUCK-FLAG>
            <TELL CR ,MESSAGE-041 CR>
            <MOVE ,09-DRAGON ,LOCAL-GLOBALS>
            <SETG ,19-DUCK-FLAG <>>
            <SETG ,18-RAMBO-FLAG T>
            <SETG ,17-DRAGON-COUNTER 0>
            <COND (<NOT ,SCORE-KILL-DRAGON-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-KILL-DRAGON-FLAG T>)>
            <RTRUE>)
        >
        <COND (<AND <IN? ,11-RAMBO ,HERE> <FSET? ,05-DISGUISE WORNBIT> ,18-RAMBO-FLAG ,19-DUCK-FLAG>
            <TELL CR ,MESSAGE-040 CR>
            <MOVE ,11-RAMBO ,LOCAL-GLOBALS>
            <SETG ,19-DUCK-FLAG <>>
            <SETG ,18-RAMBO-FLAG <>>
            <SETG ,17-DRAGON-COUNTER 0>
            <RTRUE>)
        >
        <COND (<AND <IN? ,11-RAMBO ,HERE> <FSET? ,05-DISGUISE WORNBIT> <NOT ,18-RAMBO-FLAG>>
            <TELL CR ,MESSAGE-038 CR>
            <SETG ,18-RAMBO-FLAG T>
            <RTRUE>)
        >
        )
    >        
>

;"Room: PASSAGE ---------------------------------------------------------------"
<ROOM 32-PASSAGE
    (DESC "Turning Passage")
    (IN ROOMS)
    (LDESC 
"You are in a passage turning north and west.")
    (NORTH TO 22-JUNCTION)
    (WEST TO 33-STAIRCASE-TOP)
    (FLAGS LIGHTBIT)>

;"Room: STAIRCASE TOP ---------------------------------------------------------"
<ROOM 33-STAIRCASE-TOP
    (DESC "Top of Staircase")
    (IN ROOMS)
    (LDESC 
"You are at the top of an aluminium spiral staircase winding down through the bedrock. A passage leads east.")
    (EAST TO 32-PASSAGE)
    (DOWN TO 34-STAIRCASE-BOTTOM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAIRCASE BEDROCK) STANDARD-F)>

;"Room: STAIRCASE BOTTOM ------------------------------------------------------"
<ROOM 34-STAIRCASE-BOTTOM
    (DESC "Bottom of Staircase")
    (IN ROOMS)
    (LDESC 
"You are at the bottom of the aluminium staircase. A passage leads south.")
    (UP TO 33-STAIRCASE-TOP)
    (SOUTH TO 35-DUNGEON-HALL)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAIRCASE) STANDARD-F)>   

;"Room: DUNGEON HALL ----------------------------------------------------------"
<ROOM 35-DUNGEON-HALL
    (DESC "Dungeon Hall")
    (IN ROOMS)
    (LDESC 
"You are in a hall in the depths of Werner's dungeon. Passages lead in all directions.")
    (NORTH TO 34-STAIRCASE-BOTTOM)
    (SOUTH TO 42-FORK)
    (WEST TO 36-EW-CORRIDOR)
    (EAST TO 47-THEOBALD-HALL)
    (FLAGS LIGHTBIT)> 

;"Room: EAST-WEST CORRIDOR ----------------------------------------------------"
<ROOM 36-EW-CORRIDOR
    (DESC "East-West Corridor")
    (IN ROOMS)
    (LDESC 
"You are in a dusty east-west corridor with open doors on both sides.")
    (NORTH TO 37-DRESSING-NORTH)
    (SOUTH TO 38-DRESSING-SOUTH)
    (EAST TO 35-DUNGEON-HALL)
    (WEST TO 39-BACKSTAGE)
    (FLAGS LIGHTBIT)> 

;"Room: NORTH DRESSING ROOM ---------------------------------------------------"
<ROOM 37-DRESSING-NORTH
    (DESC "North Dressing Room")
    (IN ROOMS)
    (LDESC 
"You are in an obviously deserted dressing room. The exit is to the south.")
    (SOUTH TO 36-EW-CORRIDOR)
    (FLAGS LIGHTBIT)> 

;"Room: SOUTH DRESSING ROOM ---------------------------------------------------"
<ROOM 38-DRESSING-SOUTH
    (DESC "South Dressing Room")
    (IN ROOMS)
    (LDESC 
"You are in an obviously deserted dressing room. The exit is to the north.")
    (NORTH TO 36-EW-CORRIDOR)
    (FLAGS LIGHTBIT)> 
      
;"Room: BACKSTAGE -------------------------------------------------------------"
<ROOM 39-BACKSTAGE
    (DESC "Behind Stage")
    (IN ROOMS)
    (LDESC 
"You are behind the stage of something that slightly resembles a theatre. A little room lies to the west,
the corridor is to the east and the stage is to the south.")
    (SOUTH TO 41-STAGE)
    (EAST TO 36-EW-CORRIDOR)
    (WEST TO 40-CONTROL-ROOM)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAGE) STANDARD-F)>

;"Room: CONTROL ROOM ----------------------------------------------------------"
<ROOM 40-CONTROL-ROOM
    (DESC "Control Room")
    (IN ROOMS)
    (LDESC 
"You are in the control room of the theatre. It is equipped with a red button, a green button, a blue button,
a yellow button and a large sign saying: \"DO NOT TOUCH THE CONTROLS!\". You can leave the room to the east.")
    (EAST TO 39-BACKSTAGE)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (SIGN) STANDARD-F
            (RED GREEN BLUE YELLOW) (BUTTON BUTTONS) BUTTON-F)> 

<ROUTINE BUTTON-F ()
    <COND (<VERB? PUSH> 
        <TELL ,MESSAGE-097 CR>
        <RTRUE>
    )>
    <STANDARD-F>
>

;"Room: STAGE -----------------------------------------------------------------"
<ROOM 41-STAGE
    (DESC "Dungeon Theatre Stage")
    (IN ROOMS)
    (LDESC 
"You are on the stage of the dungeon theatre. You can leave the stage to the north.")
    (NORTH TO 39-BACKSTAGE)
    (ACTION THING-FISH-ON-STAGE-F)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (STAGE) STANDARD-F)> 

<ROUTINE THING-FISH-ON-STAGE-F (RARG)
    <COND (<AND <VERB? RAISE> <PRSO? HAND>> 
        <COND (<=? ,22-THING-FISH-STAGE-COUNTER 2> 
            <TELL ,MESSAGE-084 CR CR>
            <MOVE ,15-THINGFISH ,44-LAB-MO-TORIUM>
            <SETG ,23-THING-FISH-FLAG <>>
            <GOTO ,44-LAB-MO-TORIUM>
            <RTRUE>)
        >        
        <COND (<=? ,22-THING-FISH-STAGE-COUNTER 3> 
            <JIGS-UP ,MESSAGE-085>
            <RTRUE>)
        >)
    >        
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<=? ,22-THING-FISH-STAGE-COUNTER 0> 
            <TELL CR ,MESSAGE-081 CR>
            <SETG ,22-THING-FISH-STAGE-COUNTER 1>
            <RTRUE>)
           >        
        <COND (<=? ,22-THING-FISH-STAGE-COUNTER 1> 
            <TELL CR ,MESSAGE-082 CR>
            <SETG ,22-THING-FISH-STAGE-COUNTER 2>
            <RTRUE>)
        > 
        <COND (<=? ,22-THING-FISH-STAGE-COUNTER 2> 
            <TELL CR ,MESSAGE-083 CR>
            <SETG ,22-THING-FISH-STAGE-COUNTER 3>
            <RTRUE>)
        >        
        <COND (<=? ,22-THING-FISH-STAGE-COUNTER 3> 
            <TELL CR ,MESSAGE-086 CR>
            <TELL CR ,MESSAGE-082 CR>
            <SETG ,22-THING-FISH-STAGE-COUNTER 2>
            <RTRUE>)
        >)
    >        
>

;"Room: FORK ------------------------------------------------------------------"
<ROOM 42-FORK
    (DESC "Fork in the Passage")
    (IN ROOMS)
    (LDESC 
"You are at a fork in the passages. You can go north, south and west.")
    (NORTH TO 35-DUNGEON-HALL)
    (WEST TO 43-OUTSIDE-THEATRE)
    (SOUTH TO 50-CAVE)
    (FLAGS LIGHTBIT)> 
      
;"Room: OUTSIDE THEATRE -------------------------------------------------------"
<ROOM 43-OUTSIDE-THEATRE
    (DESC "Outside Theatre")
    (IN ROOMS)
    (LDESC 
"You are standing outside the local theatre. A splenetic goblin, wearing a spangled robe, is guarding
the entrance, which is to the north. A passage leads east.")
    (EAST TO 42-FORK)
    (NORTH ,MESSAGE-087)
    (FLAGS LIGHTBIT)
    (THINGS (LOCAL) (THEATRE) STANDARD-F
            (SPANGLED) (ROBE) STANDARD-F)>

;"Room: LAB-MO-TORIUM ---------------------------------------------------------"
<ROOM 44-LAB-MO-TORIUM
    (DESC "The Evil Prince's Lab-Mo-Torium")
    (IN ROOMS)
    (LDESC 
"You are in the Evil Prince's Lab-Mo-Torium. An over-sized mock pig is here. Beside it stands a large vat,
marked \"GALOOT COLOGNE\". A pipe is leading from the vat to the pig. Exits lead east and west.")
    (EAST TO 45-MIRROR-ROOM)
    (WEST TO 52-WAITING-ROOM IF 24-MIDGET-FLAG ELSE ,MESSAGE-091)
    (UP PER LAB-MO-TORIUM-EXIT)
    (ACTION LAB-MO-TORIUM-F)
    (FLAGS LIGHTBIT)
    (THINGS (OVER-SIZED MOCK) (PIG) STANDARD-F
            (LARGE) (VAT) STANDARD-F
            (<>) (PIPE) STANDARD-F)>

<ROUTINE LAB-MO-TORIUM-EXIT ()
    <COND (<AND <IN? ,26-LADDER ,HERE> <NOT <IN? ,26-LADDER ,PLAYER>>>
        <RETURN 62-LADDER-TOP>)
    (T
        <TELL ,SYSMESSAGE-007 CR>
        <RFALSE>)
    >
>

<ROUTINE LAB-MO-TORIUM-F (RARG)
    <COND (<NOT ,SCORE-ENTER-LAB-MO-TORIUM-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ENTER-LAB-MO-TORIUM-FLAG T>)>
    <COND (<VERB? CLIMB> 
        <COND (<AND <=? ,HERE ,44-LAB-MO-TORIUM> <IN? ,26-LADDER ,HERE>>
        <TELL "[the ladder]|">
        <LADDER-F>)
        >)
    >
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<NOT ,23-THING-FISH-FLAG> 
            <TELL CR ,MESSAGE-089 CR>
            <TELL CR ,MESSAGE-090 CR>
            <SETG ,23-THING-FISH-FLAG T>
            <SETG ,22-THING-FISH-STAGE-COUNTER 0>
            <MOVE ,15-THINGFISH 41-STAGE>
            <RTRUE>)
        >
        <COND (<AND <NOT ,24-MIDGET-FLAG> <IN? ,08-STATUETTE ,HERE> <NOT <IN? ,08-STATUETTE ,PLAYER>> <IN? ,17-MIDGET ,HERE>>
            <TELL CR ,MESSAGE-094 CR>
            <MOVE ,17-MIDGET ,LOCAL-GLOBALS>
            <MOVE ,19-MIDGET-IN-CONVERSATION ,HERE>
            <SETG ,24-MIDGET-FLAG T>
            <RTRUE>)
        >)
    >        
>

;"Room: MIRROR ROOM -----------------------------------------------------------"
<ROOM 45-MIRROR-ROOM
    (DESC "Mirror Room")
    (IN ROOMS)
    (LDESC 
"You are in the mirror room. A large mirror occupies the northern wall. Through the mirror you can see the interior
of a severely ugly and badly-maintained castle. You can go east and west.")
    (WEST TO 44-LAB-MO-TORIUM)
    (EAST TO 48-EW-CORRIDOR)
    (ACTION MIRROR-ROOM-F)
    (FLAGS LIGHTBIT)
    (THINGS (LARGE) (MIRROR) STANDARD-F
            (UGLY BADLY-MAINTAINED) (CASTLE) STANDARD-F)>

<ROUTINE MIRROR-ROOM-F ()
    <COND (<NOT ,25-WIZARD-FLAG>
        <COND (<L=? <RANDOM 100> 20>
            <TELL ,MESSAGE-099 CR>
            <RTRUE>
        )>
        <COND (<L=? <RANDOM 100> 10>
            <TELL ,MESSAGE-100 CR CR>
            <GOTO ,46-IN-CASTLE>
            <RTRUE>
        )>
    )>
>

;"Room: SMALL ROOM IN CASTLE---------------------------------------------------"
<ROOM 46-IN-CASTLE
    (DESC "Small Room in Castle")
    (IN ROOMS)
    (LDESC 
"You are in a small room in a badly-maintained castle. To the north there is a closed plain wooden door. The wizard
is here. The wizard prompts you to open the door.")
    (FLAGS LIGHTBIT)
    (THINGS (PLAIN WOODEN) (DOOR) WOODEN-DOOR-F
            (UGLY BADLY-MAINTAINED) (CASTLE) STANDARD-F
            (<>) (WIZARD) WIZARD-F)>

<ROUTINE WOODEN-DOOR-F ()
    <COND (<VERB? OPEN> 
        <TELL ,MESSAGE-102 CR CR>
        <SETG ,25-WIZARD-FLAG T>
        <GOTO ,35-DUNGEON-HALL>
        <RTRUE>)
    >        
    <STANDARD-F>
>

<ROUTINE WIZARD-F ()
    <COND (<VERB? EXAMINE> 
        <TELL ,MESSAGE-101 CR>
        <RTRUE>)
    >
>

;"Room: THEOBALD'S HALL -------------------------------------------------------"
<ROOM 47-THEOBALD-HALL
    (DESC "Theobald's Hall")
    (IN ROOMS)
    (LDESC 
"You are in the halls of Theobald the trendy, the last of the dwarven kings.|It is now deserted. The only remains
of its former glory are some posters taped to the stone walls. The exit is to the west.")
    (WEST TO 35-DUNGEON-HALL)
    (NORTH PER THEOBALD-HALL-EXIT)
    (FLAGS LIGHTBIT)
    (THINGS (<>) (POSTER POSTERS) POSTERS-F
            (<>) ( WALL WALLS) STANDARD-F)>

<ROUTINE THEOBALD-HALL-EXIT ()
    <COND (<IN? ,23-BRIDGE ,HERE>
        <RETURN 53-BRIDGE>)
    (T
        <TELL ,SYSMESSAGE-007 CR>
        <RFALSE>)
    >
>

<ROUTINE POSTERS-F ()
    <COND (<VERB? EXAMINE> 
        <TELL ,MESSAGE-103 CR>
        <RTRUE>)
    >
>

;"Room: EAST-WEST CORRIDOR ----------------------------------------------------"
<ROOM 48-EW-CORRIDOR
    (DESC "East-West corridor")
    (IN ROOMS)
    (LDESC 
"You are in an east-west corridor. A doorway leads north.")
    (NORTH TO 49-STORAGE-ROOM)
    (WEST TO 45-MIRROR-ROOM)
    (EAST TO 56-EW-CORRIDOR)
    (FLAGS LIGHTBIT)>

;"Room: STORGE ROOM -----------------------------------------------------------"
<ROOM 49-STORAGE-ROOM
    (DESC "Octagonal Storage Room")
    (IN ROOMS)
    (LDESC 
"You are in the Dungeon's Octagonal Rod Storage Room. The exit is to the south.")
    (SOUTH TO 48-EW-CORRIDOR)
    (FLAGS LIGHTBIT)>
     
;"Room: CAVE ------------------------------------------------------------------"
<ROOM 50-CAVE
    (DESC "Cave")
    (IN ROOMS)
    (LDESC 
"You are in a cave with exits to the north, south and east.")
    (NORTH TO 42-FORK)
    (SOUTH TO 51-NS-CORRIDOR)
    (EAST TO 52-WAITING-ROOM)
    (FLAGS LIGHTBIT)>
      
;"Room: NORTH-SOUTH CORRIDOR --------------------------------------------------"
<ROOM 51-NS-CORRIDOR
    (DESC "Blue North-South Corridor")
    (IN ROOMS)
    (LDESC 
"You are in a blue north-south corridor, which branches to the east.")
    (NORTH TO 50-CAVE)
    (SOUTH TO 61-PERCY-CHAMBER)
    (EAST TO 58-DUSTY-CELLAR)
    (ACTION BLUE-CORRIDOR-F)
    (FLAGS LIGHTBIT)> 

<ROUTINE BLUE-CORRIDOR-F (RARG)
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<AND <L=? <RANDOM 100> 20> <NOT ,26-SPACE-TRAVELLER-FLAG>>
            <COND (<IN? ,21-RODS ,PLAYER>
                <TELL CR ,MESSAGE-107 CR>
                <MOVE ,21-RODS ,LOCAL-GLOBALS>
                <MOVE ,22-BLACK-ROD ,HERE>
                <SETG ,26-SPACE-TRAVELLER-FLAG T>
                <RTRUE>)
            (T
                <TELL CR ,MESSAGE-106 CR>
                <RTRUE>)
            >)  
        >)
    >        
>

;"Room: WAITING ROOM ----------------------------------------------------------"
<ROOM 52-WAITING-ROOM
    (DESC "Waiting Room")
    (IN ROOMS)
    (LDESC 
"You are in the waiting room of the Evil Prince's Lab-Mo-Torium. On one wall hangs a framed diploma. The
Lab-Mo-Torium lies east and the exit is west.")
    (WEST TO 50-CAVE)
    (EAST TO 44-LAB-MO-TORIUM IF 24-MIDGET-FLAG ELSE ,MESSAGE-092)
    (FLAGS LIGHTBIT) 
    (THINGS (FRAMED) (DIPLOMA) DIPLOMA-F)>

<ROUTINE DIPLOMA-F ()
    <COND (<VERB? EXAMINE READ> 
        <FIXED-FONT-ON>
        <TELL ,MESSAGE-105 CR>
        <FIXED-FONT-OFF>
        <RTRUE>)
    >
>

;"Room: BRIDGE ----------------------------------------------------------------"
<ROOM 53-BRIDGE
    (DESC "Heart of Gold Bridge")
    (IN ROOMS)
    (LDESC 
"You are on the bridge of the Heart of Gold spaceship. Next to Eddie, the shipboard computer, stands a strange
machine equipped with a large switch. You can go south, west and down.")
    (SOUTH TO 47-THEOBALD-HALL)
    (WEST ,MESSAGE-113)
    (DOWN TO 54-CORRIDOR)
    (FLAGS LIGHTBIT) 
    (THINGS (LARGE) (SWITCH) SWITCH-F
            (<>) (EDDIE COMPUTER) STANDARD-F
            (STRANGE) (MACHINE) STANDARD-F)>

<ROUTINE SWITCH-F ()
    <COND (<VERB? TURN FLIP>
        <TELL ,MESSAGE-115 CR CR "-- More --">
        <INPUT 1>
        <TELL CR CR ,MESSAGE-116 CR CR "-- More --">
        <INPUT 1>
        <TELL CR CR>
        <GOTO ,35-DUNGEON-HALL>
        <RTRUE>
    )>
    <STANDARD-F> 
>

;"Room: CORRIDOR --------------------------------------------------------------"
<ROOM 54-CORRIDOR
    (DESC "Corridor of the Heart of Gold")
    (IN ROOMS)
    (LDESC 
"You are in the corridor of the Heart of Gold. A gallery lies to the west and a ladder leads up.")
    (WEST TO 55-GALLERY)
    (UP TO 53-BRIDGE)
    (FLAGS LIGHTBIT)>

;"Room: GALLERY ---------------------------------------------------------------"
<ROOM 55-GALLERY
    (DESC "Small Gallery")
    (IN ROOMS)
    (LDESC 
"You are in a small gallery. Against one wall stands a Nutri-Mat Liquid Dispensing Machine with a large pad.|
Arthur Dent is here, trying to persuade the machine into supplying him with a cup of tea, but all he gets
is Advanced Tea Substitute.")
    (EAST TO 54-CORRIDOR)
    (FLAGS LIGHTBIT) 
    (THINGS (LARGE) (PAD) PAD-F
            (<>) (TEA SUBSTITUTE) STANDARD-F
            (NUTRI-MAT DISPENSING) (MACHINE) STANDARD-F)>     

<ROUTINE PAD-F ()
    <COND (<VERB? PUSH>
        <COND (<=? ,27-TEA-FLAG <>>
            <TELL ,MESSAGE-114 CR>
            <SETG ,27-TEA-FLAG T>
            <MOVE ,24-TEA ,HERE> 
            <THIS-IS-IT ,24-TEA>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-117 CR>
            <RTRUE>
        )>
    )>
    <STANDARD-F> 
>

;"Room: EAST-WEST CORRIDOR ----------------------------------------------------"
<ROOM 56-EW-CORRIDOR
    (DESC "East-West Corridor")
    (IN ROOMS)
    (LDESC 
"You are in an east-west corridor. To the east there is a stout door guarded by a well-armed guard.
The guard says: \"What is the password?\"")
    (WEST TO 48-EW-CORRIDOR)
    (EAST "The guard says: \"I need the password!\"")
    (FLAGS LIGHTBIT) 
    (THINGS (STOUT) (DOOR) STANDARD-F)>

;"Room: ROOM IN A CASTLE ------------------------------------------------------"
<ROOM 57-ROOM-IN-CASTLE
    (DESC "Room in a Castle")
    (IN ROOMS)
    (LDESC 
"You are in a room in a castle. The exit is west.")
    (WEST TO 56-EW-CORRIDOR)
    (ACTION ROOM-IN-CASTLE-F)
    (FLAGS LIGHTBIT)>

<ROUTINE ROOM-IN-CASTLE-F (RARG)
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<AND <IN? ,25-ADDER ,HERE> <FSET? ,05-DISGUISE WORNBIT>>  
            <TELL CR ,MESSAGE-125 CR>
            <MOVE ,25-ADDER ,LOCAL-GLOBALS>
            <RTRUE>)
        >)        
    >        
>

;"Room: DUSTY CELLAR ------------------------------------------------------"
<ROOM 58-DUSTY-CELLAR
    (DESC "Dusty Cellar")
    (IN ROOMS)
    (LDESC 
"You are in a dusty cellar. A stairway leads up. You can also go west.")
    (WEST TO 51-NS-CORRIDOR)
    (UP TO 59-FARM)
    (FLAGS LIGHTBIT) 
    (THINGS (<>) (STAIRWAY) STANDARD-F)>

;"Room: FARM ------------------------------------------------------------------"
<ROOM 59-FARM
    (DESC "Smelly Old Farm")
    (IN ROOMS)
    (LDESC 
"You are in a smelly old farm. You can see a large number of farmers and also Miriam, the butcher's second
fattest daughter. In one corner stands a tiled stove, and the door is to the north.")
    (DOWN TO 58-DUSTY-CELLAR)
    (NORTH ,MESSAGE-137)
    (FLAGS LIGHTBIT)
        (THINGS (<>) (STOVE DOOR) STANDARD-F)
>

;"Room: LAWN ------------------------------------------------------------------"
<ROOM 60-LAWN
    (DESC "Francesco's Front Lawn")
    (IN ROOMS)
    (NORTH PER LAWN-EXIT)
    (LDESC 
"You are on Francesco's front lawn.|Francesco, the unknown Italian, is here. He watches you through red
plastic binoculars. To the north is a cardboard hut.")
    (ACTION LAWN-F)
    (FLAGS LIGHTBIT) 
    (THINGS (UNKNOWN ITALIAN) (FRANCESCO) STANDARD-F
            (RED PLASTIC) (BINOCULARS) STANDARD-F
            (CARDBOARD) (HUT) STANDARD-F)>

<ROUTINE LAWN-EXIT ()
    <COND (<=? ,28-EVIL-PRINCE-COUNTER 4>
        <TELL ,MESSAGE-139 CR CR>
        <JIGS-UP ,MESSAGE-140>
    )
    (T
        <TELL ,MESSAGE-141 CR>
        <RFALSE>)
    >
>

<ROUTINE LAWN-F ()
    <COND (<NOT ,SCORE-ENTER-LAWN-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-ENTER-LAWN-FLAG T>)>
>

;"Room: SIR PERCY'S CHAMBER ---------------------------------------------------"
<ROOM 61-PERCY-CHAMBER
    (DESC "Sir Percy's Chamber")
    (IN ROOMS)
    (LDESC 
"You are in Sir Percy's chamber. The exit is to the north. Sir Percy is here.")
    (NORTH TO 51-NS-CORRIDOR)
    (FLAGS LIGHTBIT)>

;"Room: TOP OF A LADDER -------------------------------------------------------"
<ROOM 62-LADDER-TOP
    (DESC "Top of a Ladder")
    (IN ROOMS)
    (LDESC 
"You are standing on top of a ladder, looking down into a gigantic vat of Galoot Cologne.")
    (DOWN TO 44-LAB-MO-TORIUM)
    (ACTION LADDER-TOP-F)
    (FLAGS LIGHTBIT) 
    (THINGS (BLACK) (LADDER) LADDER-F
            (GIGANTIC) (VAT) STANDARD-F
            (GALOOT) (COLOGNE) STANDARD-F)>

<ROUTINE LADDER-TOP-F (RARG)
    <COND (<EQUAL? .RARG ,M-END>
        <COND (<AND <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <=? ,28-EVIL-PRINCE-COUNTER 4>> 
            <TELL CR ,MESSAGE-132 CR>
            <MOVE ,28-EVIL-PRINCE ,LOCAL-GLOBALS>
            <MOVE ,29-EVIL-PRINCE-PIPE ,LOCAL-GLOBALS>
            <COND (<NOT ,SCORE-KILL-PRINCE-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-KILL-PRINCE-FLAG T>)>
            <RTRUE>)
       >)
    >        
>

;"-----------------------------------------------------------------------------
; OBJECTS
; -----------------------------------------------------------------------------"

;"Object: HAND ----------------------------------------------------------------"
<OBJECT HAND
	(IN GLOBAL-OBJECTS)
	(SYNONYM HAND HANDS)
    (ADJECTIVE MY ONE)
	(DESC "your hands")
    (ACTION HANDS-F)
	(FLAGS NDESCBIT NARTICLEBIT PARTBIT)>

<ROUTINE HANDS-F () 
    <COND (<VERB? WAVE>
        <V-WAVE-HANDS>
        <RTRUE>)
    >
>

;"Object: MAZE SERVICE --------------------------------------------------------"
<OBJECT MAZE-SERVICE
	(IN GLOBAL-OBJECTS)
	(SYNONYM MAZE-SERVICE SERVICE)
    (ADJECTIVE WERNER MAZE)
	(DESC "Werner's Maze Service")
    (ACTION MAZE-SERVICE-F)
	(FLAGS NDESCBIT NARTICLEBIT)>

<ROUTINE MAZE-SERVICE-F ()
    <COND (<NOT <VERB? CALL>>
        <TELL "You don't see that here." CR>
        <RTRUE>
    )>
>

;"Object: FRONT DOOR ----------------------------------------------------------"
<OBJECT FRONT-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR)
    (ADJECTIVE FRONT)
	(DESC "front door")
    (ACTION FRONT-DOOR-F)
	(FLAGS NDESCBIT DOORBIT)>

<ROUTINE FRONT-DOOR-F ()
    <COND (<VERB? KNOCK>
        <COND (,11-FRONT-DOOR-FLAG
            <TELL ,MESSAGE-021 CR>
            <RTRUE>)
        (T
            <COND (<EQUAL? ,HERE ,00-OUTSIDE-HOUSE>
                <TELL ,MESSAGE-003 CR>
                <SETG 11-FRONT-DOOR-FLAG T>
                <RTRUE>)
            (T
                <TELL ,MESSAGE-024 CR>
                <RTRUE>)
            >)
        >)
    >
    <COND (<VERB? EXAMINE> 
        <COND (,11-FRONT-DOOR-FLAG
            <TELL ,MESSAGE-026 CR>
            <RTRUE>)
        (T
            <COND (<EQUAL? ,HERE ,00-OUTSIDE-HOUSE>
                <TELL ,MESSAGE-001 CR>
                <RTRUE>)
            (T
                <TELL ,MESSAGE-025 CR>
                <RTRUE>)
            >)
        >)
    >
    <COND (<VERB? OPEN> 
        <COND (,11-FRONT-DOOR-FLAG
            <TELL ,MESSAGE-021 CR>
            <RTRUE>)
        (T
            <COND (<EQUAL? ,HERE ,00-OUTSIDE-HOUSE>
                <TELL ,MESSAGE-001 CR>
                <RTRUE>)
            (T
                <TELL ,SYSMESSAGE-015 CR>
                <SETG 11-FRONT-DOOR-FLAG T>
                <RTRUE>)
            >)
        >)
    >
    <COND (<VERB? CLOSE> 
        <COND (,11-FRONT-DOOR-FLAG
            <TELL ,SYSMESSAGE-015 CR>
            <SETG 11-FRONT-DOOR-FLAG <>>
            <RTRUE>)
        (T
            <TELL ,MESSAGE-022 CR>
            <RTRUE>)
        >)
    >
    <COND (<VERB? WALK ENTER>
            <COND (<EQUAL? ,HERE ,00-OUTSIDE-HOUSE>
                <DO-WALK P?IN>
                <RTRUE>)
            (T
                <DO-WALK P?WEST>
                <RTRUE>)
        >)   
    >
    <COND (<VERB? PUSH>
        <TELL ,MESSAGE-002 CR>)
    >
>

;"Object: BAKERY DOOR ----------------------------------------------------------"
<OBJECT BAKERY-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR SLOT)
	(DESC "bakery door")
    (ACTION BAKERY-DOOR-F)
	(FLAGS NDESCBIT)>

<ROUTINE BAKERY-DOOR-F ()
    <COND (<VERB? EXAMINE> 
        <COND (,20-BAKERY-DOOR-FLAG
            <TELL ,MESSAGE-026 CR>
            <RTRUE>)
        (T
            <TELL ,MESSAGE-025 CR>
            <RTRUE>)
        >)
    >
>

;"Object: TROLL ---------------------------------------------------------------"
<OBJECT TROLL
	(IN 10-SMALL-ROOM)
	(SYNONYM TROLL)
    (ADJECTIVE HUGE)
	(DESC "huge troll")
    (TEXT ,MESSAGE-018)
    (ACTION TROLL-F)
	(FLAGS NDESCBIT PERSONBIT)>

<ROUTINE TROLL-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,TROLL>
        <TELL ,MESSAGE-074 CR>
        <RTRUE>
    )>
>

;"Object: VENDING MACHINE -----------------------------------------------------"
<OBJECT VENDING-MACHINE
	(IN 10-SMALL-ROOM)
	(SYNONYM MACHINE)
    (ADJECTIVE VENDING)
	(DESC "vending machine")
    (TEXT ,MESSAGE-013)
	(FLAGS NDESCBIT)>

;"Object: ARTHUR DENT ---------------------------------------------------------"
<OBJECT ARTHUR-DENT
	(IN 55-GALLERY)
	(SYNONYM ARTHUR DENT)
    (ADJECTIVE ARTHUR)
	(DESC "Arthur Dent")
    (TEXT ,MESSAGE-119)
	(FLAGS NDESCBIT PERSONBIT NARTICLEBIT)>

;"Object: WELL-ARMED GUARD ----------------------------------------------------"
<OBJECT GUARD
	(IN 56-EW-CORRIDOR)
	(SYNONYM GUARD)
    (ADJECTIVE ARMED WELL-ARMED)
	(DESC "well-armed guard")
    (ACTION GUARD-F)
	(FLAGS NDESCBIT PERSONBIT NARTICLEBIT)>

<ROUTINE GUARD-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,GUARD>
        <COND (<VERB? MOOSE>
            <TELL ,MESSAGE-134 CR CR>
            <GOTO ,57-ROOM-IN-CASTLE>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-135 CR>
            <RTRUE>
        )>
    )>
>

;"Object: PREBEN & PREBEN -----------------------------------------------------"
<OBJECT PREBEN
	(IN 25-BAKERY)
	(SYNONYM PREBEN COOK COOKS DANE DANES BAKER BAKERS)
    (ADJECTIVE DANISH PASTRY)
	(DESC "Preben & Preben")
    (TEXT ,MESSAGE-056)
    (ACTION PREBEN-F)
	(FLAGS NDESCBIT PERSONBIT NARTICLEBIT)>

<ROUTINE PREBEN-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,PREBEN>
        <TELL ,MESSAGE-073 CR>
        <RTRUE>
    )>
>

;"Object: PERCY ---------------------------------------------------------------"
<OBJECT PERCY
	(IN 61-PERCY-CHAMBER)
	(SYNONYM PERCY)
    (ADJECTIVE SIR)
	(DESC "Sir Percy")
    (ACTION PERCY-F)
	(FLAGS NDESCBIT PERSONBIT NARTICLEBIT)> 

<ROUTINE PERCY-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,PERCY>
        <TELL ,MESSAGE-126 CR>
        <RTRUE>
    )>
>

;"Object: GNOME ---------------------------------------------------------------"
<OBJECT GNOME
	(IN 27-BAR)
	(SYNONYM GNOME BEARD BARGNOME)
	(DESC "bargnome")
    (ACTION GNOME-F)
	(FLAGS NDESCBIT PERSONBIT)> 

<ROUTINE GNOME-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,GNOME>
        <TELL ,MESSAGE-122 CR>
        <RTRUE>
    )>
>

;"Object: GOBLIN --------------------------------------------------------------"
<OBJECT GOBLIN
	(IN 43-OUTSIDE-THEATRE)
	(SYNONYM GOBLIN)
    (ADJECTIVE SPLENETIC)
	(DESC "splenetic goblin")
    (ACTION GOBLIN-F)
	(FLAGS NDESCBIT PERSONBIT)> 

<ROUTINE GOBLIN-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,GOBLIN>
        <TELL ,MESSAGE-122 CR>
        <RTRUE>
    )>
>

;"Object: MIRIAM --------------------------------------------------------------"
<OBJECT MIRIAM
	(IN 59-FARM)
	(SYNONYM MIRIAM DAUGHTER)
    (ADJECTIVE FAT BUTCHER SECOND)
	(DESC "butcher's second fattest daughter")
    (ACTION MIRIAM-F)
	(FLAGS NDESCBIT PERSONBIT)> 

<ROUTINE MIRIAM-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,MIRIAM>
        <COND (<VERB? SING>
            <TELL ,MESSAGE-136 CR CR>
            <GOTO ,60-LAWN>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-122 CR>
            <RTRUE>
        )>
    )>
>

;"Object: FARMERS -------------------------------------------------------------"
<OBJECT FARMER
	(IN 59-FARM)
	(SYNONYM FARMERS FARMER PEASANT)
	(DESC "farmers")
    (ACTION FARMER-F)
	(FLAGS NDESCBIT PERSONBIT)> 

<ROUTINE FARMER-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,FARMER>
        <TELL ,MESSAGE-138 CR>
        <RTRUE>
    )>
>

;"Object: COIN ----------------------------------------------------------------"
<OBJECT 01-COIN
	(IN LOCAL-GLOBALS)
	(SYNONYM COIN ZORKMID)
    (ADJECTIVE SHINY)
	(DESC "shiny coin")
    (TEXT ,MESSAGE-012)
    (ACTION COIN-F)
    (FLAGS TAKEBIT)>

<ROUTINE COIN-F ()
    <COND (<VERB? PUT-IN BUY INSERT> 
        <COND (<AND <=? ,HERE ,10-SMALL-ROOM> <=? <LOC ,01-COIN> ,PLAYER> <PRSI? ,VENDING-MACHINE>>
            <TELL ,MESSAGE-015 CR>
            <MOVE ,01-COIN ,LOCAL-GLOBALS>
            <MOVE ,03-TICKET ,HERE>
            <FSET ,03-TICKET TAKEBIT>
            <FCLEAR ,03-TICKET NDESCBIT>
            <THIS-IS-IT ,03-TICKET>
            <RTRUE>)
        >)
    >
>

;"Object: SPOON ---------------------------------------------------------------"
<OBJECT 02-SPOON
	(IN LOCAL-GLOBALS)
	(SYNONYM SPOON)
    (ADJECTIVE OVER-SIZED CHROME)
	(DESC "over-sized chrome spoon")
    (FLAGS TAKEBIT VOWELBIT)>

;"Object: TICKET ---------------------------------------------------------------"
<OBJECT 03-TICKET
	(IN 10-SMALL-ROOM)
	(SYNONYM TICKET)
    (ADJECTIVE PINK)
	(DESC "pink ticket")
    (ACTION TICKET-F)
    (FLAGS NDESCBIT)>

<ROUTINE TICKET-F ()
    <COND (<VERB? GIVE SGIVE> 
        <COND (<=? ,PRSI <>> <TELL "[to the troll]" CR> <SETG ,PRSI ,TROLL>)>
        <COND (<AND <PRSI? ,TROLL> <=? ,HERE ,10-SMALL-ROOM> <=? <LOC ,03-TICKET> ,PLAYER>>
            <TELL ,MESSAGE-017 CR CR>
            <MOVE ,03-TICKET ,LOCAL-GLOBALS>
            <MOVE ,06-BROCHURE ,PLAYER>
            <COND (<=? ,GAME_VERSION_CLASSIC <>> <SETG ,TICKET-PAID-FLAG T>)>
            <GOTO ,11-DUNGEON-LOBBY>
            <RTRUE>)
        >)
    >
    <COND (<AND <VERB? EXAMINE> <FSET? ,PRSO ,NDESCBIT>> 
        <TELL "You don't see that here." CR>
        <RTRUE>
    )>
>

;"Object: MAP ------------------------------------------------------------------"
<OBJECT 04-MAP
	(IN LOCAL-GLOBALS)
	(SYNONYM MAP)
    (ADJECTIVE CURIOUS)
	(DESC "curious map")
    (TEXT ,MESSAGE-029)
    (ACTION MAP-F)
    (FLAGS TAKEBIT)>

<ROUTINE MAP-F ()
    <COND (<VERB? TAKE> 
        <COND (<AND <EQUAL? ,HERE ,05-FOREST> <=? <LOC ,04-MAP> ,HERE>>
            <V-TAKE>
            <TELL ,MESSAGE-004 CR>
            <MOVE ,04-MAP ,LOCAL-GLOBALS>
            <RTRUE>)
        >)
    >
>

;"Object: CHINA MAN'S DISGUISE -------------------------------------------------"
<OBJECT 05-DISGUISE
	(IN 09-CLOSET)
	(SYNONYM DISGUISE)
    (ADJECTIVE CHINA MAN)
	(DESC "china man's disguise")
    (TEXT ,MESSAGE-014)
    (ACTION DISGUISE-F)
    (FLAGS TAKEBIT)>

<ROUTINE DISGUISE-F ()
    <COND (<VERB? WEAR> 
        <COND (<HELD? ,PRSO>
            <COND (<FSET? ,PRSO ,WORNBIT>
                <TELL ,SYSMESSAGE-029 CR>
                <RTRUE>)
            (T
                <TELL "You put on " T ,PRSO CR>
                <FSET ,PRSO ,WORNBIT>
                <RTRUE>
            )>)
        >)
    >
    <COND (<VERB? UNWEAR> 
        <COND (<HELD? ,PRSO>
            <COND (<FSET? ,PRSO ,WORNBIT>
                <TELL "You remove " T ,PRSO CR>
                <FCLEAR ,PRSO ,WORNBIT>
                <COND (<AND <=? ,HERE ,31-RAMBO-LAIR> <=? <LOC ,11-RAMBO> ,HERE>>
                    <TELL ,MESSAGE-042 CR> 
                    <SETG 18-RAMBO-FLAG <>>
                )>
                <RTRUE>)
            (T
                <TELL ,SYSMESSAGE-023 CR>
                <RTRUE>
            )>)
        >)
    >
>

;"Object: BROCHURE -------------------------------------------------------------"
<OBJECT 06-BROCHURE
	(IN LOCAL-GLOBALS)
	(SYNONYM BROCHURE)
    (ADJECTIVE WHIMSICAL)
	(DESC "brochure")
    (TEXT ,MESSAGE-019)
    (FLAGS TAKEBIT READBIT)>

;"Object: ACCESS CARD ----------------------------------------------------------"
<OBJECT 07-ACCESS-CARD
	(IN LOCAL-GLOBALS)
	(SYNONYM CARD ACCESS-CARD )
    (ADJECTIVE ACCESS DANISH BAKERY)
	(DESC "Danish bakery access card")
    (ACTION ACCESS-CARD-F)
    (FLAGS TAKEBIT)>

<ROUTINE ACCESS-CARD-F ()
    <COND (<VERB? PUT-IN INSERT> 
        <COND (<HELD? ,PRSO>
            <COND (<AND <=? ,HERE ,24-BARE-ROOM> <=? ,PRSI <>>> <TELL "[in the slot]" CR> <SETG ,PRSI ,BAKERY-DOOR>)>
            <COND (<AND <=? ,HERE ,24-BARE-ROOM> <PRSI? ,BAKERY-DOOR>>
                <COND (<T? ,20-BAKERY-DOOR-FLAG>
                    <TELL ,MESSAGE-021 CR>
                    <RTRUE>)
                (T 
                    <TELL ,MESSAGE-053 CR>
                    <SETG ,20-BAKERY-DOOR-FLAG T>
                    <RTRUE>
                )>
            )>
        )>
    )>
>

;"Object: STATUETTE ------------------------------------------------------------"
<OBJECT 08-STATUETTE
	(IN 20-GIFT-SHOP)
	(SYNONYM STATUETTE)
 	(DESC "statuette depicting a midget")
    (TEXT ,MESSAGE-080)
    (ACTION STATUETTE-F)
    (FLAGS TAKEBIT)>

<ROUTINE STATUETTE-F ()
    <COND (<AND <VERB? TAKE> <IN? ,19-MIDGET-IN-CONVERSATION ,HERE>> 
        <TELL ,MESSAGE-095 CR>
        <RTRUE>)
    >        
>

;"Object: DRAGON ---------------------------------------------------------------"
<OBJECT 09-DRAGON
	(IN 29-CAVERN)
	(SYNONYM DRAGON)
    (ADJECTIVE FIRE-BREATHING)
	(DESC "dragon")
    (TEXT ,MESSAGE-057)>

;"Object: DRINK ----------------------------------------------------------------"
<OBJECT 10-DRINK
	(IN 27-BAR)
	(SYNONYM DRINK)
    (ADJECTIVE FIRE-BREATHING)
	(DESC "drink")
    (ACTION DRINK-F)
    (FLAGS NDESCBIT)>

<ROUTINE DRINK-F ()
    <COND (<VERB? GIVE> 
        <COND (<HELD? ,PRSO>
            <COND (<=? ,HERE ,25-BAKERY>
                <COND (<NOT ,SCORE-GET-PASTRY-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-PASTRY-FLAG T>)>
                <COND (<HELD? ,13-BABELFISH>
                    <TELL ,MESSAGE-069 CR>
                    <MOVE ,10-DRINK ,LOCAL-GLOBALS>
                    <MOVE ,12-PASTRY ,PLAYER>
                    <RTRUE>
                )
                (T
                    <TELL ,MESSAGE-046 CR>
                    <MOVE ,10-DRINK ,LOCAL-GLOBALS>
                    <MOVE ,12-PASTRY ,PLAYER>
                    <RTRUE>
                )>
            )
            (T
                <TELL ,SYSMESSAGE-008 CR>
                <RTRUE>
            )>
        )>
    )>
    <COND (<VERB? DRINK> 
        <COND (<HELD? ,PRSO>
            <TELL ,MESSAGE-031 CR>
            <MOVE ,10-DRINK ,LOCAL-GLOBALS>
            <RTRUE>
        )>
    )>
    <COND (<AND <VERB? EXAMINE> <FSET? ,PRSO ,NDESCBIT>> 
        <TELL "You don't see that here." CR>
        <RTRUE>
    )>
>

;"Object: RAMBO ----------------------------------------------------------------"
<OBJECT 11-RAMBO
	(IN 31-RAMBO-LAIR)
	(SYNONYM RAMBO)
	(DESC "Rambo")
    (TEXT ,MESSAGE-055)
    (ACTION RAMBO-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE RAMBO-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,11-RAMBO>
        <COND (<VERB? HELLO>
            <TELL ,MESSAGE-071 CR>
            <RTRUE>
        )
        (T
            <TELL ,MESSAGE-072 CR>
            <RTRUE>
        )>
    )>
>

;"Object: DANISH PASTRY / COLOGNE SOAKED PASTRY---------------------------------"
<OBJECT 12-PASTRY
	(IN LOCAL-GLOBALS)
	(SYNONYM PASTRY WIENERBR0D)
    (ADJECTIVE DANISH)
	(DESC "Danish pastry")
    (TEXT ,MESSAGE-054)
    (ACTION PASTRY-F)
    (FLAGS TAKEBIT EDIBLEBIT)>

<OBJECT 27-SOAKED-PASTRY
	(IN LOCAL-GLOBALS)
	(SYNONYM PASTRY WIENERBR0D)
    (ADJECTIVE COLOGNE-SOAKED DANISH)
	(DESC "cologne-soaked Danish pastry")
    (ACTION PASTRY-F)
    (FLAGS TAKEBIT EDIBLEBIT)>

<ROUTINE PASTRY-F ()
    <COND (<VERB? GIVE> 
        <COND (<AND <=? ,HERE ,62-LADDER-TOP> <HELD? ,12-PASTRY> <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <=? ,28-EVIL-PRINCE-COUNTER 0>>
            <TELL ,MESSAGE-129 CR>
            <SETG 28-EVIL-PRINCE-COUNTER 1>
            <MOVE ,12-PASTRY ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<AND <=? ,HERE ,62-LADDER-TOP> <HELD? ,27-SOAKED-PASTRY> <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <=? ,28-EVIL-PRINCE-COUNTER 0>>
            <TELL ,MESSAGE-129 CR>
            <SETG 28-EVIL-PRINCE-COUNTER 2>
            <MOVE ,27-SOAKED-PASTRY ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<AND <=? ,HERE ,62-LADDER-TOP> <HELD? ,12-PASTRY> <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <NOT <=? ,28-EVIL-PRINCE-COUNTER 0>>>
            <TELL ,MESSAGE-130 CR>
            <SETG 28-EVIL-PRINCE-COUNTER 2>
            <MOVE ,12-PASTRY ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<AND <=? ,HERE ,62-LADDER-TOP> <HELD? ,27-SOAKED-PASTRY> <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <NOT <=? ,28-EVIL-PRINCE-COUNTER 0>>>
            <TELL ,MESSAGE-130 CR>
            <SETG 28-EVIL-PRINCE-COUNTER 4>
            <MOVE ,27-SOAKED-PASTRY ,LOCAL-GLOBALS>
            <RTRUE>
        )>
    )>
    <COND (<VERB? EAT> 
        <COND (<OR <HELD? ,12-PASTRY> <IN? ,12-PASTRY ,HERE>>
            <TELL ,MESSAGE-059 CR>
            <MOVE ,12-PASTRY ,LOCAL-GLOBALS>
            <RTRUE>
        )>
        <COND (<OR <HELD? ,27-SOAKED-PASTRY> <IN? ,27-SOAKED-PASTRY ,HERE>>
            <JIGS-UP ,MESSAGE-133>
            <RTRUE>
        )>
    )>
    <COND (<VERB? PUT-IN INSERT> 
        <COND (<AND <=? ,HERE ,62-LADDER-TOP> <HELD? ,12-PASTRY>>
            <TELL ,MESSAGE-127 CR>
            <MOVE ,12-PASTRY ,LOCAL-GLOBALS>
            <MOVE ,27-SOAKED-PASTRY ,PLAYER>
            <THIS-IS-IT ,27-SOAKED-PASTRY>
            <RTRUE>
        )>
        <COND (<AND <=? ,HERE ,62-LADDER-TOP> <HELD? ,27-SOAKED-PASTRY>>
            <TELL ,MESSAGE-127 CR>
            <RTRUE>
        )>
    )>
>

;"Object: BABELFISH ------------------------------------------------------------"
<OBJECT 13-BABELFISH
	(IN LOCAL-GLOBALS)
	(SYNONYM FISH BABELFISH BABEL-FISH)
    (ADJECTIVE BABEL)
	(DESC "babel fish in your ear")
    (ACTION BABELFISH-F)
    (FLAGS TAKEBIT)>

<ROUTINE BABELFISH-F ()
    <COND (<VERB? DROP UNWEAR>
        <TELL ,MESSAGE-063 CR>
        <MOVE ,13-BABELFISH ,LOCAL-GLOBALS>
        <RTRUE>)
    >
>

;"Object: WIRELESS PHONE -------------------------------------------------------"
<OBJECT 14-PHONE
	(IN 30-DRAGON-LAIR)
	(SYNONYM PHONE TELEPHONE)
    (ADJECTIVE WIRELESS)
	(DESC "wireless telephone")
    (FLAGS TAKEBIT)>

;"Object: THE THING-FISH -------------------------------------------------------"
<OBJECT 15-THINGFISH
	(IN 41-STAGE)
	(SYNONYM THING-FISH THINGFISH)
	(DESC "The Thing-Fish")
    (TEXT ,MESSAGE-088)
    (ACTION THING-FISH-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE THING-FISH-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,15-THINGFISH>
        <TELL ,MESSAGE-121 CR>
        <RTRUE>
    )>
>

;"Object: PAIR OF SPECTACLES ---------------------------------------------------"
<OBJECT 16-SPECTACLES
	(IN 37-DRESSING-NORTH)
	(SYNONYM SPECTACLES GLASSES EYEGLASSES)
    (ADJECTIVE PAIR)
	(DESC "pair of spectacles")
    (ACTION SPECTACLES-F)
    (FLAGS TAKEBIT)>

<ROUTINE SPECTACLES-F ()
    <COND (<VERB? WEAR> 
        <COND (<HELD? ,PRSO>
            <COND (,GAME_VERSION_CLASSIC
                <JIGS-UP ,MESSAGE-098>
            )
            (T
                <SETG ,SPECTACLES-COUNTER 0>
                <TELL "The spectacles are extremly strong and make you dizzy. You can't see much and if you're not carefull you will hurt yourself." CR>
                <FSET ,PRSO ,WORNBIT>
                <RTRUE>
            )>
        )>
    )>
    <COND (<VERB? UNWEAR> 
        <COND (<HELD? ,PRSO>
            <COND (<FSET? ,PRSO ,WORNBIT>
                <TELL "You remove " T ,PRSO CR>
                <FCLEAR ,PRSO ,WORNBIT>
                <SETG ,SPECTACLES-COUNTER 0>
                <RTRUE>)
            (T
                <TELL "You're not wearing " T ,PRSO CR>
                <RTRUE>
            )>)
        >)
    >
    <COND (<VERB? GIVE> 
        <COND (<HELD? ,PRSO>
            ;"<COND (<=? ,PRSI <>> <TELL "[to the midget]" CR>)>"
            <COND (<IN? ,17-MIDGET ,HERE>
                <TELL ,MESSAGE-093 CR>
                <MOVE ,17-MIDGET ,LOCAL-GLOBALS>
                <MOVE ,16-SPECTACLES ,LOCAL-GLOBALS>
                <MOVE ,18-MIDGET-WITH-GLASSES ,HERE>
                <RTRUE>
            )>
            <COND (<IN? ,19-MIDGET-IN-CONVERSATION ,HERE>
                <TELL ,MESSAGE-096 CR>
                <MOVE ,19-MIDGET-IN-CONVERSATION ,LOCAL-GLOBALS>
                <MOVE ,16-SPECTACLES ,LOCAL-GLOBALS>
                <MOVE ,18-MIDGET-WITH-GLASSES ,HERE>
                <SETG ,24-MIDGET-FLAG <>>
                <RTRUE>
            )>
        )>
    )>
>

;"Object: MIDGET ---------------------------------------------------------------"
<OBJECT 17-MIDGET
	(IN 44-LAB-MO-TORIUM)
	(SYNONYM MIDGET)
    (DESC "midget with a bucket and a mop")
    (FLAGS PERSONBIT)>

<OBJECT 18-MIDGET-WITH-GLASSES
	(IN LOCAL-GLOBALS)
	(SYNONYM MIDGET)
    (ADJECTIVE SPECTACLE-WEARING)
    (DESC "spectacle-wearing midget")
    (FLAGS PERSONBIT)>

<OBJECT 19-MIDGET-IN-CONVERSATION
	(IN LOCAL-GLOBALS)
	(SYNONYM MIDGET)
    (DESC "midget involved in conversation with the statuette")
    (FLAGS PERSONBIT)>

;"Object: MAGAZINE -------------------------------------------------------------"
<OBJECT 20-MAGAZINE
	(IN 52-WAITING-ROOM)
	(SYNONYM MAGAZINE ISSUE WEEKLY)
    (ADJECTIVE MOCK PIG CARVER)
	(DESC "magazine")
    (TEXT ,MESSAGE-104)
    (FLAGS TAKEBIT READBIT)>

;"Object: BUNCH OF RODS --------------------------------------------------------"
<OBJECT 21-RODS
	(IN 49-STORAGE-ROOM)
	(SYNONYM RODS ROD)
    (ADJECTIVE BUNCH OCTAGONAL)
	(DESC "bunch of different-coloured, octagonal rods")
    (ACTION RODS-F)
    (FLAGS TAKEBIT)>

<ROUTINE RODS-F ()
    <COND (<VERB? WAVE> 
        <COND (<HELD? ,PRSO>
            <TELL ,MESSAGE-110 CR>
            <RTRUE>
        )>
    )>
>

;"Object: BLACK ROD ------------------------------------------------------------"
<OBJECT 22-BLACK-ROD
	(IN LOCAL-GLOBALS)
	(SYNONYM ROD)
    (ADJECTIVE BLACK)
	(DESC "black rod")
    (TEXT ,MESSAGE-112)
    (ACTION ROD-F)
    (FLAGS TAKEBIT)>

<ROUTINE ROD-F ()
    <COND (<VERB? WAVE> 
        <COND (<HELD? ,PRSO>
            <COND (<AND <=? ,HERE ,47-THEOBALD-HALL> <NOT <IN? ,23-BRIDGE ,HERE>>>
                <TELL ,MESSAGE-109 CR>
                <MOVE ,23-BRIDGE ,HERE>
                <RTRUE>
            )>
            <COND (<NOT <=? ,HERE ,47-THEOBALD-HALL>>
                <TELL ,MESSAGE-108 CR>
                <RTRUE>
            )>
            <COND (<AND <=? ,HERE ,47-THEOBALD-HALL> <IN? ,23-BRIDGE ,HERE>>
                <TELL ,MESSAGE-111 CR>
                <MOVE ,23-BRIDGE ,LOCAL-GLOBALS>
                <RTRUE>
            )>
        )>
    )>
>

;"Object: BRIDGE ---------------------------------------------------------------"
<OBJECT 23-BRIDGE
	(IN LOCAL-GLOBALS)
	(SYNONYM BRIDGE)
	(DESC "bridge to the north")>

;"Object: CUP OF TEA -----------------------------------------------------------"
<OBJECT 24-TEA
	(IN LOCAL-GLOBALS)
	(SYNONYM TEA)
    (ADJECTIVE CUP)
	(DESC "cup of tea")
    (ACTION TEA-F)
    (FLAGS TAKEBIT)>

<ROUTINE TEA-F ()
    <COND (<VERB? GIVE SGIVE>
        <COND (<HELD? ,PRSO>
            <COND (<AND <=? ,PRSI <>> <=? ,HERE ,55-GALLERY>> <TELL "[to Arthur Dent]" CR> <SETG ,PRSI ,ARTHUR-DENT>)>
            <COND (<AND <=? ,PRSI <>> <=? ,HERE ,62-LADDER-TOP>> <TELL "[to the Evil Prince]" CR> <SETG ,PRSI 29-EVIL-PRINCE-PIPE>)>
            <COND (<AND <=? ,HERE ,55-GALLERY> <=? ,PRSI ,ARTHUR-DENT>>
                <TELL ,MESSAGE-118 CR>
                <MOVE ,24-TEA ,LOCAL-GLOBALS> 
                <COND (<NOT ,GAME_VERSION_CLASSIC> <SETG 27-TEA-FLAG <>>)>
                <RTRUE>
            )>
            <COND (<AND <=? ,HERE ,62-LADDER-TOP> <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <=? ,28-EVIL-PRINCE-COUNTER 0> <=? ,PRSI ,29-EVIL-PRINCE-PIPE>>
                <TELL ,MESSAGE-128 CR>
                <MOVE ,24-TEA ,LOCAL-GLOBALS> 
                <SETG ,28-EVIL-PRINCE-COUNTER 1>
                <RTRUE>
            )>
            <COND (<AND <=? ,HERE ,62-LADDER-TOP> <IN? ,29-EVIL-PRINCE-PIPE ,HERE> <NOT <=? ,28-EVIL-PRINCE-COUNTER 0>> <=? ,PRSI ,29-EVIL-PRINCE-PIPE>>
                <TELL ,MESSAGE-131 CR>
                <MOVE ,24-TEA ,LOCAL-GLOBALS> 
                <SETG 28-EVIL-PRINCE-COUNTER <+ ,28-EVIL-PRINCE-COUNTER 2>>
                <RTRUE>
            )>
        )>
    )>
    <COND (<VERB? DRINK>
        <COND (<HELD? ,PRSO>
            <TELL ,MESSAGE-120 CR>
            <SETG 27-TEA-FLAG <>>
            <MOVE ,24-TEA ,LOCAL-GLOBALS>
            <RTRUE>
        )>
    )>
    <STANDARD-F> 
>

;"Object: BLACK ADDER ---------------------------------------------------------"
<OBJECT 25-ADDER
	(IN 57-ROOM-IN-CASTLE)
	(SYNONYM DUKE EDMUND ADDER)
    (ADJECTIVE BLACK)
	(DESC "Edmund, Duke of Edinburgh, also known as the Black Adder")
    (ACTION ADDER-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE ADDER-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<=? ,WINNER ,25-ADDER>
        <TELL ,MESSAGE-124 CR>
        <RTRUE>
    )>
>

;"Object: BLACK LADDER --------------------------------------------------------"
<OBJECT 26-LADDER
	(IN 57-ROOM-IN-CASTLE)
	(SYNONYM LADDER)
    (ADJECTIVE BLACK)
	(DESC "black ladder")
    (ACTION LADDER-F)
    (FLAGS TAKEBIT)>

<ROUTINE LADDER-F ()
    <COND (<VERB? TAKE> 
        <COND (<AND <=? ,HERE ,57-ROOM-IN-CASTLE> <IN? ,25-ADDER ,HERE>>
            <TELL ,MESSAGE-123 CR>
            <RTRUE>)
        >)
    >
    <COND (<VERB? DROP> 
        <COND (<AND <=? ,HERE ,44-LAB-MO-TORIUM> <IN? ,26-LADDER ,PLAYER>>
            <TELL ,MESSAGE-142 CR>
            <MOVE ,26-LADDER ,HERE>
            <RTRUE>)
        >)
    >
    <COND (<VERB? CLIMB> 
        <COND (<AND <=? ,HERE ,44-LAB-MO-TORIUM> <IN? ,26-LADDER ,HERE>>
            <DO-WALK P?UP>
            <RTRUE>)
        >)
    >
    <COND (<VERB? DESCEND> 
        <COND (<=? ,HERE ,62-LADDER-TOP>
            <DO-WALK P?DOWN>
            <RTRUE>)
        >)
    >
>

;"Object: EVIL-PRINCE ---------------------------------------------------------"
<OBJECT 28-EVIL-PRINCE
	(IN 44-LAB-MO-TORIUM)
	(SYNONYM PRINCE)
    (ADJECTIVE EVIL)
	(DESC "The Evil Prince, sitting on the edge of the vat repairing the pipe with tissues and plumber pipe jointing tape")
    (ACTION EVIL-PRINCE-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<OBJECT 29-EVIL-PRINCE-PIPE
	(IN 62-LADDER-TOP)
	(SYNONYM PRINCE)
    (ADJECTIVE EVIL)
	(DESC "The Evil Prince, sitting on the edge of the vat fiddling with the pipe")
    (ACTION EVIL-PRINCE-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE EVIL-PRINCE-F ()
    <COND (<VERB? TELL>
        <SETG ,WINNER ,PRSO>
        <RTRUE>
    )>
    <COND (<OR <=? ,WINNER ,28-EVIL-PRINCE> <=? ,WINNER ,29-EVIL-PRINCE-PIPE>>
        <TELL ,MESSAGE-122 CR>
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
    <COND (<AND <L=? <RANDOM 100> 2> <NOT <FSET? <LOC ,PLAYER> ,NDUNGEONBIT>>>
        <COND (<=? <LOC ,06-BROCHURE> ,PLAYER>
            <TELL CR ,MESSAGE-076 CR>
            <RTRUE>)
        (T
            <TELL CR ,MESSAGE-075 CR>
            <MOVE ,06-BROCHURE ,PLAYER>
            <RTRUE>
        )>)
    >
    <COND (<HELD? ,24-TEA>
        <COND (<NOT ,SCORE-GET-TEA-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-TEA-FLAG T>)>
    )>
    <COND (<HELD? ,26-LADDER>
        <COND (<NOT ,SCORE-GET-LADDER-FLAG> <SETG SCORE <+ ,SCORE 10>> <SETG SCORE-GET-LADDER-FLAG T>)>
    )>
    <COND (<AND <HELD? ,16-SPECTACLES> <FSET? ,16-SPECTACLES ,WORNBIT>>
        <COND (<G=? ,SPECTACLES-COUNTER 1> <TELL CR> <JIGS-UP ,MESSAGE-098>)>
        <SETG SPECTACLES-COUNTER <+ ,SPECTACLES-COUNTER 1>>
        <RTRUE>
    )>
> 

<ROUTINE I-DRAGON ()
    <COND (<AND <=? ,HERE ,29-CAVERN> <IN? ,09-DRAGON ,29-CAVERN> <=? ,17-DRAGON-COUNTER 0>> 
        <TELL CR ,MESSAGE-032 CR>
        <SETG ,17-DRAGON-COUNTER 1>
        <RTRUE>)
    >
    <COND (<AND <NOT <IN? ,09-DRAGON ,HERE>> <NOT <=? ,17-DRAGON-COUNTER 0>>> 
        <TELL CR ,MESSAGE-033 CR>
        <MOVE ,09-DRAGON ,HERE>
        <SETG ,17-DRAGON-COUNTER 1>
        <RTRUE>)
    >
    <COND (<=? ,17-DRAGON-COUNTER 1>
        <TELL CR ,MESSAGE-034 CR>
        <SETG ,17-DRAGON-COUNTER 2>
        <RTRUE>)
    >
    <COND (<=? ,17-DRAGON-COUNTER 2>
        <TELL CR ,MESSAGE-035 CR>
        <SETG ,17-DRAGON-COUNTER 3>
        <RTRUE>)
    >
    <COND (<=? ,17-DRAGON-COUNTER 3>
        <TELL CR>
        <JIGS-UP ,MESSAGE-036>
        <RTRUE>)
    >
>

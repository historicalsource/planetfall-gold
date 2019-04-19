"HINTS for

			 SOLID GOLD PLANETFALL
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

;"modify ROUTINE FINISH in VERBS to include Hint"
;"Check HELP or HINT syntaxes to match V-HINT (and CLOCKER-VERBS)"
;"Make sure the Flag in the V-HINTS-OFF syntax is correct"

<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINTS-OFF -1>

<CONSTANT RETURN-SEE-HINT " RETURN = see hint">
<CONSTANT RETURN-SEE-HINT-LEN <LENGTH " RETURN = see hint">>
<CONSTANT Q-MAIN-MENU "Q = main menu">
<CONSTANT Q-MAIN-MENU-LEN <LENGTH "Q = main menu">>
<CONSTANT INVISICLUES "INVISICLUES (tm)">
<CONSTANT INVISICLUES-LEN <LENGTH "INVISICLUES (tm)">>
<CONSTANT Q-SEE-HINT-MENU "Q = see hint menu">
<CONSTANT Q-SEE-HINT-MENU-LEN <LENGTH "Q = see hint menu">>
<CONSTANT Q-RESUME-STORY "Q = Resume story">
<CONSTANT Q-RESUME-STORY-LEN <LENGTH "Q = Resume story">>
<CONSTANT PREVIOUS "P = Previous">
<CONSTANT PREVIOUS-LEN <LENGTH "P = Previous">>

<GLOBAL LINE-TABLE		;"zeroth (first) element is 5"
	<PTABLE
	  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22>>

<CONSTANT COLUMN-TABLE		;"zeroth (first) element is 4"
	<PTABLE
	  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4>>

; "If the first argument is non-false, build a parallel impure table
   for storing the count of answers already seen; make it a constant
   under the given name."

<DEFINE20 CONSTRUCT-HINTS (COUNT-NAME "TUPLE" STUFF "AUX" (SS <>)
			   (HL (T)) (HLL .HL) V
			   (CL (T)) (CLL .CL)
			   TCL TCLL)
   <REPEAT ((CT 0))
     <COND (<OR <EMPTY? .STUFF>
		<TYPE? <1 .STUFF> STRING>>
	    ; "Chapter break"
	    <COND
	     (<NOT .SS>
	      ; "First one, just do setup"
	      <SET SS .STUFF>
	      <SET TCL (T)>
	      <SET TCLL .TCL>
	      <SET CT 0>)
	     (T
	      <SET V <SUBSTRUC .SS 0 <- <LENGTH .SS> <LENGTH .STUFF>>>>
	      ; "One chapter's worth"
	      <SET HLL <REST <PUTREST .HLL (<EVAL <FORM PLTABLE !.V>>)>>>
	      <COND (.COUNT-NAME
		     <SET CLL <REST <PUTREST .CLL
					     (<EVAL <FORM TABLE (BYTE)
							  !<REST .TCL>>>)>>>
		     <SET TCL (T)>
		     <SET TCLL .TCL>
		     <SET CT 0>)>
	      <SET SS .STUFF>)>
	    <COND (<EMPTY? .STUFF> <RETURN>)>
	    <SET STUFF <REST .STUFF>>)
	   (T
	    <COND (.COUNT-NAME
		   <COND (<1? <MOD <SET CT <+ .CT 1>> 2>>
			  <SET TCLL <REST <PUTREST .TCLL
						   (0)>>>)>)>
	    <SET STUFF <REST .STUFF>>)>>
   <COND (.COUNT-NAME
	  <EVAL <FORM CONSTANT .COUNT-NAME
		      <EVAL <FORM PTABLE !<REST .CL>>>>>)>
   <EVAL <FORM PLTABLE !<REST .HL>>>>

;"longest hint topic can be 17 chars"
;"longest question can be 36 chars."
;"question can't have more than 32 answers"

<CONSTANT HINTS
  <CONSTRUCT-HINTS HINT-COUNTS ;"Put topics in Quotes - followed by PLTABLEs
				 of Questions and Answers in quotes"
	
	"THE FEINSTEIN"
	<PLTABLE "How do I get past Blather?"
		 "There's no way to get beyond Deck Eight or the Reactor Lobby."
		 "Really! There's no way!">
	<PLTABLE "How can I stop getting demerits?"
		 "Scrub harder?"
		 "I wouldn't worry too much; demerits aren't that important.">
	<PLTABLE "What about Lieutenant Measle?"
		 "All he wants is some information for your records."
		 "Ahem.  Lieutenant Measle???">
	<PLTABLE "What do I do with the Ambassador?"
		 "Enjoy his company. He's just there to liven up the game opening.">
	<PLTABLE "How do I get the translator?" 
		 "You can't.">
	<PLTABLE "How do I get the celery?"
		 "You can't.">
	<PLTABLE "How do I get the Ambassador's map?"
		 "The Ambassador doesn't have any map!">
	<PLTABLE "What should I do in the Galley?"
		 "Try eating the stew."
		 "Did you find the handbook for programming autopilots?"
		 "How did you get to a nonexistent place?">
	<PLTABLE "How do I get out of the Brig?"
		 "The best way to get out is to never get thrown in."
		 "If you don't upset Blather by leaving your post, you'll never get thrown in the Brig."
		 "Once you're in the Brig, there's no way out.">
	<PLTABLE "How can I save the Feinstein?"
		 "It might be a malfunction in the Hyperspatial Jump Machinery Room."
		 "Of course, since you can't enter that room, you'll never know."
		 "There's no way to prevent it, and you won't find out until later what caused it. Best thing to do is try to survive the shipwreck.">
	<PLTABLE "Can I open the escape pod bulkhead?"
		 "It opens automatically during any emergency."
		 "For example, when the Feinstein begins exploding.">
	
	"THE POD TRIP"
	<PLTABLE "How do I control the pod?"
		 "The controls are entirely automated."
		 "Sit back and relax. Let the autopilot do the driving.">
	<PLTABLE "I keep getting killed! Help!"
		 "Are you standing?"
		 "The adjective associated with the web is notable."
		 "Get in the safety web and don't stand until you've landed.">
	<PLTABLE "Can I keep the pod from sinking?"
		 "Sorry, you can't.">
	<PLTABLE "Will I use the emergency provisions?"
		 "It's always a good idea in adventure games to take anything that you can carry.">
	<PLTABLE "Can I leave the pod after landing?"
		 "Sure. Have you tried opening the door?"
		 "You can't reach the door while you're still in the web."
		 "Once the door is open, either UP or OUT works."
		 "Needless to say, don't dally too long.">
	<PLTABLE "I keep drowning underwater. Help!"
		 "The water is a dangerous place to be. Leave it immediately."
		 "There is light filtering down from above."
		 "Say UP.">
	
	"THE DORMITORY"
	<PLTABLE "What can I do on the Balcony?"
		 "The plaque is the only thing of interest there.">
	<PLTABLE "Of what use is the ruined castle?"
		 "Not much.">
	<PLTABLE "What can I do in the Rec Area?"
		 "There are some interesting tapes and games there."
		 "Have you noticed the locked door leading north?">
	<PLTABLE "Can I unlock the door with the dial?"
		 "It's a combination lock."
		 "You could try setting it to every number from 1 to 1000."
		 "The combination can be found in the lab area."
		 "It is in the pocket of the lab uniform.">
	<PLTABLE "What use are the four dorms?"
		 "They are all identical."
		 "They make good places to sleep.">
	<PLTABLE "What about the sanitary facilities?"
		 "You won't need to use them. The game isn't THAT realistic."
		 "They are of no importance.">
	<PLTABLE "How do I open the padlock?"
		 "You'll need a key."
		 "Have you seen a \"glint of light\" anywhere while exploring?"
		 "It's in the crevice in Admin Corridor South."
		 "You can't reach it with your hands. You'll need something else."
		 "The curved metal bar."
		 "It's a magnet. Try holding it over the key.">
	<PLTABLE "How do I open the tin can?"
		 "Don't develop the next hint until you've found the can opener."
		 "There is no can opener. You must be cheating."
		 "There is no way to open the can.">
	<PLTABLE "Does the door in the Mess Hall open?"
		 "If you mean the locked door in the southern end, yes."
		 "The slot next to the door is important."
		 "You'll need the kitchen access card."
		 "It's located beyond the rift."
		 "It's in the desk in the Small Office. Slide it through the slot.">
	<PLTABLE "What is the ladder for?"
		 "It is needed to get past a major obstacle."
		 "You've probably seen the obstacle."
		 "The rift.">
	<PLTABLE "What use is the kitchen dispenser?"
		 "Have you tried pushing the button?"
		 "That liquid is food."
		 "You'll need something to catch the liquid."
		 "The octagonal shape of the niche is important."
		 "Open the canteen and put it in the niche.">
	"ADMIN/MECH AREA"
	<PLTABLE "What can I do in the Physical Plant?"
		 "Nothing."
		 "It's there just for show. Every large complex of buildings needs one.">
	<PLTABLE "Is the crack in the floor important?"
		 "Yes.">
	<PLTABLE "Is the deactivated robot important?"
		 "Yes, indeed!"
		 "Turn it on.">
	<PLTABLE "How do I run the reactor elevator?"
		 "The slot in the elevator is important."
		 "You'll need the reactor elevator access pass."
		 "Don't develop further until you've been on the helicopter trip."
		 "Cheating again, eh?  There's no way to operate that elevator.">
	<PLTABLE "How do I fix the reactors?"
		 "Have you opened the repair panel?"
		 "Some of the megafuses seem to be burned out."
		 "Try replacing the megafuses with the good ones from the box in Storage East."
		 "Oh, come now. You haven't been to the reactors, have you?">
	<PLTABLE "How do I cross the rift?"
		 "Jumping is a bad idea."
		 "You'll need an item which you may not have seen yet."
		 "It's behind the padlocked door."
		 "Extend the ladder and put it across the rift.">
	<PLTABLE "How can I see in the darkened area?"
		 "You'll need a light source.">
	<PLTABLE "What is the chemical dispenser for?"
		 "Have you tried pushing any of the buttons on it?"
		 "The flask can be used to hold the chemical fluid."
		 "The first seven buttons are obviously coolants and catalysts."
		 "The two white buttons produce an acid and a base."
		 "You'll need the coolants and catalysts for the Comm Room problem.">
	<PLTABLE "What do I do with the acid and base?"
		 "Batteries are made out of acids and bases."
		 "Have you run into any dangerous creatures?  You might be able to use the acid or base as a weapon."
		 "Actually, these two chemicals are totally useless.">
	<PLTABLE "Can I fix the disassembled robots?"
		 "A repair robot might be of help."
		 "Don't go on until you've repaired Achilles."
		 "There's no way to reassemble those robots.">
	<PLTABLE "What about the Plan Room?"
		 "There's nothing for you to do in there, but you might pick up some useful information there.">
	<PLTABLE "What about the Systems Monitors?"
		 "There's nothing for you to do in there, but you might pick up some useful information there.">
	<PLTABLE "Is there any way to take the hose?"
		 "What hose?">
		
     	"ELEVATORS/TOWER"
	<PLTABLE "Can I open the Elevator Lobby doors?"
		 "Try pushing the red and blue buttons."
		 "Then wait a little while.">
	<PLTABLE "How do the elevators work?"
		 "The slot on the control panels is important."
		 "You'll need to find the respective access passes."
		 "When you find them, slide them through the slot, and then say PUSH UP BUTTON or PUSH DOWN BUTTON."
		 "The upper elevator access card is located beyond the rift."
		 "It's in the desk in the Small Office."
		 "Floyd has the lower elevator access card."
		 "He may give it to you when you use another access card in his presence. Alternately, you can turn him off and search him.">
	<PLTABLE "What is the Helipad for?"
		 "The helicopters probably land and take off from there.">
	<PLTABLE "How do I enter the Helicopter?"
		 "Try ENTER THE HELICOPTER.">
	<PLTABLE "TELL ME ABOUT THE OBSERVATION DECK"
		 "Nice view of another complex of buildings on a nearby island.">
	<PLTABLE "Should I do anything with the birds?"
		 "Try feeding them."
		 "Birds like insects."
		 "What birds?  What insects?">
	<PLTABLE "What is the comm. receive console?"
		 "Try pressing the button on it."
		 "Apparently, it received a transmission from the Feinstein just before the ship blew up.">
	<PLTABLE "What is the comm. send console?"
		 "Read the screen. The message is very interesting."
		 "The message isn't being sent, however."
		 "You can repair the communication system using the chemical dispenser in the Machine Shop."
		 "The colored light on the enunciator panel refers to one of the colored buttons on the dispenser."
		 "Keep pouring the proper chemical fluid into the hole on the console until it is fixed.  It will take anywhere from three to five trips.">
	
	"HELICOPTER TRIP"
	<PLTABLE "Where do I find the helicopter?"
		 "You need to use the upper elevator to get to it.">
	<PLTABLE "How do I unlock the control panel?"
		 "Try reading the green spool using the microfilm reader."
		 "According to the spool, you'll find a key in Transportation Supply.">
	<PLTABLE "Where is the helicopter access card?"
		 "Try reading the green spool using the microfilm reader."
		 "According to the spool, the card would be in Transportation Supply.">
	<PLTABLE "How do I use the helicopter?"
		 "Unless you have the helicopter control panel key and the helicopter access card, don't read any further."
		 "Use the key to open the control panel cover."
		 "Use the access card to activate the controls."
		 "Just tell your intended destination to the voice-controlled autopilot, then sit back and enjoy the trip."
		 "Amazing feat, your managing to get this far, considering the key and card don't exist.">
	<PLTABLE "What destination should I select?"
		 "Where would you expect to find people?"
		 "A large city, perhaps?"
		 "Try the capital city of Resida, Pilandoor."
		 "Don't you feel pretty silly, considering there's no way to even get the helicopter off the ground?">

	"SHUTTLE TRIP"
	<PLTABLE "Where do I find the shuttle?"
		 "You need to use the lower elevator to get to it.">
	<PLTABLE "How do I operate the shuttle?"
		 "You'll need the shuttle access card.  By now you should know how to use these cards."
		 "You can't operate the shuttle after 6000."
		 "Hopefully, you can figure out that you want to be in the control cabin facing the set of tracks, not the one facing the blank wall.">
	<PLTABLE "How do I use the shuttle controls?"
                 "First, activate the controls (see previous question)."
		 "Pushing the lever up into the \"+\" position causes the shuttle to accelerate. Pulling the lever down into the \"-\" position causes the shuttle to decelerate."
		 "When the lever is in the central position, the shuttle will continue to move at its current velocity."
		 "The digital display tells the current velocity of the shuttle.">
	<PLTABLE "I always crash at the other station!"
		 "You're going too fast. Decelerate sooner."
		 "If you're going faster than 20 when you get to the far station, you'll be killed."
		 "If you're going between 5 and 20 you will survive, but the shuttle will be damaged.">

	"SYSTEMS/LIBRARY"
	<PLTABLE "What is the medicine for?"
		 "Read the label.">
	<PLTABLE "The Repair Room door is too small!" 
		 "It's too small for YOU to get through."
                 "It's \"robot-sized\"."
		 "Ask Floyd to go through the doorway.">
	<PLTABLE "Do the Repair Room cabinets open?"
		 "You'll have to repair Achilles first.">
	<PLTABLE "How can I repair Achilles?"
		 "Waldo won't be of any help (unless you're playing SUSPENDED)."
		 "Try using the microfilm reader to read the brown spool."
		 "The brown spool is in the Radiation Lab."
		 "Unfortunately, there's no way to get the brown spool to the microfilm reader."
		 "There is also no way to repair Achilles.">
	<PLTABLE "Is there a good fromitz board?"
		 "Yes."
		 "Have you been beyond the small door in the Repair Room?"
		 "You'll have to ask Floyd to get the good fromitz board.">
	<PLTABLE "Is there a good bedistor anywhere?"
		 "Yes."
		 "It's in Storage East, just off Mech Corridor North. If you missed it, you'd better improve your exploring and mapping abilities.">
	<PLTABLE "TELL ME ABOUT PLANETARY DEFENSE"
		 "The library might tell you something."
		 "Apparently, it is an automatic meteor defense. Perhaps this solar system has a high meteor density."
		 "The system's discrimination circuit seems to have failed."
		 "This is probably why the Feinstein was destroyed. You'd better repair it."
		 "Open the access panel."
		 "Figure out which board is malfunctioning and remove it."
		 "It's the second board. Take it and put the good fromitz board in the resulting empty socket.">
	<PLTABLE "TELL ME ABOUT THE COURSE CONTROL"
		 "The library might tell you something about it."
		 "Apparently, the entire planet was moved into a more favorable but less stable orbit. This system ensures that the planet stays in the proper orbit."
		 "The course control system seems to be malfunctioning. If the planet was approaching its sun, it would explain the melting ice caps and water level rise."
		 "You'd better repair this system."
		 "Try opening the cube and removing the fused bedistor."
		 "You'll need a tool."
		 "Use the pliers from the Tool Room to remove the fused bedistor."
		 "Put the good bedistor into the cube.">
	<PLTABLE "Why is this Physical Plant so big?"
		 "True, this plant is larger than its counterpart in the Kalamontee Complex, even though the Lawanda Complex is slightly smaller."
		 "Perhaps there is a large section of the Lawanda Compex that you haven't seen yet..."
		 "...such as the cryo-chambers, buried deep underground.">
	<PLTABLE "How do I use the computer terminal?"
		 "Firstly, turn it on."
		 "To select an item in the menu, use the TYPE command. For example, to select item 2, type TYPE 2."
		 "Typing TYPE 0 returns you to the next highest menu level (except, of course, if you are at the Main Menu, which is the highest level).">
	<PLTABLE "How do I use the microfilm reader?"
		 "It must be turned on."
		 "The colored spools are spools of microfilm."
		 "Put one in the opening in the reader.">
	<PLTABLE "How do I summon the librarian?"
		 "You can't."
		 "Really!">
	"PROJCON AND LAB"
	<PLTABLE "What is the signficance of SanFac F?"
		 "Haven't you realized by now that these SanFacs are of no interest?">
	<PLTABLE "What about the ProjCon Office?"
		 "The library might be of some help."
		 "It was the main office for the Project.">
	<PLTABLE "Is the logo important?"
		 "It also appears on the lab uniform."
		 "It's yet another little hint about what's going on.">
	<PLTABLE "Is the mural important?"
		 "Examination reveals that there might be an area behind it."
		 "But don't worry about it now."
		 "When the time comes, you'll know it.">
	<PLTABLE "Who is Burstini Bonz?"
		 "Wasn't he the great Respectivist artist who became famous for painting awesomely phenomenal murals during the 89th century?">
	<PLTABLE "What is the laboratory area for?"
		 "The library might have some information on that."
		 "It is the laboratory built to find a cure for the Disease.">
	<PLTABLE "Is the Bio-Lab safe to enter?"
		 "Try it."
		 "Nope, I guess it wasn't. Hope you did a SAVE first.">
	<PLTABLE "Is the Radiation Lab safe to enter?"
		 "Try it."
		 "Nope, I guess you can't. Hope you did a SAVE first.">
	<PLTABLE "Where is the radiation suit?"
		 "It might be down near the Reactors."
		 "Find a light source, then use the Reactor Access Stairs."
		 "There's a lamp in the Radiation Lab."
		 "Going in circles? There's no radiation suit anywhere.">
	<PLTABLE "What is the card in the Bio-Lab?"
		 "Floyd will tell you when he sees it."
		 "It's for the Miniaturization Booth.">
	<PLTABLE "Can I get the card from the Bio-Lab?"
		 "You'll die trying."
		 "Floyd's a robot. He might be tougher."
		 "He'll volunteer to get the card if he has a good enough reason."
		 "Do you know what the card is and what you would use it for?"
		 "The Miniaturization Booth is for repairing the Computer."
		 "Show Floyd the computer printout, or let him see the warning light in the Computer Room."
                 "Then take him into Bio-Lock East and do what he says.">
	
	"COMPUTER/ENDGAME"
	<PLTABLE "What does the computer do?"
		 "The library might have something on it."
		 "It runs the automated Project..."
		 "...which is trying to find a cure for the Disease.">
	<PLTABLE "Is the printout important?"
		 "It appears that the Project was incredibly close to a successful conclusion."
		 "Then the computer broke down."
		 "If you've been in the Repair Room, you'll know that summoning the repair robot didn't help."
		 "You'll have to fix the computer yourself."
		 "Use the Miniaturization Booth.">
	<PLTABLE "Does the Miniaturization Booth work?"
		 "You'll need the proper access card, of course."
		 "It's in the Bio-Lab."
		 "Once you've activated the booth, type the damaged sector number."
		 "Have you read the printout?"
		 "The damaged sector is 384. Type TYPE 384."
		 "You will then be miniaturized and teleported into the damaged sector, where you can attempt to effect repairs.">
	<PLTABLE "I am at Station 384. What now?"
		 "Explore around."
		 "Have you seen and examined the relay?"
		 "You'll have to figure out a way to remove the speck."
		 "The laser."
		 "You must destroy the speck without harming the relay."
		 "The dial must be set to 1, so that the beam will pass harmlessly through the red translucent exterior of the relay."
		 "You'll have to shoot the speck a number of times to destroy it.">
	<PLTABLE "Can I talk to the giant spider?"
		 "Yes."
		 "Play STARCROSS.">
	<PLTABLE "How do I get past the giant microbe?"
		 "Try shooting it with the laser."
		 "That won't have any effect while the laser is set to 1, of course."
		 "If you don't keep shooting the microbe, it will get close enough to eat you."
		 "Repeated shootings of the microbe merely hold it at bay, and sooner or later you're killed when sector 384 comes to life."
		 "Has the microbe become interested in anything besides you?"
		 "The microbe is attracted to the warmth of the laser."
		 "When the laser gets warm enough, throw it over the edge of the strip, into the void below. The microbe will leap after it.">
	<PLTABLE "How do I get back from the Strip?"
		 "Go to Station 384.">
	<PLTABLE "How do I get out of the Lab Office?"
		 "Opening the door right off isn't a healthy idea."
		 "There are some buttons on the wall..."
		 "To get a clue, search the desk."
		 "Have you opened the desk?"
		 "Put on the gas mask, then press the red button."
		 "Then, move fast. You don't have a millichron to spare.">
	<PLTABLE "How do I get rid of the mutants?"
		 "You can't kill them."
		 "There's only one way to lose them."
		 "You're very close to the end of the game."
		 "Did you hear an announcement?"
		 "Remember the mural?"
		 "Go to the ProjCon Office."
		 "Go south into the elevator and push the button.">

	"GENERAL QUESTIONS"
	<PLTABLE "What do I do with my ID card?"
		 "It's useless.">
	<PLTABLE "Why did my things go when I slept?"
		 "Do you normally go to sleep holding things? You dropped them while you were sleeping. Check the floor of the room where you slept.">
	<PLTABLE "How do I read the native language?"
		 "It's actually a phonetic version of English."
		 "\"X\" is used in place of \"TH\" and \"C\" is used in place of \"CH\"."
		 "Double vowels signify the long vowel sound, and single vowels indicate the short vowel sound.">
	<PLTABLE "I keep starving to death. Feed me!"
		 "Didn't you take the survival kit from the safety pod?"
		 "Of course, that doesn't last long."
		 "There's a can of spam and eggs in Storage West."
		 "Unfortunately, there's no way to open it."
		 "You'll have to get into the Kitchen."
		 "It's just south of the Mess Hall.">
	<PLTABLE "Where can I sleep?"
		 "Civilized people usually sleep in beds."
		 "If you sleep elsewhere, you might be devoured (by grues?)."
		 "There are beds in the four dorms, and the Infirmary."
		 "Of course, the bed in the Infirmary is a bad idea for other reasons.">
	<PLTABLE "Where can I find a light source?"
		 "Have you tried burning the towel?"
		 "Okay, that didn't work. There IS a lantern somewhere."
		 "It's in the Radiation Lab."
		 "You can't enter the Radiation Lab and survive without a radiation suit."
		 "There is no radiation suit."
		 "There is no way to get a light source into the dark rooms.">
	<PLTABLE "What is a grue?"
		 "Ask the game.">
	<PLTABLE "Do the teleportation booths work?"
		 "Of course! But you'll have to find the teleportation access card first."
		 "It's in the lab area, which you may not have been to yet."
		 "It's in the pocket of the lab uniform."
		 "Slide the card thru the slot, then press the button corresponding to the booth you want to teleport to.">
	<PLTABLE "How does the laser work?"
		 "You must be holding it to fire it."
		 "It has six settings. Each setting produces a different colored beam."
		 "The battery in it when you find it won't last very long."
		 "You'll need a fresh battery."
		 "Open the laser, remove the old battery, and put the new battery in.">
	<PLTABLE "Where do I find a new laser battery?"
		 "Have you tried making one?"
		 "Some batteries are made by mixing acids and bases."
		 "However, there's no way to make your own battery. There is a fresh battery lying around somewhere."
                 "It's in Lab Storage.">
	<PLTABLE "What are megafuses for?"
		 "They're electrical components."
		 "They're usually used for repairing Reactor systems.">
	<PLTABLE "What are fromitz boards for?"
		 "They're electrical components."
		 "They're usually used for repairing Planetary Defense systems.">
	<PLTABLE "What are bedistors for?"
		 "They're electrical components."
		 "They're usually used for repairing Course Control systems.">
	<PLTABLE "Doctor, doctor! Why am I so sick?"
		 "You'll find out when you get to the Library."
		 "You have contracted the Disease. It is fatal."
		 "The medicine in the Infirmary might help a bit."
		 "But your only long-term hope is to help bring the Project to its ultimate goal.">
	<PLTABLE "I finished, but without 80 points!"
		 "You didn't repair all the broken systems."
		 "Consult the Systems Monitors."
		 "You must repair the Communication System, the Planetary Defense System, and the Course Control System in order to get the optimum ending.">
	<PLTABLE "How can I talk to Floyd?"
		 "He has to be on, of course."
		 "Talk to him the same way you would talk to any other character in the game: FLOYD, EAT THE CAKE (for example).">
	 "MISCELLANEOUS"
	 <PLTABLE "How to get all 80 points" 
		  "This section should only be used as a last resort, or for your own interest after you've completed PLANETFALL."
		  "3 points for entering the Escape Pod."
		  "3 points for entering the Crag."
		  "2 points for turning Floyd on for the first time."
		  "2 points for firing the laser for the first time."
		  "4 points for entering Storage West."
		  "4 points for entering Admin Corridor North."
		  "4 points for entering the Kitchen."
		  "4 points for entering the Tower Core."
		  "4 points for entering the Kalamontee Platform."
		  "4 points for entering the Lawanda Platform."
                  "1 point for taking the kitchen access card."
		  "1 point for taking the shuttle access card."
		  "1 point for taking the upper elevator access card."
		  "1 point for taking the lower elevator access card."
		  "1 point for taking the miniaturization access card."
		  "2 points for Floyd's death."
		  "6 points for fixing the communications system."
		  "6 points for fixing the planetary defense system."
		  "6 points for fixing the course control system."
		  "4 points for entering the Strip Near Station."
		  "4 points for entering the Auxiliary Booth."
		  "8 points for fixing the computer."
		  "5 points for entering the Cryo-Elevator.">
	 <PLTABLE "Have you tried...?"
		  "Don't expose these amusing suggestions until you've finished Planetfall. They may give away the answers to puzzles in the game."
		  "Reading the graffiti in the Brig?"
		  "Attacking, talking to, or throwing something at Blather?"
		  "Attacking or talking to the ambassador?"
		  "Touching, eating, smelling, or looking at the slime?"
		  "Scrubbing the slime?"
		  "Eating the celery?"
		  "Examining the games and tapes in the Rec Area?"
		  "Looking under the table in the Mess Hall?"
		  "Kicking, attacking, rubbing, or kissing Floyd?"
		  "Throwing acid at the mutants?"
		  "Reading your chronometer?"
		  "Taking off your chronometer or pouring acid on it?"
		  "Getting into bed in the Infirmary?"
		  "Scrubbing yourself?"
		  "Reading the towel?"
		  "Removing your uniform while Blather or Floyd are present?"
		  "Destroying the mural?"
		  "\"Stealing\" the lower elevator card from Floyd and then showing it to him?"
		  "Giving Floyd the Lazarus breast plate?"
		  "Typing ZORK?">>>

<GLOBAL CUR-POS 0>	;"determines where to place the highlight cursor
			  Can go up to 17 Questions"

<GLOBAL QUEST-NUM 1>    ;"shows in HINT-TBL ltable which QUESTION it's on"

<GLOBAL CHAPT-NUM 1>	;"shows in HINT-TBL ltable which CHAPTER it's on"

<CONSTANT DIROUT-TBL
	  <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 >>

<ROUTINE V-HINTS-NO ()
	<COND (<NOT <PRSO? ,ROOMS>>
	       <TELL "I don't understand what you mean." CR>)
	      (T
	       <SETG HINTS-OFF T>
	       <TELL "[Hints have been disallowed for this session.]" CR>)>
	<RFATAL>>

<ROUTINE V-HINT ("AUX" CHR MAXC (C <>) Q (WHO <>))
  <COND (<==? ,HINTS-OFF -1>
	 <SETG HINTS-OFF 0>
	 <TELL
"[Warning: It is recognized that the temptation for help may at times be so
exceedingly strong that you might fetch hints prematurely. Therefore, you may
at any time during the story type HINTS OFF, and this will disallow the
seeking out of help for the present session of the story. If you still want a
hint now, indicate HINT.]" CR>
	 <RFATAL>)
	(,HINTS-OFF
	 <PERFORM ,V?HINTS-NO ,ROOMS>
	 <RFATAL>)>
  ;<IFSOUND <SETG SOUND-QUEUED? <>>
	   <KILL-SOUNDS>>
  <SET MAXC <GET ,HINTS 0>>
  <INIT-HINT-SCREEN>
  <CURSET 5 1>
  <PUT-UP-CHAPTERS>
  <SETG CUR-POS <- ,CHAPT-NUM 1>>
  <NEW-CURSOR>
  <REPEAT ()
	  <SET CHR <INPUT 1>>
	  <COND (<EQUAL? .CHR !\Q !\q>
		 <SET Q T>
		 <RETURN>)
		(<EQUAL? .CHR !\N !\n>
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
		(<EQUAL? .CHR !\P !\p>
		 <ERASE-CURSOR>
		 <COND (<EQUAL? ,CHAPT-NUM 1>
			<SETG CHAPT-NUM .MAXC>
			<SETG CUR-POS <- .MAXC 1>>)
		       (T
			<SETG CUR-POS <- ,CUR-POS 1>>
			<SETG CHAPT-NUM <- ,CHAPT-NUM 1>>)>
		 <SETG QUEST-NUM 1>
		 <NEW-CURSOR>)
		(<EQUAL? .CHR 13 10>
		 <PICK-QUESTION>
		 <RETURN>)>>
  <COND (<NOT .Q>
	 <AGAIN>	;"AGAIN does whole routine?")>
  <CLEAR -1>
  <INIT-STATUS-LINE>
  <TELL "Back to the story ..." CR>
  ;<IFSOUND <COND (,SOUND-ON?
		  <CHECK-LOOPING>)>>
  <RFATAL>>

<ROUTINE PICK-QUESTION ("AUX" CHR MAXQ (Q <>))
  <INIT-HINT-SCREEN <>>
  <LEFT-LINE 3 ,RETURN-SEE-HINT ,RETURN-SEE-HINT-LEN>
  <RIGHT-LINE 3 ,Q-MAIN-MENU ,Q-MAIN-MENU-LEN>
  <SET MAXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
  <CURSET 5 1>
  <PUT-UP-QUESTIONS>
  <SETG CUR-POS <- ,QUEST-NUM 1>>
  <NEW-CURSOR>
  <REPEAT ()
    <SET CHR <INPUT 1>>
    <COND (<EQUAL? .CHR !\Q !\q>
	   <SET Q T>
	   <RETURN>)
	  (<EQUAL? .CHR !\N !\n>
	   <ERASE-CURSOR>
	   <COND (<EQUAL? ,QUEST-NUM .MAXQ> ; "Wrap around on N"
		  <SETG CUR-POS 0>
		  <SETG QUEST-NUM 1>)
		 (T
		  <SETG CUR-POS <+ ,CUR-POS 1>>
		  <SETG QUEST-NUM <+ ,QUEST-NUM 1>>)>
	   <NEW-CURSOR>)
	  (<EQUAL? .CHR !\P !\p>
	   <ERASE-CURSOR>
	   <COND (<EQUAL? ,QUEST-NUM 1>
		  <SETG QUEST-NUM .MAXQ>
		  <SETG CUR-POS <- .MAXQ 1>>)
		 (T
		  <SETG CUR-POS <- ,CUR-POS 1>>
		  <SETG QUEST-NUM <- ,QUEST-NUM 1>>)>
	   <NEW-CURSOR>)
	  (<EQUAL? .CHR 13 10>
	   <DISPLAY-HINT>
	   <RETURN>)>>
  <COND (<NOT .Q>
	 <AGAIN>)>>

<ROUTINE ERASE-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2>>
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

<ROUTINE DISPLAY-HINT ("AUX" H MX (CNT 2) CHR (FLG T) N CV
			  SHIFT? COUNT-OFFS)
  <CLEAR -1>
  <SPLIT 3>
  <SCREEN ,S-WINDOW>
  <CURSET 1 1>
  <INVERSE-LINE>
  <CENTER-LINE 1 ,INVISICLUES ,INVISICLUES-LEN>
  <CURSET 3 1>
  <INVERSE-LINE>
  <LEFT-LINE 3 "RETURN = see new hint">
  <RIGHT-LINE 3 ,Q-SEE-HINT-MENU ,Q-SEE-HINT-MENU-LEN>
  <CURSET 2 1>
  <INVERSE-LINE>
  <HLIGHT ,H-BOLD>
  <SET H <GET <GET ,HINTS ,CHAPT-NUM> <+ ,QUEST-NUM 1>>>
  ; "Byte table to use for showing questions already seen"
  ; "Actually a nibble table.  The high four bits of each byte are for
     quest-num odd; the low for bits are for quest-num even.  See SHIFT?
     and COUNT-OFFS."
  <SET CV <GET ,HINT-COUNTS <- ,CHAPT-NUM 1>>>
  <CENTER-LINE 2 <GET .H 1>>
  <HLIGHT ,H-NORMAL>
  <SET MX <GET .H 0>>
  <SCREEN ,S-TEXT>
  <CRLF>
  <SET SHIFT? <MOD ,QUEST-NUM 2>>
  <SET COUNT-OFFS </ <- ,QUEST-NUM 1> 2>>
  <REPEAT ((CURCX <GETB .CV .COUNT-OFFS>)
	   (CURC <+ 2 <ANDB <COND (.SHIFT? <LSH .CURCX -4>)
				  (T .CURCX)> *17*>>))
    <COND (<==? .CNT .CURC>
	   <RETURN>)
	  (T
	   <TELL <GET .H .CNT> CR>
	   <SET CNT <+ .CNT 1>>)>>
  <REPEAT ()
     <COND (<AND .FLG <G? .CNT .MX>>
	    <SET FLG <>>
	    <TELL "[That's all.]" CR>)
	   (.FLG
	    <SET N <+ <- .MX .CNT> 1>>
	    <TELL "[" N .N " hint">
	    <COND (<NOT <EQUAL? .N 1>>
		   <TELL "s">)>
	    <TELL " left.] -> ">
	    <SET FLG <>>)>
     <SET CHR <INPUT 1>>
     <COND (<EQUAL? .CHR !\Q !\q>
	    <COND (.SHIFT?
		   <PUTB .CV .COUNT-OFFS
			 <ORB <ANDB <GETB .CV .COUNT-OFFS> *17*>
			      <LSH <- .CNT 2> 4>>>)
		  (T
		   <PUTB .CV .COUNT-OFFS
			 <ORB <ANDB <GETB .CV .COUNT-OFFS> *360*>
			      <- .CNT 2>>>)>
	    <RETURN>)
	   (<EQUAL? .CHR 13 10>
	    <COND (<L=? .CNT .MX>
		   <SET FLG T>	;".cnt starts as 2"
		   <TELL <GET .H .CNT> CR>
		   ; "3rd = line 7, 4th = line 9, ect"
		   <COND (<G? <SET CNT <+ .CNT 1>> .MX>
			  <SET FLG <>>
			  <TELL "[Final hint]" CR>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS ("AUX" (ST 1) MXQ MXL)
  <SET MXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
  <SET MXL <- <LOWCORE SCRV> 1>>
  <REPEAT ()
	  <COND (<G? .ST .MXQ>
		 <RETURN>)
		(T                        ;"zeroth"
		 <CURSET <GET ,LINE-TABLE <- .ST 1>>
				<- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
	  <TELL " " <GET <GET <GET ,HINTS ,CHAPT-NUM> <+ .ST 1>> 1>>
	  <SET ST <+ .ST 1>>>>

<ROUTINE PUT-UP-CHAPTERS ("AUX" (ST 1) MXC MXL)
  <SET MXC <GET ,HINTS 0>>
  <SET MXL <- <LOWCORE SCRV> 1>>
  <REPEAT ()
    <COND (<G? .ST .MXC>
	   <RETURN>)
	  (T                        ;"zeroth"
	   <CURSET
	    <GET ,LINE-TABLE <- .ST 1>>
	    <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
    <TELL " " <GET <GET ,HINTS .ST> 1>>
    <SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T))
  <CLEAR -1>
  <SPLIT <- <LOWCORE SCRV> 1>>
  <SCREEN ,S-WINDOW>
  <CURSET 1 1>
  <INVERSE-LINE>
  <CURSET 2 1>
  <INVERSE-LINE>
  <CURSET 3 1>
  <INVERSE-LINE>
  <CENTER-LINE 1 ,INVISICLUES ,INVISICLUES-LEN>
  <LEFT-LINE 2 " N = Next">
  <RIGHT-LINE 2 ,PREVIOUS ,PREVIOUS-LEN>
  <COND (.THIRD
	 <LEFT-LINE 3 " RETURN = See hint">
	 <RIGHT-LINE 3 ,Q-RESUME-STORY ,Q-RESUME-STORY-LEN>)>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
  <COND (<ZERO? .LEN>
	 <DIROUT ,D-TABLE-ON ,DIROUT-TBL>
	 <TELL .STR>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,DIROUT-TBL 0>>)>
  <CURSET .LN </ <- <LOWCORE SCRH> .LEN> 2>>
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
OW
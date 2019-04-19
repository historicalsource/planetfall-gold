"MISC for PLANETFALL
(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

<DEFMAC RMGL-SIZE ('TBL)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM - <FORM / <FORM PTSIZE .TBL> 2> 1>)
	      (T <FORM - <FORM PTSIZE .TBL> 1>)>>

<GLOBAL P-MULT <>>
<GLOBAL P-NOT-HERE <>>

"old MACROS file"

<SETG C-ENABLED? 0>
<SETG C-ENABLED 1>
<SETG C-DISABLED 0>
<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

;<DEFMAC VERB? ("TUPLE" ATMS "AUX" (O ()) (L ())) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				     (ELSE <FORM OR !.O>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<FORM GVAL <PARSE <STRING "V?" <SPNAME .ATM>>>>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O (<FORM EQUAL? ',PRSA !.L> !.O)>
		<SET L ()>>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	 <FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;<ROUTINE ZPROB (BASE)
	 <G? .BASE <RANDOM 300>>>

<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

^L

"old MAIN or VERMONT file"

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<GLOBAL WINNER <>>

<GLOBAL HOST:NUMBER 0> "Host machine."
<GLOBAL WIDTH:NUMBER 0> "Width of screen in chars."

<ROUTINE GO () 
	 <SETG HOST <LOWCORE INTID>>
	 <SETG WIDTH <LOWCORE SCRH>>
	 ;<PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <ENABLE <QUEUE I-BLATHER -1>>
	 <ENABLE <QUEUE I-AMBASSADOR -1>>
	 <ENABLE <QUEUE I-RANDOM-INTERRUPTS 1>>
	 <ENABLE <QUEUE I-SLEEP-WARNINGS 3600>>
	 <ENABLE <QUEUE I-HUNGER-WARNINGS 2000>>
	 <ENABLE <QUEUE I-SICKNESS-WARNINGS 1000>>
;"set up and go"
	 <SETG SPOUT-PLACED ,GROUND>
	 ;"following COND avoids random-before-first-read message in ZIP20"
	 <COND (<EQUAL? <GETB 0 56> 0>
		<SETG INTERNAL-MOVES <+ 4450 <RANDOM 180>>>)
	       (T
		<SETG INTERNAL-MOVES 4540>)>
         <SETG MOVES ,INTERNAL-MOVES>
	 <SETG LIT T>
	 <SETG WINNER ,ADVENTURER>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <SETG HERE ,DECK-NINE>
	 <UPDATE-STATUS-LINE>
         <SETG P-IT-LOC ,DECK-NINE>
	 <SETG P-IT-OBJECT ,POD-DOOR>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<V-VERSION>
		<CRLF>
		<TELL
"Another routine day of drudgery aboard the Stellar Patrol Ship Feinstein.
This morning's assignment for a certain lowly Ensign Seventh Class: scrubbing
the filthy metal deck at the port end of Level Nine. With your Patrol-issue
self-contained multi-purpose all-weather scrub brush you shine the floor with
a diligence born of the knowledge that at any moment dreaded Ensign First
Class Blather, the bane of your shipboard existence, could appear." CR CR>)>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE I-RANDOM-INTERRUPTS ()
	 <ENABLE <QUEUE I-BLOWUP-FEINSTEIN <+ <RANDOM 90> 240>>>
	 <COMM-SETUP> ;"sets up comm system and laser values"
	 <SETG NUMBER-NEEDED <RANDOM 1000>>>

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP)
  <SETG C-ELAPSED ,C-ELAPSED-DEFAULT>
  <SET CNT 0>
  <SET OBJ <>>
  <SET PTBL T>
  <COND (<SETG P-WON <PARSER>>
	 <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	 <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	 <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		<SET TMP <>>
		<REPEAT ()
    	 	 <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			<RETURN>)
		       (T
			<COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
			       <COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
			       <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
			       <SET TMP T>
			       <RETURN>)>)>>
		<COND (<NOT .TMP>
		       <SET CNT 0>
		       <REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
				      <COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
				      <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
				      <RETURN>)>)>>)>
		<SET CNT 0>)>
	 <SET NUM <COND (<0? .OCNT> .OCNT)
			(<G? .OCNT 1>
			 <SET TBL ,P-PRSO>
			 <COND (<0? .ICNT> <SET OBJ <>>)
			       (T <SET OBJ <GET ,P-PRSI 1>>)>
			 .OCNT)
			(<G? .ICNT 1>
			 <SET PTBL <>>
			 <SET TBL ,P-PRSI>
			 <SET OBJ <GET ,P-PRSO 1>>
			 .ICNT)
			(T 1)>>
	 <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	 <COND (<==? ,PRSA ,V?WALK> <SET V <PERFORM-PRSA ,PRSO>>)
	       (<0? .NUM>
		<COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
		       <SET V <PERFORM-PRSA>>
		       <SETG PRSO <>>)
		      (<NOT ,LIT>
		       <TELL ,TOO-DARK CR>
		       <STOP>)
		      (T
		       <TELL "There isn't anything to ">
		       <SET TMP <GET ,P-ITBL ,P-VERBN>>
		       <COND (<OR ,P-OFLAG ,P-MERGED>
			      <PRINTB <GET .TMP 0>>)
			     (T
			      <WORD-PRINT <GETB .TMP 2>
					  <GETB .TMP 3>>)>
		       <TELL "!" CR>
		       <SET V <>>
		       <STOP>)>)
	       (T
		<SETG P-NOT-HERE 0>
		<SETG P-MULT <>>
		<COND (<G? .NUM 1>
		       <SETG P-MULT T>)>
		<SET TMP <>>
		<REPEAT ()
	         <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			<COND (<G? ,P-NOT-HERE 0>
			       <TELL "[The ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
				      <TELL "other ">)>
			       <TELL "object">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "s">)>
			       <TELL " that you mentioned ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "are">)
				     (T <TELL "is">)>
			       <TELL "n't here.]" CR>)
			      (<NOT .TMP>
			       <TELL "There's nothing there." CR>)>
			<RETURN>)
		       (T
			<COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
			      (T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			<SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
			<SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
			<COND (<OR <G? .NUM 1>
				   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
					   ,W?ALL>>
			       <COND (<DONT-ALL .OBJ1>
				      <AGAIN>)
				     (T
				      <COND (<EQUAL? .OBJ1 ,IT>
					     <PRINTD ,P-IT-OBJECT>)
					    (T <PRINTD .OBJ1>)>
				      <TELL ": ">)>)>
			<SET TMP T>
			<SET V <PERFORM-PRSA ,PRSO ,PRSI>>
			<COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	 <COND (<EQUAL? .V ,M-FATAL>
		<SETG P-CONT <>>)>
	 <COND (<AND <CLOCKER-VERB? ,PRSA>
		     <NOT <VERB? TELL>>
		     ,P-WON>
		<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>)
	(T
	 <SETG P-CONT <>>)> 
  <COND (<NOT <EQUAL? <GET <INT I-POD-TRIP> ,C-ENABLED?> 0>>
	 <SETG C-ELAPSED 54>)
        (<G? ,SHUTTLE-VELOCITY 0>
         <SETG C-ELAPSED </ 600 ,SHUTTLE-VELOCITY>>)
	(<OR <VERB? TELL>
	     <NOT <CLOCKER-VERB? ,PRSA>>>
	 <SETG C-ELAPSED 0>)>
  <SETG INTERNAL-MOVES <+ ,INTERNAL-MOVES ,C-ELAPSED>>
  <COND (<NOT <IN? ,CHRONOMETER ,ADVENTURER>>
	 <SETG MOVES 0>)
	(<FSET? ,CHRONOMETER ,MUNGEDBIT>
	 <SETG MOVES ,MUNGED-TIME>)
	(T
	 <SETG MOVES ,INTERNAL-MOVES>)>
  <COND (,P-WON
	 <COND (<NOT <EQUAL? ,C-ELAPSED 0>>
		<SET V <CLOCKER>>)>
	 <SETG P-PRSA-WORD <>>
	 <SETG PRSA <>>
	 <SETG PRSO <>>
	 <SETG PRSI <>>)>>

<ROUTINE TOO-DARK-FOR-IT? ()
	 <COND (<AND <NOT ,LIT>
		     <NOT <HELD? ,P-IT-OBJECT ,WINNER>>
		     <NOT <IN? ,WINNER ,P-IT-OBJECT>>>
		<TELL ,TOO-DARK CR>
		<RTRUE>)>>

<ROUTINE DONT-ALL (OBJ1 "AUX" (L <LOC .OBJ1>))
	 ;"RFALSE if OBJ1 should be included in the ALL, otherwise RTRUE"
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE> ;"TAKE prso FROM prsi and prso isn't in prsi"
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>> ;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL> ;"cases for ALL"
		<COND (<AND ,PRSI
			    <PRSO? ,PRSI>>
		       <RTRUE>)
		      (<VERB? TAKE> 
		       ;"TAKE ALL and object not accessible or takeable"
		       <COND (<AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				   <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>
			      <RTRUE>)
			     (<AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				   <NOT <EQUAL? .L <LOC ,WINNER>>>>
			      <COND (<AND <FSET? .L ,SURFACEBIT>
				     	  <NOT <FSET? .L ,TAKEBIT>>> ;"tray"
				     <RFALSE>)
				    (T
				     <RTRUE>)>)
			     (<AND <NOT ,PRSI>
				   <HELD? ,PRSO>> ;"already have it"
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    ;"VERB ALL, object not held"
			    <NOT <IN? .OBJ1 ,WINNER>>>
		       <RTRUE>)
		      (<AND <VERB? PUT PUT-ON> ;"PUT ALL IN X,obj already in x"
			    <NOT <IN? ,PRSO ,WINNER>>
			    <HELD? ,PRSO ,PRSI>>
		       <RTRUE>)>)>>

;"Name-change and reversal of RTRUE and RFALSE by arb 5/88"
<ROUTINE CLOCKER-VERB? (VRB)
	 <COND (<OR <EQUAL? .VRB ,V?BRIEF ,V?SUPER-BRIEF ,V?VERBOSE>
		    <EQUAL? .VRB ,V?SAVE ,V?RESTORE ,V?SCORE>
		    <EQUAL? .VRB ,V?SCRIPT ,V?UNSCRIPT ,V?TIME>
		    <EQUAL? .VRB ,V?QUIT ,V?RESTART ,V?VERSION>
		    <EQUAL? .VRB ,V?$RANDOM ,V?$RECORD ,V?$UNRECORD>
		    <EQUAL? .VRB ,V?$COMMAND ,V?HINT ,V?HINTS-NO>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

;<GLOBAL L-PRSA <>>
;<GLOBAL L-PRSO <>>
;<GLOBAL L-PRSI <>>

<ROUTINE FAKE-ORPHAN ("OPTIONAL" (IT-WAS-USED <>) "AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <TELL "[Be specific: Wh">
	 <COND (.IT-WAS-USED
		<TELL "at object">)
	       (T
		<TELL "o">)>
	 <TELL " do you want to ">
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?]" CR>>

<ROUTINE PERFORM-PRSA ("OPTIONAL" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" (V <>) OA OO OI)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<AND <ZERO? ,P-WALK-DIR>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<EQUAL? ,IT .I .O>
	              <COND (<VISIBLE? ,P-IT-OBJECT>
			     <COND (<EQUAL? ,IT .O>
				    <SET O ,P-IT-OBJECT>)
				   (T
				    <SET I ,P-IT-OBJECT>)>)
			    (T
			     <COND (<NOT .I>
				    <FAKE-ORPHAN T>)
				   (T
				    <REFERRING>)>
			     <RFATAL>)>)>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <ZERO? ,P-WALK-DIR>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>>
	       <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>
	       <COND (<T? .V>
		      <SETG P-WON <>>)>)>
	<SET O ,PRSO>
	<SET I ,PRSI>
	<THIS-IS-IT ,PRSI>
	<THIS-IS-IT ,PRSO>
	<COND (<ZERO? .V>
	       <SET V <D-APPLY "Actor" <GETP ,WINNER ,P?ACTION>>>)>
	<COND (<ZERO? .V>
	       <SET V <D-APPLY "M-Beg" <GETP ,HERE ,P?ACTION> ,M-BEG>>)>
	<COND (<ZERO? .V>
	       <SET V <D-APPLY "Preaction" <GET ,PREACTIONS .A>>>)>
	<COND (<AND <ZERO? .V>
		    <T? .I>>
	       <SET V <D-APPLY "PRSI" <GETP .I ,P?ACTION>>>)>
	<COND (<AND <ZERO? .V>
		    <T? .O>
	            <NOT <EQUAL? .A ,V?WALK>>>
	       <SET V <D-APPLY "PRSO" <GETP .O ,P?ACTION>>>)>
	<COND (<ZERO? .V>
	       <SET V <D-APPLY <> <GET ,ACTIONS .A>>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>
       
<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       ;<COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "  Default ->" CR>)
			    (T
			     <TELL "  " .STR " -> ">)>)>
	       <SET RES <COND (.FOO
			       <APPLY .FCN .FOO>)
			      (T
			       <APPLY .FCN>)>>
	       ;<COND (<AND ,DEBUG
			   .STR>
		      <COND (<EQUAL? .RES ,M-FATAL>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ> <RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (ELSE
			<SET OBJ <LOC .OBJ>>)>>>
^L

"old CLOCK file"

<CONSTANT C-TABLELEN 240>

<GLOBAL C-TABLE %<COND (<GASSIGNED? PREDGEN>
			'<ITABLE NONE 120>)
		       (T
			'<ITABLE NONE 240>)>>

<GLOBAL C-DEMONS 300>

<GLOBAL C-INTS 240>

<GLOBAL C-ELAPSED 7>

<CONSTANT C-ELAPSED-DEFAULT 7>

<CONSTANT C-INTLEN 6>

<CONSTANT C-ENABLED? 0>

<CONSTANT C-TICK 1>

<CONSTANT C-RTN 2>

;<ROUTINE DEMON (RTN TICK "AUX" CINT)
	 <PUT <SET CINT <INT .RTN T>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<GLOBAL CLOCK-WAIT <>>

;<GLOBAL ELAPSED-MOVES 0>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))
	 ;<SETG ELAPSED-MOVES <+ ,ELAPSED-MOVES 1>>
	 ;<COND (,DEBUG-ON
		<TELL "[Elapsed time: " N ,C-ELAPSED "]" CR>)>
	 ;<COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RETURN .FLG>)
		       (<NOT <0? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<0? .TICK>)
			      (<==? .TICK -1>
			       <COND (<APPLY <GET .C ,C-RTN>>
				      <SET FLG T>)>)
			      (T
			       <PUT .C ,C-TICK <SET TICK <- .TICK ,C-ELAPSED>>>
			       <COND (<NOT <G? .TICK 1>>
				      <PUT .C ,C-TICK 0>
				      <COND (<APPLY <GET .C ,C-RTN>>
					     <SET FLG T>)>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<ROUTINE NULL-F ("OPTIONAL" A1 A2)
	<RFALSE>>

<ROUTINE REFERRING ("OPTIONAL" (HIM-HER <>))
	 <TELL "I don't see wh">
	 <COND (.HIM-HER
		<TELL "o">)
	       (T
		<TELL "at">)>
	 <TELL " you're referring to." CR>>


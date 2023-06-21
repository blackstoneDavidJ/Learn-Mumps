MAIN
	N EXIT,CHOICE
	S EXIT=0
	F  Q:EXIT  D
	. I '$D(^CC) D SC Q
	. W $$GCS("File Anaylizer","GREEN"),!
	. W "1. Add Document",!
	. W "2. Anaylize Document",!
	. W "q. to exit",!
	. R "Choice: ",CHOICE:50,!
	. I CHOICE="" D
	. . W $$INVALIDRESPONSE,!
	. . S EXIT=1
	. E  I CHOICE=1 D ADDDOC Q:EXIT
	. E  I CHOICE=2 D ANYDOC Q:EXIT
	. E  I CHOICE=4 D KILLGLOBALS Q:EXIT
	. E  I CHOICE="q" S EXIT=1
	Q
ADDDOC
	N NAMEAVAL,FILENAME,FILEPATH
	I '$D(^D) S ^D=""
	W "Enter in the file path to your document: ",!
	R FILEPATH:50,!
	I FILEPATH="" W $$INVALIDRESPONSE,!
	E  D
	. W "Enter File Name for document: ",!
	. S NAMEAVAL=0
	. F  Q:NAMEAVAL  D 
	. . R FILENAME:50,!	
	. . S FILENAME=$ZCONVERT(FILENAME,"L")
	. . I FILENAME="" D
	. . . W $$INVALIDRESPONSE,!
	. . . S NAMEAVAL=1 
	. . E  I $D(^D(FILENAME)) W $$GCS("Filename already taken, select another","RED"),!
	. . E  D
	. . . S ^D(FILENAME)=FILEPATH
	. . . W $$GCS("File Successfully added","GREEN"),!
	. . . S NAMEAVAL=1
	Q
ANYDOC
	;	
	Q
INVALIDRESPONSE()
	Q $$GCS("Invalid or Timeout","RED")
GCS(STRING,COLOR)
	Q $C(27)_^CC(COLOR)_STRING_$C(27)_^CC("END")
SC
	S ^CC("BLACK")="[30m"
	S ^CC("RED")="[31m"
	S ^CC("GREEN")="[32m"
	S ^CC("YELLOW")="[33m"
	S ^CC("BLUE")="[34m"
	S ^CC("MAGENTA")="[35m"
	S ^CC("CYAN")="[36m"
	S ^CC("WHITE")="[37m"
	S ^CC("END")="[0m"
	Q
KILLGLOBALS
	K ^D
	K ^CC
	W "Globals have been wiped.",!
	Q
